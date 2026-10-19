<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json; charset=UTF-8");

$conn = new mysqli("localhost", "root", "", "mytix_db");

if ($conn->connect_error) {
    die(json_encode(["success" => false, "message" => "Database connection failed"]));
}

$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['movie_title']) && isset($data['price'])) {
    $order_id = "RENT-" . time() . rand(100, 999);
    $user_name = $conn->real_escape_string($data['user_name'] ?? 'Guest');
    $user_phone = $conn->real_escape_string($data['user_phone'] ?? '-');
    $user_email = $conn->real_escape_string($data['user_email'] ?? 'user@mytix.id');
    $movie_title = $conn->real_escape_string($data['movie_title']);
    $rental_type = $conn->real_escape_string($data['rental_type'] ?? 'Sewa HD');
    $price = floatval($data['price']);
    $payment_method = $conn->real_escape_string($data['payment_method'] ?? 'QRIS');

    $sql = "INSERT INTO movie_rentals (order_id, user_name, user_phone, user_email, movie_title, rental_type, price, payment_method, rental_status) 
            VALUES ('$order_id', '$user_name', '$user_phone', '$user_email', '$movie_title', '$rental_type', $price, '$payment_method', 'ACTIVE')";

    if ($conn->query($sql) === TRUE) {
        echo json_encode([
            "success" => true,
            "message" => "Sewa film berhasil disimpan!",
            "order_id" => $order_id
        ]);
    } else {
        echo json_encode(["success" => false, "message" => "Gagal: " . $conn->error]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Data tidak lengkap"]);
}

$conn->close();
?>