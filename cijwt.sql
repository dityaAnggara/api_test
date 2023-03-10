-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 10, 2023 at 09:31 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cijwt`
--

-- --------------------------------------------------------

--
-- Table structure for table `banks`
--

CREATE TABLE `banks` (
  `id` int(20) NOT NULL,
  `id_bank` int(8) UNSIGNED ZEROFILL NOT NULL,
  `nama_bank` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `banks`
--

INSERT INTO `banks` (`id`, `id_bank`, `nama_bank`) VALUES
(1, 00000001, 'BNI'),
(2, 00000002, 'BCA'),
(4, 00000003, 'BTN'),
(5, 00000004, 'BRI');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `version` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `group` varchar(255) NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `batch` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `version`, `class`, `group`, `namespace`, `time`, `batch`) VALUES
(1, '2023-03-08-010600', 'App\\Database\\Migrations\\Users', 'default', 'App', 1678238028, 1);

-- --------------------------------------------------------

--
-- Table structure for table `rekening_admin`
--

CREATE TABLE `rekening_admin` (
  `id` int(20) NOT NULL,
  `id_bank` int(8) UNSIGNED ZEROFILL NOT NULL,
  `no_rek` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rekening_admin`
--

INSERT INTO `rekening_admin` (`id`, `id_bank`, `no_rek`) VALUES
(1, 00000001, 1254896),
(2, 00000002, 54329876);

-- --------------------------------------------------------

--
-- Table structure for table `rekening_user`
--

CREATE TABLE `rekening_user` (
  `id` int(20) NOT NULL,
  `id_user` int(20) NOT NULL,
  `id_bank` int(8) UNSIGNED ZEROFILL NOT NULL,
  `no_rekening` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rekening_user`
--

INSERT INTO `rekening_user` (`id`, `id_user`, `id_bank`, `no_rekening`) VALUES
(1, 1, 00000001, 87609898),
(2, 2, 00000002, 4325675),
(3, 1, 00000002, 126746786);

-- --------------------------------------------------------

--
-- Table structure for table `transaksi_transfer`
--

CREATE TABLE `transaksi_transfer` (
  `id` int(20) NOT NULL,
  `id_transaksi` varchar(200) NOT NULL,
  `uid` int(20) NOT NULL,
  `id_bank_pengirim` varchar(200) NOT NULL,
  `id_bank_admin` int(8) UNSIGNED ZEROFILL NOT NULL,
  `id_bank_tujuan` varchar(200) NOT NULL,
  `kode_unik` int(4) NOT NULL,
  `nilai_transfer` int(20) NOT NULL,
  `biaya_admin` int(20) NOT NULL,
  `total_transfer` int(20) NOT NULL,
  `tanggal_transaksi` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaksi_transfer`
--

INSERT INTO `transaksi_transfer` (`id`, `id_transaksi`, `uid`, `id_bank_pengirim`, `id_bank_admin`, `id_bank_tujuan`, `kode_unik`, `nilai_transfer`, `biaya_admin`, `total_transfer`, `tanggal_transaksi`) VALUES
(1, 'TF22101200321', 1, '00000001:BCA:2876455442', 00000001, '00000003:BTN:29883661', 231, 50000, 0, 50231, '2022-03-10 10:40:31'),
(2, 'TF23101200321', 1, '00000001:BCA:2876455442', 00000001, '00000001:BCA:287645567', 241, 50000, 0, 50241, '2023-03-10 10:40:31'),
(3, 'TF2303100002', 1, '00000002:BCA', 54329876, 'BI:2345678', 439, 50000, 2500, 52939, '2023-03-10 16:02:20'),
(4, 'TF2303100003', 1, '00000002:BCA', 54329876, 'BI:2345678', 934, 50000, 2500, 53434, '2023-03-10 16:02:22'),
(5, 'TF2303100004', 1, '00000002:BCA', 54329876, 'BCA:2345678', 503, 50000, 0, 50503, '2023-03-10 16:04:35');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(5) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(200) NOT NULL,
  `acces_t` text NOT NULL,
  `expi` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `acces_t`, `expi`) VALUES
(1, 't@gmil.com', '$2y$10$ZdSj9Z3UFo2jxZ.AE1BCOOQ0mwJdX/qbutKq4qUypleRWttvJR0Ey', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiIxIiwiZW1haWwiOiJ0QGdtaWwuY29tIiwicmVmIjoiMjAyMy0wMy0xMCAwMDoyNDo1MSIsInN0YXR1cyI6InNlZ2FyIn0.7Cv5xSIhwG99Dlt5kgBAYuR0Oaq7gaiASnOphRutsu4', '2023-03-10 02:24:51'),
(2, 'tt@gmil.com', '$2y$10$QOA0v0QWjyND5fRCTXuHUeYIZ2l.eR46XMT6yzgTHmp.UggehnWvi', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiIyIiwiZW1haWwiOiJ0dEBnbWlsLmNvbSIsInJlZiI6IjIwMjMtMDMtMTAgMDA6MjU6MjAiLCJzdGF0dXMiOiJzZWdhciJ9.cBTG_qWuYGReYZ-VqXDBL3fWudr_1CS8JsTsFO8Zfss', '2023-03-10 02:25:20'),
(3, 'td@gmil.com', '$2y$10$vdA.IS4lE9GOHbshmRpMiuHdOzQmMfcr1yW5DqNlrYZlgxIPR2KJS', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiIzIiwiZW1haWwiOiJ0ZEBnbWlsLmNvbSIsInJlZiI6IjIwMjMtMDMtMTAgMDA6MjU6MzYiLCJzdGF0dXMiOiJzZWdhciJ9.dDwJ8awMTmMcGudcaQU4S3aOWyCZ3DWIo3V5LMyIido', '2023-03-10 02:25:36'),
(4, 'dt@gmail.com', '$2y$10$bzxGOUmUbg.YER2WZZd86emwpqRIKH4qBX75FIHF706hPr0CkL4bW', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiI0IiwiZW1haWwiOiJkdEBnbWFpbC5jb20iLCJyZWYiOiIyMDIzLTAzLTA5IDE0OjMxOjM3Iiwic3RhdHVzIjoic2VnYXIifQ.ZLGCzQvFcEWEJz2XApzsb6LnRVlLYhFrBY1AIkI753M', '2023-03-09 16:31:37');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `banks`
--
ALTER TABLE `banks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rekening_admin`
--
ALTER TABLE `rekening_admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rekening_user`
--
ALTER TABLE `rekening_user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaksi_transfer`
--
ALTER TABLE `transaksi_transfer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `banks`
--
ALTER TABLE `banks`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rekening_admin`
--
ALTER TABLE `rekening_admin`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rekening_user`
--
ALTER TABLE `rekening_user`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `transaksi_transfer`
--
ALTER TABLE `transaksi_transfer`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
