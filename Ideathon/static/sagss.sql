-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 20, 2024 at 11:44 AM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sagss`
--

-- --------------------------------------------------------

--
-- Table structure for table `foodmenu`
--

CREATE TABLE `foodmenu` (
  `id` int(11) NOT NULL,
  `isactive` tinyint(1) NOT NULL,
  `food` varchar(255) NOT NULL,
  `day` int(10) NOT NULL,
  `Price` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `foodmenu`
--

INSERT INTO `foodmenu` (`id`, `isactive`, `food`, `day`, `Price`) VALUES
(2, 1, 'chapati', 7, 100),
(3, 1, 'Rice', 7, 80);

-- --------------------------------------------------------

--
-- Table structure for table `food_mapping`
--

CREATE TABLE `food_mapping` (
  `user_id` int(10) NOT NULL,
  `foodlist` text NOT NULL,
  `price` int(10) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `food_mapping`
--

INSERT INTO `food_mapping` (`user_id`, `foodlist`, `price`, `date`) VALUES
(1, '{\'2\': \'1\', \'3\': \'0\', \'total\': \'100.00\'}', 100, '2024-04-20'),
(1, '{\'2\': \'1\', \'3\': \'1\', \'total\': \'180.00\'}', 180, '2024-04-20');

-- --------------------------------------------------------

--
-- Table structure for table `lockers`
--

CREATE TABLE `lockers` (
  `locker_no` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `floor` varchar(2) NOT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `lockers`
--

INSERT INTO `lockers` (`locker_no`, `user_id`, `floor`, `from_date`, `to_date`) VALUES
(1, 1, 'GF', '2024-04-17', '2024-04-23'),
(2, 1, 'GF', '2024-04-18', '2024-04-16'),
(3, 1, 'GF', '2024-04-19', '2024-04-26'),
(1, 1, 'FF', '2024-04-17', '2024-04-23'),
(2, 1, 'FF', '2024-04-09', '2024-04-22'),
(3, 1, 'FF', '2024-04-18', '2024-04-23'),
(0, 1, 'FF', '2024-04-26', '2024-04-27'),
(5, NULL, 'FF', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `meetings`
--

CREATE TABLE `meetings` (
  `meeting_room` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `floor` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `meetings`
--

INSERT INTO `meetings` (`meeting_room`, `user_id`, `date`, `start_time`, `end_time`, `floor`) VALUES
(1, 1, NULL, NULL, NULL, 'FF');

-- --------------------------------------------------------

--
-- Table structure for table `meeting_room`
--

CREATE TABLE `meeting_room` (
  `Meeting_room` int(11) NOT NULL,
  `Floor` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `meeting_room`
--

INSERT INTO `meeting_room` (`Meeting_room`, `Floor`) VALUES
(1, 'GF'),
(2, 'GF'),
(3, 'GF'),
(1, 'FF'),
(2, 'FF'),
(3, 'FF');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `adid` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `empcode` varchar(255) DEFAULT NULL,
  `isactive` tinyint(1) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `adid`, `name`, `empcode`, `isactive`, `password`) VALUES
(1, 'sasankperumalla', 'sasank perumalla', '2040012', 1, 'Sasank@123'),
(2, 'alapativiswanath', 'alapati viswanath', '2040010', 1, 'Sasank@123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `foodmenu`
--
ALTER TABLE `foodmenu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `foodmenu`
--
ALTER TABLE `foodmenu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
