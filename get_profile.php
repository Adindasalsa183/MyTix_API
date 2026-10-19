<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$conn = new mysqli("localhost", "root", "", "mytix_db");

if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Koneksi Database Gagal"]));
}

// Ambil user yang paling baru terdaftar di tabel users
$result = $conn->query("SELECT nama_lengkap, nomor_hp FROM users ORDER BY id DESC LIMIT 1");

if ($result && $user = $result->fetch_assoc()) {
    echo json_encode([
        "status" => "success",
        "name"   => $user['nama_lengkap'],
        "phone"  => $user['nomor_hp']
    ]);
} else {
    echo json_encode([
        "status" => "error",
        "message" => "User tidak ditemukan"
    ]);
}

$conn->close();
?>