<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With, Accept, Origin");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

error_reporting(0);
ini_set('display_errors', 0);

$conn = new mysqli("localhost", "root", "", "mytix_db");

if ($conn->connect_error) {
    echo json_encode(["status" => "error", "message" => "Koneksi database gagal: " . $conn->connect_error]);
    exit();
}

$rawInput = file_get_contents("php://input");
$data = json_decode($rawInput, true);

if (!$data) {
    echo json_encode(["status" => "error", "message" => "Payload JSON tidak valid"]);
    exit();
}

// Ambil input secara fleksibel (user_name / username)
$userName      = isset($data['user_name']) ? $data['user_name'] : (isset($data['username']) ? $data['username'] : 'User MyTix');
$userPhone     = isset($data['user_phone']) ? $data['user_phone'] : (isset($data['phone']) ? $data['phone'] : '');
$movieTitle    = isset($data['movie_title']) ? $data['movie_title'] : '';
$cinemaName    = isset($data['cinema_name']) ? $data['cinema_name'] : '';
$dateText      = isset($data['date_text']) ? $data['date_text'] : (isset($data['date']) ? $data['date'] : '');
$timeText      = isset($data['time_text']) ? $data['time_text'] : (isset($data['time']) ? $data['time'] : '');
$seats         = isset($data['seats']) ? $data['seats'] : '';
$paymentMethod = isset($data['payment_method']) ? $data['payment_method'] : 'QRIS';
$totalPrice    = isset($data['total_price']) ? intval($data['total_price']) : 0;

$stmt = $conn->prepare("INSERT INTO transactions (user_name, user_phone, movie_title, cinema_name, date_text, time_text, seats, payment_method, total_price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
$stmt->bind_param("ssssssssi", $userName, $userPhone, $movieTitle, $cinemaName, $dateText, $timeText, $seats, $paymentMethod, $totalPrice);

if ($stmt->execute()) {
    $insertId = $stmt->insert_id;
    $orderId  = "TIX-MOV-" . str_pad($insertId, 5, "0", STR_PAD_LEFT);
    echo json_encode([
        "status"   => "success",
        "message"  => "Transaksi bioskop berhasil disimpan",
        "order_id" => $orderId
    ]);
} else {
    echo json_encode([
        "status"  => "error",
        "message" => "Gagal simpan transaksi: " . $stmt->error
    ]);
}

$stmt->close();
$conn->close();
?>