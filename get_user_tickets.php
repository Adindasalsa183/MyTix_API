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
    echo json_encode(["status" => "error", "message" => "Koneksi database gagal"]);
    exit();
}

$tickets = [];

// 1. Tiket Event
$sqlEvent = "SELECT 
                id, 
                IFNULL(show_title, IFNULL(event_title, 'Event TIX')) AS title, 
                IFNULL(venue, 'Lokasi Event') AS venue, 
                IFNULL(event_date, '') AS subtitle, 
                IFNULL(payment_method, 'QRIS') AS details, 
                IFNULL(total_price, 0) AS total_price, 
                'Event' AS category 
             FROM tix_event_orders 
             ORDER BY id DESC";
$resEvent = $conn->query($sqlEvent);
if ($resEvent && $resEvent->num_rows > 0) {
    while ($row = $resEvent->fetch_assoc()) {
        $tickets[] = $row;
    }
}

// 2. Tiket Makanan (Disesuaikan dengan kolom item_title)
$sqlFood = "SELECT 
                id, 
                IFNULL(item_title, 'Pesanan Makanan') AS title, 
                IFNULL(cinema_name, 'TIX Food') AS venue, 
                IFNULL(created_at, '') AS subtitle, 
                '1 Porsi' AS details, 
                IFNULL(total_price, 0) AS total_price, 
                'Makanan' AS category 
            FROM tix_food_orders 
            ORDER BY id DESC";
$resFood = $conn->query($sqlFood);
if ($resFood && $resFood->num_rows > 0) {
    while ($row = $resFood->fetch_assoc()) {
        $tickets[] = $row;
    }
}

// 3. Tiket Film Bioskop
$sqlMovie = "SELECT 
                id, 
                IFNULL(movie_title, 'Tiket Nonton') AS title, 
                IFNULL(cinema_name, 'Bioskop') AS venue, 
                CONCAT(IFNULL(date_text, ''), ' | ', IFNULL(time_text, '')) AS subtitle, 
                CONCAT('Kursi: ', IFNULL(seats, '-')) AS details, 
                IFNULL(total_price, 0) AS total_price, 
                'Film' AS category 
             FROM transactions 
             ORDER BY id DESC";
$resMovie = $conn->query($sqlMovie);
if ($resMovie && $resMovie->num_rows > 0) {
    while ($row = $resMovie->fetch_assoc()) {
        $tickets[] = $row;
    }
}

echo json_encode([
    "status" => "success",
    "total"  => count($tickets),
    "data"   => $tickets
]);

$conn->close();
?>