<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$conn = new mysqli("localhost", "root", "", "mytix_db");

if ($conn->connect_error) {
    echo json_encode(["status" => "error", "message" => "Koneksi database gagal"]);
    exit();
}

$input = json_decode(file_get_contents('php://input'), true);

$username       = isset($input['username']) && !empty($input['username']) ? $conn->real_escape_string(trim($input['username'])) : 'User MyTix';
$cinema_name    = isset($input['cinema_name']) ? $conn->real_escape_string($input['cinema_name']) : '';
$item_title     = isset($input['item_title']) ? $conn->real_escape_string($input['item_title']) : '';
$total_price    = isset($input['total_price']) ? intval($input['total_price']) : 0;
$payment_method = isset($input['payment_method']) ? $conn->real_escape_string($input['payment_method']) : 'QRIS';

if (empty($cinema_name) || empty($item_title)) {
    echo json_encode(["status" => "error", "message" => "Data pesanan tidak lengkap."]);
    exit();
}

$sql = "INSERT INTO tix_food_orders (username, cinema_name, item_title, total_price, payment_method, payment_status) 
        VALUES ('$username', '$cinema_name', '$item_title', $total_price, '$payment_method', 'SUCCESS')";

if ($conn->query($sql) === TRUE) {
    $order_id = $conn->insert_id;
    echo json_encode([
        "status" => "success",
        "message" => "Pesanan berhasil disimpan!",
        "order_id" => "TIXF-" . str_pad($order_id, 6, "0", STR_PAD_LEFT)
    ]);
} else {
    echo json_encode(["status" => "error", "message" => "Gagal menyimpan: " . $conn->error]);
}

$conn->close();
?>