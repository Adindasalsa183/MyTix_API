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
    echo json_encode(["status" => "error", "message" => "Koneksi DB gagal: " . $conn->connect_error]);
    exit();
}

$rawInput = file_get_contents("php://input");
$data = json_decode($rawInput, true);

if (!$data) {
    echo json_encode(["status" => "error", "message" => "Payload JSON tidak valid"]);
    exit();
}

// Tangkap data dan bersihkan
$username      = !empty($data['username']) ? $conn->real_escape_string($data['username']) : 'Angela';
$email         = !empty($data['email']) ? $conn->real_escape_string($data['email']) : 'user@mytix.com';
$phone         = !empty($data['phone']) ? $conn->real_escape_string($data['phone']) : '081234567890';
$eventSlug     = !empty($data['event_slug']) ? $conn->real_escape_string($data['event_slug']) : 'jfw-2026';
$eventTitle    = !empty($data['event_title']) ? $conn->real_escape_string($data['event_title']) : 'Jakarta Film Week 2026';
$showTitle     = !empty($data['show_title']) ? $conn->real_escape_string($data['show_title']) : 'Program Event';
$eventDate     = !empty($data['event_date']) ? $conn->real_escape_string($data['event_date']) : '21 OCT';
$venue         = !empty($data['venue']) ? $conn->real_escape_string($data['venue']) : 'CGV GRAND INDONESIA';
$paymentMethod = !empty($data['payment_method']) ? $conn->real_escape_string($data['payment_method']) : 'QRIS';
$paymentStatus = 'SUCCESS';

$rawPrice   = isset($data['total_price']) ? (string)$data['total_price'] : '4000';
$cleanPrice = preg_replace('/[^0-9]/', '', $rawPrice);
$totalPrice = !empty($cleanPrice) ? (int)$cleanPrice : 4000;

// Query SQL menyimpan email & phone ke database
$sql = "INSERT INTO tix_event_orders 
        (username, email, phone, event_slug, event_title, show_title, event_date, venue, total_price, payment_method, payment_status) 
        VALUES 
        ('$username', '$email', '$phone', '$eventSlug', '$eventTitle', '$showTitle', '$eventDate', '$venue', $totalPrice, '$paymentMethod', '$paymentStatus')";

if ($conn->query($sql) === TRUE) {
    $insertId = $conn->insert_id;
    $orderId  = "EVT-" . str_pad($insertId, 6, "0", STR_PAD_LEFT);
    echo json_encode([
        "status"   => "success",
        "message"  => "Order Event berhasil disimpan ke database",
        "order_id" => $orderId
    ]);
} else {
    echo json_encode([
        "status"  => "error",
        "message" => "Gagal simpan SQL: " . $conn->error
    ]);
}

$conn->close();
?>