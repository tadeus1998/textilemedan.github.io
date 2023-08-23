-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Inang: 127.0.0.1
-- Waktu pembuatan: 23 Agu 2023 pada 10.41
-- Versi Server: 5.5.32
-- Versi PHP: 5.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Basis data: `id21173955_barang_db`
--
CREATE DATABASE IF NOT EXISTS `id21173955_barang_db` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `id21173955_barang_db`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

CREATE TABLE IF NOT EXISTS `barang` (
  `id_barang` char(7) NOT NULL,
  `nama_barang` varchar(255) NOT NULL,
  `stok` int(11) NOT NULL,
  `satuan_id` int(11) NOT NULL,
  `jenis_id` int(11) NOT NULL,
  PRIMARY KEY (`id_barang`),
  KEY `satuan_id` (`satuan_id`),
  KEY `kategori_id` (`jenis_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `barang`
--

INSERT INTO `barang` (`id_barang`, `nama_barang`, `stok`, `satuan_id`, `jenis_id`) VALUES
('B000000', 'Katun Italy', 0, 4, 9),
('B000001', 'Katun Madinah', 0, 2, 9),
('B000002', 'Katun Toyobo', 6, 1, 9),
('B000003', 'Katun Linen', 0, 4, 9),
('B000004', 'Katun Swis', 0, 4, 9),
('B000005', 'Batik Tulle Bordir', 28, 4, 10),
('B000006', 'Batik Tulle Payet', 0, 4, 10);

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang_keluar`
--

CREATE TABLE IF NOT EXISTS `barang_keluar` (
  `id_barang_keluar` char(16) NOT NULL,
  `user_id` int(11) NOT NULL,
  `barang_id` char(7) NOT NULL,
  `jumlah_keluar` int(11) NOT NULL,
  `tanggal_keluar` date NOT NULL,
  PRIMARY KEY (`id_barang_keluar`),
  KEY `id_user` (`user_id`),
  KEY `barang_id` (`barang_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `barang_keluar`
--

INSERT INTO `barang_keluar` (`id_barang_keluar`, `user_id`, `barang_id`, `jumlah_keluar`, `tanggal_keluar`) VALUES
('T-BK-23032400000', 9, 'B000000', 2, '2023-03-24'),
('T-BK-23040300000', 9, 'B000005', 2, '2023-04-03'),
('T-BK-23040300001', 9, 'B000006', 90, '2023-04-03');

--
-- Trigger `barang_keluar`
--
DROP TRIGGER IF EXISTS `update_stok_keluar`;
DELIMITER //
CREATE TRIGGER `update_stok_keluar` BEFORE INSERT ON `barang_keluar`
 FOR EACH ROW UPDATE `barang` SET `barang`.`stok` = `barang`.`stok` - NEW.jumlah_keluar WHERE `barang`.`id_barang` = NEW.barang_id
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang_masuk`
--

CREATE TABLE IF NOT EXISTS `barang_masuk` (
  `id_barang_masuk` char(16) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `barang_id` char(7) NOT NULL,
  `jumlah_masuk` int(11) NOT NULL,
  `tanggal_masuk` date NOT NULL,
  PRIMARY KEY (`id_barang_masuk`),
  KEY `id_user` (`user_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `barang_id` (`barang_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `barang_masuk`
--

INSERT INTO `barang_masuk` (`id_barang_masuk`, `supplier_id`, `user_id`, `barang_id`, `jumlah_masuk`, `tanggal_masuk`) VALUES
('T-BM-23032400000', 1, 9, 'B000000', 5, '2023-03-24'),
('T-BM-23032400001', 1, 9, 'B000000', 10, '2023-03-24'),
('T-BM-23040300000', 1, 9, 'B000002', 6, '2023-04-03'),
('T-BM-23040300001', 6, 9, 'B000005', 30, '2023-04-03'),
('T-BM-23040300002', 5, 9, 'B000006', 90, '2023-04-03');

--
-- Trigger `barang_masuk`
--
DROP TRIGGER IF EXISTS `update_stok_masuk`;
DELIMITER //
CREATE TRIGGER `update_stok_masuk` BEFORE INSERT ON `barang_masuk`
 FOR EACH ROW UPDATE `barang` SET `barang`.`stok` = `barang`.`stok` + NEW.jumlah_masuk WHERE `barang`.`id_barang` = NEW.barang_id
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jenis`
--

CREATE TABLE IF NOT EXISTS `jenis` (
  `id_jenis` int(11) NOT NULL AUTO_INCREMENT,
  `nama_jenis` varchar(20) NOT NULL,
  PRIMARY KEY (`id_jenis`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Dumping data untuk tabel `jenis`
--

INSERT INTO `jenis` (`id_jenis`, `nama_jenis`) VALUES
(9, 'Katun'),
(10, 'Batik'),
(11, 'Brokat'),
(12, 'Songket'),
(13, 'Woll');

-- --------------------------------------------------------

--
-- Struktur dari tabel `satuan`
--

CREATE TABLE IF NOT EXISTS `satuan` (
  `id_satuan` int(11) NOT NULL AUTO_INCREMENT,
  `nama_satuan` varchar(15) NOT NULL,
  PRIMARY KEY (`id_satuan`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data untuk tabel `satuan`
--

INSERT INTO `satuan` (`id_satuan`, `nama_satuan`) VALUES
(1, 'Pack @10 Roll'),
(2, 'Roll @25 Meter'),
(4, 'Roll @30 Meter'),
(5, 'Roll @50 Meter');

-- --------------------------------------------------------

--
-- Struktur dari tabel `supplier`
--

CREATE TABLE IF NOT EXISTS `supplier` (
  `id_supplier` int(11) NOT NULL AUTO_INCREMENT,
  `nama_supplier` varchar(50) NOT NULL,
  `no_telp` varchar(15) NOT NULL,
  `alamat` text NOT NULL,
  PRIMARY KEY (`id_supplier`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data untuk tabel `supplier`
--

INSERT INTO `supplier` (`id_supplier`, `nama_supplier`, `no_telp`, `alamat`) VALUES
(1, 'PT. BEN GOLAN BERKARYA', '085688772971', 'Jalan Riau No. 70 Medan Timur'),
(2, 'MEDAN SAFETY', '081341879246', 'Jalan Cempaka no. 45 Medan Baru'),
(4, 'Fiara Sulam', '08112334872', 'Jalan Raya Bukittinggi-Payakumbuh KM 9. Jorong Lundang, Panampuang, Kec Ampek Angkek, Kab Agam\r\nKab. Agam\r\nSumatera Barat'),
(5, 'PT. EKA JASA KARYA', '081260199820', 'JL. SUNGGAL NO. 125\r\nMEDAN\r\nSumatera Utara'),
(6, 'PT. TIARA GADA PRATAMA', '081377488880', 'KM. 18 Jl. Danau Laut Tawar Komplek Danau Laut Tawar Blok C No. 7 Binjai Timur\r\nMedan\r\nSumatera Utara'),
(7, 'Ronaldo wati', '08112334872', 'Jalan sei bengkulu');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `no_telp` varchar(15) NOT NULL,
  `role` enum('gudang','admin') NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` int(11) NOT NULL,
  `foto` text NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id_user`, `nama`, `username`, `email`, `no_telp`, `role`, `password`, `created_at`, `foto`, `is_active`) VALUES
(8, 'Rina Situmeang', 'rinasitumeang', 'rinasitumeang@gmail.com', '081377488880', 'gudang', '$2y$10$aSsHrgcRes796MKsftqiZ.5/TzXXKnLGdB1kRQYlDLhMpR6mgmMUa', 1679372464, 'f38e20e632ba76019708f97c9592cfe6.jpg', 1),
(9, 'LILI RAHMITA', 'lilirahmita', 'viliplaia@gmail.com', '088262605865', 'admin', '$2y$10$yePL2O1Ix8m8DuvFjf/qoujRZPer9Mn4gY02rwkYjC5piGeEefKqe', 1679375848, '27afeb71fd87c83ad1e8d3a093a5c901.jpg', 1);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD CONSTRAINT `barang_ibfk_1` FOREIGN KEY (`satuan_id`) REFERENCES `satuan` (`id_satuan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `barang_ibfk_2` FOREIGN KEY (`jenis_id`) REFERENCES `jenis` (`id_jenis`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `barang_keluar`
--
ALTER TABLE `barang_keluar`
  ADD CONSTRAINT `barang_keluar_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `barang_keluar_ibfk_2` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id_barang`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD CONSTRAINT `barang_masuk_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `barang_masuk_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id_supplier`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `barang_masuk_ibfk_3` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id_barang`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
