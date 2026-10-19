-- phpMyAdmin SQL Dump
-- version 6.0.0-dev+20261007.cdc90e2a8d
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 19, 2026 at 04:15 PM
-- Server version: 8.4.3
-- PHP Version: 8.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mytix_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `movie_rentals`
--
CREATE TABLE `movie_rentals` (
  `id` int NOT NULL,
  `order_id` varchar(50) NOT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `user_phone` varchar(20) DEFAULT NULL,
  `user_email` varchar(100) DEFAULT 'user@mytix.id',
  `movie_title` varchar(150) NOT NULL,
  `rental_type` varchar(20) NOT NULL DEFAULT 'SEWA_HD',
  `price` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) NOT NULL DEFAULT 'Google Pay (QRIS)',
  `rental_status` enum('PENDING','ACTIVE','EXPIRED') DEFAULT 'ACTIVE',
  `rented_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `expires_at` datetime DEFAULT ((now() + interval 30 day))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `movie_rentals`
--

INSERT INTO `movie_rentals` (`id`, `order_id`, `user_name`, `user_phone`, `user_email`, `movie_title`, `rental_type`, `price`, `payment_method`, `rental_status`, `rented_at`, `expires_at`) VALUES
(1, 'RENT-1792149432855', NULL, NULL, 'user@mytix.id', 'NOW YOU SEE ME', 'Sewa HD', 28000.00, 'Google Pay (QRIS)', 'ACTIVE', '2026-10-16 18:17:12', '2026-11-15 18:17:12'),
(2, 'RENT-1792149717702', NULL, NULL, 'user@mytix.id', 'MAN OF STEEL', 'Sewa HD', 28000.00, 'Google Pay (QRIS)', 'ACTIVE', '2026-10-16 18:21:57', '2026-11-15 18:21:57'),
(3, 'RENT-1792149741178', NULL, NULL, 'user@mytix.id', 'SMURFS : THE LOST VILLAGE', 'Beli HD', 74000.00, 'Google Pay (QRIS)', 'ACTIVE', '2026-10-16 18:22:21', '2026-11-15 18:22:21'),
(4, 'RENT-1792149875991', NULL, NULL, 'user@mytix.id', 'SMURFS : THE LOST VILLAGE', 'Sewa HD', 28000.00, 'Google Pay (QRIS)', 'ACTIVE', '2026-10-16 18:24:35', '2026-11-15 18:24:35'),
(5, 'RENT-1792150043974', NULL, NULL, 'user@mytix.id', 'SMURFS : THE LOST VILLAGE', 'Beli HD', 60000.00, 'QRIS / E-Wallet', 'ACTIVE', '2026-10-16 18:27:23', '2026-11-15 18:27:23'),
(6, 'RENT-1792156153753', 'Nandila', '08821421321', 'nanndd@gmail.com', 'THE NUN II', 'Sewa HD', 32000.00, 'BCA Virtual Account', 'ACTIVE', '2026-10-16 20:09:13', '2026-11-15 20:09:13'),
(7, 'RENT-1792241448302', 'Arofah', '08827183516', 'arofah@gmail.com', 'SMURFS : THE LOST VILLAGE', 'Sewa HD', 22000.00, 'QRIS / E-Wallet', 'ACTIVE', '2026-10-17 19:50:48', '2026-11-16 19:50:48'),
(8, 'RENT-1792423217280', 'Fariha', '088261526', 'fariha@gmail.com', 'SMURFS : THE LOST VILLAGE', 'Sewa HD', 22000.00, 'QRIS / E-Wallet', 'ACTIVE', '2026-10-19 22:20:17', '2026-11-18 22:20:17');

-- --------------------------------------------------------

--
-- Table structure for table `tix_event_orders`
--
CREATE TABLE `tix_event_orders` (
  `id` int NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `event_slug` varchar(100) NOT NULL,
  `event_title` varchar(255) NOT NULL,
  `show_title` varchar(255) NOT NULL,
  `event_date` varchar(20) NOT NULL,
  `venue` varchar(255) NOT NULL,
  `total_price` int DEFAULT '0',
  `payment_method` varchar(50) DEFAULT 'QRIS',
  `payment_status` varchar(20) DEFAULT 'SUCCESS',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tix_event_orders`
--

INSERT INTO `tix_event_orders` (`id`, `username`, `email`, `phone`, `event_slug`, `event_title`, `show_title`, `event_date`, `venue`, `total_price`, `payment_method`, `payment_status`, `created_at`) VALUES
(1, 'Angela', NULL, NULL, 'jfw-2026', 'Jakarta Film Week 2026', 'Encounters of the Martial Mind : A Masterclass with Sammo Hung', '21 OCT', 'CGV GRAND INDONESIA | GI - Audi 2 | 17+ - 19:00', 4000, 'QRIS', 'SUCCESS', '2026-10-15 17:39:48'),
(2, 'Angela', NULL, NULL, 'jfw-2026', 'Jakarta Film Week 2026', 'Program Talk & Industri Talk', '23 OCT', 'CGV GRAND INDONESIA | GI - Audi 1 | 15+ - 14:00', 4000, 'QRIS', 'SUCCESS', '2026-10-15 17:41:56'),
(3, 'Angela', NULL, NULL, 'jfw-2026', 'Jakarta Film Week 2026', 'The Tasters & Burn', '24 OCT', 'CGV GRAND INDONESIA | GI - Audi 2 | 17+ - 16:30', 4000, 'QRIS', 'SUCCESS', '2026-10-15 17:44:03'),
(4, 'Lucas', NULL, NULL, 'jfw-2026', 'Jakarta Film Week 2026', 'Program Talk & Industri Talk', '23 OCT', 'CGV GRAND INDONESIA | GI - Audi 1 | 15+ - 14:00', 4000, 'QRIS', 'SUCCESS', '2026-10-16 10:46:05'),
(5, 'Kevin J', NULL, NULL, 'jfw-2026', 'Jakarta Film Week 2026', 'The Girl with the Leica & Seporsi Mie Ayam Sebelum Mati', '25 OCT', 'CGV GRAND INDONESIA | GI - Audi 3 | 13+ - 18:30', 4000, 'QRIS', 'SUCCESS', '2026-10-16 10:51:00'),
(6, 'Nadeo', NULL, NULL, 'jfw-2026', 'Jakarta Film Week 2026', 'The Girl with the Leica & Seporsi Mie Ayam Sebelum Mati', '25 OCT', 'CGV GRAND INDONESIA | GI - Audi 3 | 13+ - 18:30', 4000, 'QRIS', 'SUCCESS', '2026-10-16 10:54:48'),
(7, 'Nadine', NULL, NULL, 'cares-2026', 'CARES 2026', 'SYMPOSIUM FOR Specialist', '31 OCT 2026', 'The Westin Hotel Jakarta', 1000000, 'QRIS', 'SUCCESS', '2026-10-16 11:04:41'),
(8, 'Arumi', NULL, NULL, 'cares-2026', 'CARES 2026', 'SYMPOSIUM FOR GP', '31 OCT 2026', 'The Westin Hotel Jakarta', 500000, 'QRIS', 'SUCCESS', '2026-10-17 05:06:55'),
(9, 'Syahrin', 'syaahrin@gmail.com', '+62812635161', 'jfw-2026', 'Jakarta Film Week 2026', 'Program Talk & Industri Talk', '23 OCT', 'CGV GRAND INDONESIA | GI - Audi 1 | 15+ - 14:00', 4000, 'QRIS', 'SUCCESS', '2026-10-18 16:22:17'),
(10, 'Miranda', 'miranda@gmail.com', '+6281926153', 'cares-2026', 'CARES 2026', 'SYMPOSIUM + WORKSHOP FROM INDICATION TO INSERTION FOR GP | Presale', '31 OCT 2026', 'The Westin Hotel Jakarta', 500000, 'DANA', 'SUCCESS', '2026-10-18 17:52:37'),
(11, 'Jeje', 'jejee@gmail.com', '+6281389163', 'cares-2026', 'CARES 2026', 'SYMPOSIUM + WORKSHOP Modern PCI: SEE Beyond Angiography - Physiology (FFR) & Intravascular Imaging (IVUS)', '31 OCT 2026', 'The Westin Hotel Jakarta', 200000, 'QRIS', 'SUCCESS', '2026-10-19 04:01:20'),
(12, 'Rifa', 'rrifa@gmail.com', '+62822682516', 'jfw-2026', 'Jakarta Film Week 2026', 'The Girl with the Leica & Seporsi Mie Ayam Sebelum Mati', '25 OCT', 'CGV GRAND INDONESIA | GI - Audi 3 | 13+ - 18:30', 4000, 'SHOPEEPAY', 'SUCCESS', '2026-10-19 14:39:19'),
(13, 'Fariha', 'fariha@gmail.com', '+6281278361', 'cares-2026', 'CARES 2026', 'SYMPOSIUM FOR Specialist', '31 OCT 2026', 'The Westin Hotel Jakarta', 1000000, 'QRIS', 'SUCCESS', '2026-10-19 15:17:37');

-- --------------------------------------------------------

--
-- Table structure for table `tix_food_orders`
--
CREATE TABLE `tix_food_orders` (
  `id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `cinema_name` varchar(100) NOT NULL,
  `item_title` varchar(100) NOT NULL,
  `total_price` int NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `payment_status` varchar(20) DEFAULT 'SUCCESS',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tix_food_orders`
--

INSERT INTO `tix_food_orders` (`id`, `username`, `cinema_name`, `item_title`, `total_price`, `payment_method`, `payment_status`, `created_at`) VALUES
(1, 'mikasa', 'ROYAL XXI', 'STIXX PANDAN KAYA', 35000, 'QRIS', 'SUCCESS', '2026-10-15 17:03:25'),
(2, 'mikasa', 'PAKUWON CITY XXI', 'PAKET GOOLLL!', 100000, 'QRIS', 'SUCCESS', '2026-10-15 17:09:37'),
(3, 'mikasa', 'BG JUNCTION CGV', 'SNACK ATTACK', 50000, 'Virtual Account', 'SUCCESS', '2026-10-16 17:29:40'),
(4, 'mikasa', 'CIPUTRA WORLD XXI', 'FAMILY COMBO', 200000, 'Virtual Account', 'SUCCESS', '2026-10-17 04:37:27'),
(5, 'Melvin', 'TRANS ICON MALL XXI', 'STIXX PANDAN KAYA', 35000, 'QRIS', 'SUCCESS', '2026-10-17 04:42:21'),
(6, 'Melvin', 'BG JUNCTION CGV', 'SNACK ATTACK', 50000, 'Virtual Account', 'SUCCESS', '2026-10-17 04:47:02'),
(7, 'Melvin', 'ROYAL XXI', 'PAKET GOOLLL!', 100000, 'QRIS', 'SUCCESS', '2026-10-17 04:57:12'),
(8, 'Arumi', 'PAKUWON CITY XXI', 'CLASSIC COMBO', 50000, 'QRIS', 'SUCCESS', '2026-10-17 05:00:13'),
(9, 'Arumi', 'BG JUNCTION CGV', 'SNACK ATTACK', 50000, 'Virtual Account', 'SUCCESS', '2026-10-17 05:05:16'),
(10, 'Arumi', 'ROYAL XXI', 'SNACK ATTACK', 50000, 'QRIS', 'SUCCESS', '2026-10-17 05:13:39'),
(11, 'Arumi', 'PAKUWON CITY XXI', 'CLASSIC COMBO', 50000, 'QRIS', 'SUCCESS', '2026-10-17 05:18:16'),
(12, 'Arsylla', 'TRANS ICON MALL XXI', 'PAKET GOOLLL!', 100000, 'QRIS', 'SUCCESS', '2026-10-17 05:23:54'),
(13, 'Steven', 'TRANS ICON MALL XXI', 'SNACK ATTACK', 50000, 'QRIS', 'SUCCESS', '2026-10-17 05:48:38'),
(14, 'Steven', 'CIPUTRA WORLD XXI', 'STIXX PANDAN KAYA', 35000, 'QRIS', 'SUCCESS', '2026-10-17 05:52:45'),
(15, 'Akbar', 'CIPUTRA WORLD XXI', 'FAMILY COMBO', 200000, 'Virtual Account', 'SUCCESS', '2026-10-17 05:55:04'),
(16, 'Steven', 'PAKUWON CITY XXI', 'STIXX PANDAN KAYA', 35000, 'QRIS', 'SUCCESS', '2026-10-17 05:59:35'),
(17, 'Arofah', 'PAKUWON CITY XXI', 'SNACK ATTACK', 50000, 'QRIS', 'SUCCESS', '2026-10-17 12:41:29'),
(18, 'Azizah', 'TRANS ICON MALL XXI', 'SNACK ATTACK', 50000, 'QRIS', 'SUCCESS', '2026-10-17 13:34:18'),
(19, 'Rebecca', 'BG JUNCTION CGV', 'CLASSIC COMBO', 50000, 'QRIS', 'SUCCESS', '2026-10-17 14:35:26'),
(20, 'Miranda', 'BG JUNCTION CGV', 'SNACK ATTACK', 50000, 'Virtual Account', 'SUCCESS', '2026-10-18 17:50:47'),
(21, 'Jeje', 'CIPUTRA WORLD XXI', 'FAMILY COMBO', 200000, 'QRIS', 'SUCCESS', '2026-10-19 03:58:59'),
(22, 'Rifa', 'PAKUWON CITY XXI', 'PAKET GOOLLL!', 100000, 'QRIS', 'SUCCESS', '2026-10-19 14:32:22'),
(23, 'Fariha', 'CIPUTRA WORLD XXI', 'STIXX PANDAN KAYA', 35000, 'QRIS', 'SUCCESS', '2026-10-19 15:13:48');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--
CREATE TABLE `transactions` (
  `id` int NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_phone` varchar(30) NOT NULL,
  `movie_title` varchar(150) NOT NULL,
  `cinema_name` varchar(100) NOT NULL,
  `date_text` varchar(50) NOT NULL,
  `time_text` varchar(20) NOT NULL,
  `seats` varchar(100) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `total_price` int NOT NULL,
  `status` varchar(30) DEFAULT 'BERHASIL',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `user_name`, `user_phone`, `movie_title`, `cinema_name`, `date_text`, `time_text`, `seats`, `payment_method`, `total_price`, `status`, `created_at`) VALUES
(1, 'Budi Santoso', '081234567890', 'KUASA GELAP: PERJANJIAN DAR...', 'ROYAL XXI', '16 Okt', '19:25', 'H2, H3, H4, H5', 'QRIS', 136000, 'BERHASIL', '2026-10-16 14:48:54'),
(2, 'Maika', '081234567890', 'KUASA GELAP: PERJANJIAN DAR...', 'ROYAL XXI', '16 Okt', '19:25', 'K6, K7', 'QRIS', 68000, 'BERHASIL', '2026-10-16 15:04:25'),
(3, 'Maika', '081234567890', 'KUASA GELAP: PERJANJIAN DAR...', 'BG JUNCTION CGV', '27 Okt', '19:25', 'H2, H3, H4, H5', 'QRIS', 136000, 'BERHASIL', '2026-10-16 15:11:05'),
(4, 'Maika', '089531234567', 'OTHER MOMMY', 'BG JUNCTION CGV', '22 Okt', '17:15', 'L4, L5', 'QRIS', 68000, 'BERHASIL', '2026-10-16 15:15:30'),
(5, 'User Baru', '08123456789', 'STREET FIGHTER', 'PAKUWON CITY XXI', '18 Okt', '19:25', 'F6, F7', 'QRIS', 68000, 'BERHASIL', '2026-10-16 15:19:39'),
(6, 'User Baru', '08123456789', 'IBU, BAGAIMANA AKU TANPAMU?', 'ROYAL XXI', '18 Okt', '12:55', 'D4, D5', 'QRIS', 68000, 'BERHASIL', '2026-10-16 15:31:44'),
(7, 'Naura', '+628821926182', 'STREET FIGHTER', 'PAKUWON CITY XXI', '16 Okt', '20:20', 'J4, J5', 'QRIS', 68000, 'BERHASIL', '2026-10-16 16:10:47'),
(8, 'Putri', '+628221256177', 'KUASA GELAP: PERJANJIAN DAR...', 'TRANS ICON MALL XXI', '16 Okt', '21:15', 'M8', 'QRIS', 34000, 'BERHASIL', '2026-10-16 16:15:38'),
(9, 'Michelle', '+628226715261', 'IBU, BAGAIMANA AKU TANPAMU?', 'TRANS ICON MALL XXI', '16 Okt', '21:30', 'L6', 'QRIS', 34000, 'BERHASIL', '2026-10-16 16:28:48'),
(10, 'Kenzi', '+62882819272', 'KUASA GELAP: PERJANJIAN DAR...', 'PAKUWON CITY XXI', '17 Okt', '20:45', 'H4, H5', 'Transfer Bank (VA)', 68000, 'BERHASIL', '2026-10-16 17:26:22'),
(11, 'Chikaa', '+62882192617', 'STREET FIGHTER', 'BG JUNCTION CGV', '17 Okt', '18:10', 'M6, M7, M8, M9', 'Transfer Bank (VA)', 136000, 'BERHASIL', '2026-10-16 17:29:13'),
(12, 'Melvin', '+62882183611', 'IBU, BAGAIMANA AKU TANPAMU?', 'Ciputra World XXI', '17 Okt', '21:45', 'G6, G7', 'Transfer Bank (VA)', 68000, 'BERHASIL', '2026-10-17 04:36:43'),
(13, 'Arumi', '+628828196315', 'STREET FIGHTER', 'PAKUWON CITY XXI', '16 Okt', '20:20', 'K6, K7', 'Transfer Bank (VA)', 68000, 'BERHASIL', '2026-10-17 05:05:48'),
(14, 'Arsylla', '+62822172611', 'OTHER MOMMY', 'PAKUWON CITY XXI', '16 Okt', '17:40', 'J2, J3, J4', 'QRIS', 102000, 'BERHASIL', '2026-10-17 05:28:32'),
(15, 'Steven', '+62882156421', 'KUASA GELAP: PERJANJIAN DAR...', 'PAKUWON CITY XXI', '16 Okt', '19:15', 'K6, K7', 'QRIS', 68000, 'BERHASIL', '2026-10-17 06:00:04'),
(16, 'Rebecca', '+62812713611', 'STREET FIGHTER', 'ROYAL XXI', '17 Okt', '17:45', 'M4, M5', 'QRIS', 68000, 'BERHASIL', '2026-10-17 14:24:09'),
(17, 'Miranda', '+6281926153', 'WARGA RUSUN 609', 'Ciputra World XXI', '19 Okt', '17:10', 'J4, J5', 'QRIS', 68000, 'BERHASIL', '2026-10-18 17:49:37'),
(18, 'Jeje', '+6281389163', 'IBU, BAGAIMANA AKU TANPAMU?', 'TRANS ICON MALL XXI', '19 Okt', '15:30', 'F3, F4, F5', 'QRIS', 102000, 'BERHASIL', '2026-10-19 03:57:01'),
(19, 'Rifa', '+62822682516', 'KUASA GELAP: PERJANJIAN DAR...', 'PAKUWON CITY XXI', '19 Okt', '20:15', 'L4, L5', 'QRIS', 78000, 'BERHASIL', '2026-10-19 14:33:42'),
(20, 'Fariha', '+6281278361', 'WARGA RUSUN 609', 'Ciputra World XXI', '23 Okt', '17:10', 'D2, D3, D4, D5', 'QRIS', 136000, 'BERHASIL', '2026-10-19 15:09:41'),
(21, 'Fariha', '+6281278361', 'KUASA GELAP: PERJANJIAN DAR...', 'CIPUTRA WORLD XXI', '19 Okt', '19:25', 'H4, H5', 'Transfer Bank (VA)', 68000, 'BERHASIL', '2026-10-19 15:21:56');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--
CREATE TABLE `users` (
  `id` int NOT NULL,
  `nama_lengkap` varchar(255) NOT NULL,
  `nomor_hp` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nama_lengkap`, `nomor_hp`, `created_at`, `updated_at`) VALUES
(1, 'Adinda Salsa', '+6288214763968', '2026-10-14 22:15:48', '2026-10-14 22:15:48'),
(2, 'Steven', '+628832613581', '2026-10-14 22:25:14', '2026-10-14 22:25:14'),
(3, 'Nanda', '+6288137854615', '2026-10-14 22:31:08', '2026-10-14 22:31:08'),
(4, 'Miranda', '+62857271326', '2026-10-14 22:34:22', '2026-10-14 22:34:22'),
(5, 'Anindya', '+628826143512', '2026-10-14 22:36:08', '2026-10-14 22:36:08'),
(6, 'Nendraa', '+62882132517', '2026-10-14 22:50:05', '2026-10-14 22:50:05'),
(7, 'Keenan', '+628132615361', '2026-10-14 23:21:13', '2026-10-14 23:21:13'),
(8, 'Nando', '+628122174315', '2026-10-14 23:22:18', '2026-10-14 23:22:18'),
(9, 'Neona', '+628132172122', '2026-10-14 23:26:25', '2026-10-14 23:26:25'),
(10, 'Mayra', '+628121573415', '2026-10-14 23:40:54', '2026-10-14 23:40:54'),
(11, 'Namirah', '+6288218731615', '2026-10-14 23:50:03', '2026-10-14 23:50:03'),
(12, 'David', '+6288213671532', '2026-10-14 23:59:00', '2026-10-14 23:59:00'),
(13, 'Jaka', '+62882819111', '2026-10-15 00:11:53', '2026-10-15 00:11:53'),
(14, 'Kenjiro', '+62882172891', '2026-10-15 00:51:38', '2026-10-15 00:51:38'),
(15, 'Neysa', '+6281371366151', '2026-10-15 01:17:28', '2026-10-15 01:17:28'),
(16, 'Bennadi', '+6281363512', '2026-10-15 02:05:36', '2026-10-15 02:05:36'),
(17, 'Mikasa', '+6281261521621', '2026-10-15 06:36:32', '2026-10-15 06:36:32'),
(18, 'Aktar', '+6288216351', '2026-10-15 07:08:43', '2026-10-15 07:08:43'),
(19, 'Ben', '+62813153216', '2026-10-15 07:20:32', '2026-10-15 07:20:32'),
(20, 'Anchika', '+6288256714', '2026-10-15 09:05:29', '2026-10-15 09:05:29'),
(21, 'Marsel', '+6281378612', '2026-10-15 09:21:07', '2026-10-15 09:21:07'),
(22, 'Nabila', '+62882126716', '2026-10-15 10:31:55', '2026-10-15 10:31:55'),
(23, 'Angela', '+62813823716', '2026-10-15 10:36:55', '2026-10-15 10:36:55'),
(24, 'Nabil', '+62812316317', '2026-10-16 03:32:07', '2026-10-16 03:32:07'),
(25, 'Lucas', '+6281236521', '2026-10-16 03:44:37', '2026-10-16 03:44:37'),
(26, 'Sandy', '+6281297186', '2026-10-16 04:26:18', '2026-10-16 04:26:18'),
(27, 'Maika', '+62812715361', '2026-10-16 07:22:15', '2026-10-16 07:22:15'),
(28, 'Keonho', '+628128367191', '2026-10-16 08:15:04', '2026-10-16 08:15:04'),
(29, 'Medina', '+628121361611', '2026-10-16 08:31:13', '2026-10-16 08:31:13'),
(30, 'Adinda', '+628821782561', '2026-10-16 08:42:23', '2026-10-16 08:42:23'),
(31, 'Adinda', '+628821825614', '2026-10-16 08:44:56', '2026-10-16 08:44:56'),
(32, 'Danella', '+628121778261', '2026-10-16 15:48:28', '2026-10-16 15:48:28'),
(33, 'Naura', '+628821926182', '2026-10-16 16:10:01', '2026-10-16 16:10:01'),
(34, 'Putri', '+628221256177', '2026-10-16 16:14:58', '2026-10-16 16:14:58'),
(35, 'Michelle', '+628226715261', '2026-10-16 16:24:05', '2026-10-16 16:24:05'),
(36, 'Kenzi', '+62882819272', '2026-10-16 17:25:49', '2026-10-16 17:25:49'),
(37, 'Chikaa', '+62882192617', '2026-10-16 17:28:37', '2026-10-16 17:28:37'),
(38, 'Melvin', '+62882183611', '2026-10-17 04:35:49', '2026-10-17 04:35:49'),
(39, 'Arumi', '+628828196315', '2026-10-17 04:59:43', '2026-10-17 04:59:43'),
(40, 'Arsylla', '+62822172611', '2026-10-17 05:23:36', '2026-10-17 05:23:36'),
(41, 'Steven', '+628821897312', '2026-10-17 05:48:22', '2026-10-17 05:48:22'),
(42, 'Akbar', '+62882173017', '2026-10-17 05:54:43', '2026-10-17 05:54:43'),
(43, 'Steven', '+62882156421', '2026-10-17 05:59:21', '2026-10-17 05:59:21'),
(44, 'Marsca', '+62822675211', '2026-10-17 08:06:57', '2026-10-17 08:06:57'),
(45, 'Ananta', '+62882178361', '2026-10-17 08:15:58', '2026-10-17 08:15:58'),
(46, 'Arofah', '+6288215218', '2026-10-17 11:17:10', '2026-10-17 11:17:10'),
(47, 'Naila', '+62882819631', '2026-10-17 13:21:49', '2026-10-17 13:21:49'),
(48, 'Azizah', '+6288218973', '2026-10-17 13:31:51', '2026-10-17 13:31:51'),
(49, 'Suci', '+62882126851', '2026-10-17 13:42:13', '2026-10-17 13:42:13'),
(50, 'Rebecca', '+62812713611', '2026-10-17 14:23:29', '2026-10-17 14:23:29'),
(51, 'Rebecca', '+62812561411', '2026-10-17 14:35:03', '2026-10-17 14:35:03'),
(52, 'Arofah', '+62882167351', '2026-10-17 15:06:09', '2026-10-17 15:06:09'),
(53, 'Arofah', '+628826152171', '2026-10-17 15:41:31', '2026-10-17 15:41:31'),
(54, 'Nadine', '+62882163181', '2026-10-17 16:29:13', '2026-10-17 16:29:13'),
(55, 'Rizky', '+62812635171', '2026-10-17 16:54:46', '2026-10-17 16:54:46'),
(56, 'Halisah', '+62812136153', '2026-10-18 15:25:24', '2026-10-18 15:25:24'),
(57, 'Nur', '+62882183516', '2026-10-18 15:40:31', '2026-10-18 15:40:31'),
(58, 'Syahrin', '+62812635161', '2026-10-18 16:04:24', '2026-10-18 16:04:24'),
(61, 'Ajnicha', '+62882675215', '2026-10-18 16:41:43', '2026-10-18 16:41:43'),
(62, 'Nichaa', '+62813786215', '2026-10-18 16:52:57', '2026-10-18 16:52:57'),
(63, 'Kanaya', '+6288217834', '2026-10-18 17:26:36', '2026-10-18 17:26:36'),
(64, 'Miranda', '+6281926153', '2026-10-18 17:48:44', '2026-10-18 17:48:44'),
(65, 'Kevan', '+62812653178', '2026-10-18 18:38:24', '2026-10-18 18:38:24'),
(66, 'Adit', '+6281389621', '2026-10-18 19:14:20', '2026-10-18 19:14:20'),
(67, 'Axel', '+6282287218', '2026-10-18 19:17:32', '2026-10-18 19:17:32'),
(68, 'Akbar', '+6288265316', '2026-10-18 19:21:46', '2026-10-18 19:21:46'),
(69, 'Lana', '+628138109', '2026-10-19 03:27:26', '2026-10-19 03:27:26'),
(70, 'Jeje', '+6281389163', '2026-10-19 03:55:35', '2026-10-19 03:55:35'),
(71, 'Rifa', '+62822682516', '2026-10-19 14:31:07', '2026-10-19 14:31:07'),
(72, 'Fariha', '+6281278361', '2026-10-19 15:06:45', '2026-10-19 15:06:45');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `movie_rentals`
--
ALTER TABLE `movie_rentals`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_id` (`order_id`);

--
-- Indexes for table `tix_event_orders`
--
ALTER TABLE `tix_event_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tix_food_orders`
--
ALTER TABLE `tix_food_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nomor_hp` (`nomor_hp`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `movie_rentals`
--
ALTER TABLE `movie_rentals`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tix_event_orders`
--
ALTER TABLE `tix_event_orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `tix_food_orders`
--
ALTER TABLE `tix_food_orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
