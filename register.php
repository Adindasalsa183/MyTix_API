<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Content-Type: application/json; charset=UTF-8");

// Penanganan Preflight CORS
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// 1. KONEKSI DATABASE
$conn = new mysqli("localhost", "root", "", "mytix_db");

if ($conn->connect_error) {
    echo json_encode(["success" => false, "status" => "error", "message" => "Koneksi database gagal: " . $conn->connect_error]);
    exit();
}

// 2. BACA INPUT (Dari Query URL GET atau Body JSON POST)
$rawInput = file_get_contents("php://input");
$bodyData = json_decode($rawInput, true) ?? [];

// Ambil parameter action dari GET atau POST JSON (default: register)
$action = $_GET['action'] ?? $bodyData['action'] ?? 'register';

// Ambil data nama & nomor HP
$nama = $bodyData['nama_lengkap'] ?? $bodyData['name'] ?? $_GET['nama_lengkap'] ?? '';
$hp   = $bodyData['nomor_hp'] ?? $bodyData['phone'] ?? $_GET['nomor_hp'] ?? '';

// Normalisasi nomor HP agar berformat +62 secara konsisten
if (!empty($hp)) {
    if (strpos($hp, '+62') !== 0) {
        if (strpos($hp, '0') === 0) {
            $hp = '+62' . substr($hp, 1);
        } else {
            $hp = '+62' . $hp;
        }
    }
}

// ------------------------------------------------------------------
// 3. LOGIKA AKSI LOGIN / CEK PROFIL
// ------------------------------------------------------------------
if ($action === 'login' || $_SERVER['REQUEST_METHOD'] === 'GET') {
    if (empty($hp)) {
        echo json_encode(["success" => false, "status" => "error", "message" => "Nomor HP wajib diisi!"]);
        exit();
    }

    $stmt = $conn->prepare("SELECT * FROM users WHERE nomor_hp = ? LIMIT 1");
    $stmt->bind_param("s", $hp);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result && $result->num_rows > 0) {
        $user = $result->fetch_assoc();
        echo json_encode([
            "success" => true,
            "status" => "success",
            "message" => "Login berhasil!",
            "nama_lengkap" => $user['nama_lengkap'] ?? '',
            "nomor_hp" => $user['nomor_hp'] ?? '',
            "data" => $user
        ]);
    } else {
        echo json_encode([
            "success" => false,
            "status" => "error",
            "message" => "Nomor HP belum terdaftar"
        ]);
    }
    $stmt->close();
    $conn->close();
    exit();
}

// ------------------------------------------------------------------
// 4. LOGIKA AKSI REGISTRASI (REGISTER)
// ------------------------------------------------------------------
if ($action === 'register' || $_SERVER['REQUEST_METHOD'] === 'POST') {
    if (empty($nama) || empty($hp)) {
        echo json_encode(["success" => false, "status" => "error", "message" => "Nama lengkap dan nomor HP wajib diisi!"]);
        exit();
    }

    // Cek apakah nomor HP sudah terdaftar sebelumnya
    $checkStmt = $conn->prepare("SELECT id FROM users WHERE nomor_hp = ? LIMIT 1");
    $checkStmt->bind_param("s", $hp);
    $checkStmt->execute();
    $checkResult = $checkStmt->get_result();

    if ($checkResult && $checkResult->num_rows > 0) {
        echo json_encode([
            "success" => false,
            "status" => "error",
            "message" => "Nomor HP sudah terdaftar. Silakan lakukan Login."
        ]);
        $checkStmt->close();
        $conn->close();
        exit();
    }
    $checkStmt->close();

    // Query Simpan User Baru
    $stmt = $conn->prepare("INSERT INTO users (nama_lengkap, nomor_hp, created_at, updated_at) VALUES (?, ?, NOW(), NOW())");

    if (!$stmt) {
        // Fallback jika struktur tabel users tidak memiliki kolom created_at / updated_at
        $stmtAlt = $conn->prepare("INSERT INTO users (nama_lengkap, nomor_hp) VALUES (?, ?)");
        $stmtAlt->bind_param("ss", $nama, $hp);
        $success = $stmtAlt->execute();
        $errorMsg = $stmtAlt->error;
        $stmtAlt->close();
    } else {
        $stmt->bind_param("ss", $nama, $hp);
        $success = $stmt->execute();
        $errorMsg = $stmt->error;
        $stmt->close();
    }

    if ($success) {
        echo json_encode([
            "success" => true,
            "status" => "success",
            "message" => "Berhasil terdaftar di phpMyAdmin!",
            "nama_lengkap" => $nama,
            "nomor_hp" => $hp
        ]);
    } else {
        echo json_encode([
            "success" => false,
            "status" => "error",
            "message" => "Gagal menyimpan ke database: " . $errorMsg
        ]);
    }

    $conn->close();
    exit();
}
?>