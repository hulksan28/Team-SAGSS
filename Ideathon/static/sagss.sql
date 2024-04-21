-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 21, 2024 at 04:37 PM
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
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `user_id` int(11) NOT NULL,
  `login_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`user_id`, `login_time`) VALUES
(1, '2024-04-21 16:07:51'),
(1, '2024-04-20 13:07:51'),
(1, '2024-04-19 11:07:51'),
(4, '2024-04-21 17:09:56'),
(4, '2024-04-20 12:09:53'),
(2, '2024-04-21 17:37:00');

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE `files` (
  `user_id` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` text NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `files`
--

INSERT INTO `files` (`user_id`, `file_name`, `file_path`, `date`) VALUES
(2, 'testfile123', 'static/files/110020701736.csv', '2024-04-21');

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
(2, 1, 'chapati', 1, 100),
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
(2, '{\'2\': \'1\', \'total\': \'100.00\'}', 100, '2024-04-21'),
(2, '{\'2\': \'2\', \'total\': \'200.00\'}', 200, '2024-04-21');

-- --------------------------------------------------------

--
-- Table structure for table `lockers`
--

CREATE TABLE `lockers` (
  `locker_no` int(11) NOT NULL,
  `floor` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `lockers`
--

INSERT INTO `lockers` (`locker_no`, `floor`) VALUES
(1, 'GF'),
(2, 'GF'),
(3, 'GF'),
(1, 'FF'),
(2, 'FF'),
(3, 'FF');

-- --------------------------------------------------------

--
-- Table structure for table `locker_mapping`
--

CREATE TABLE `locker_mapping` (
  `locker_no` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `floor` varchar(255) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `locker_mapping`
--

INSERT INTO `locker_mapping` (`locker_no`, `user_id`, `floor`, `from_date`, `to_date`) VALUES
(1, 2, 'GF', '2024-04-23', '2024-04-25'),
(2, 2, 'GF', '2024-04-23', '2024-04-25'),
(1, 2, 'GF', '2024-04-21', '2024-04-22'),
(1, 2, 'GF', '2024-04-26', '2024-04-27'),
(1, 2, 'GF', '2024-04-27', '2024-04-28'),
(1, 2, 'GF', '2024-04-28', '2024-04-28'),
(1, 2, 'GF', '2024-04-28', '2024-04-30'),
(1, 2, 'GF', '2024-04-29', '2024-05-30'),
(2, 2, 'GF', '2024-04-29', '2024-04-30'),
(3, 2, 'GF', '2024-04-29', '2024-05-01'),
(2, 2, 'GF', '2024-05-03', '2024-05-11'),
(2, 2, 'GF', '2024-04-21', '2024-04-22');

-- --------------------------------------------------------

--
-- Table structure for table `meetings`
--

CREATE TABLE `meetings` (
  `meeting_room` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `floor` varchar(2) NOT NULL,
  `date` date DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `meetings`
--

INSERT INTO `meetings` (`meeting_room`, `user_id`, `floor`, `date`, `start_time`, `end_time`) VALUES
(2, 2, 'GF', '2024-04-22', '2024-04-22 10:00:00', '2024-04-22 11:30:00'),
(3, 2, 'GF', '2024-04-22', '2024-04-22 12:30:00', '2024-04-22 13:30:00'),
(3, 2, 'GF', '2024-04-22', '2024-04-22 14:33:00', '2024-04-22 16:33:00'),
(3, 2, 'GF', '2024-04-22', '2024-04-22 14:00:00', '2024-04-22 14:27:00');

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
-- Table structure for table `queries`
--

CREATE TABLE `queries` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `query` text NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `queries`
--

INSERT INTO `queries` (`id`, `user_id`, `query`, `date`) VALUES
(1, 2, 'test1', '2024-04-21 00:00:00'),
(2, 2, 'aadas', '2024-04-21 00:00:00'),
(3, 2, 'dfas', '2024-04-21 00:00:00'),
(4, 1, 'test query', '2024-04-21 15:18:06');

-- --------------------------------------------------------

--
-- Table structure for table `query_replies`
--

CREATE TABLE `query_replies` (
  `id` int(11) NOT NULL,
  `query_id` int(11) NOT NULL,
  `reply` text NOT NULL,
  `date` datetime NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `query_replies`
--

INSERT INTO `query_replies` (`id`, `query_id`, `reply`, `date`, `user_id`) VALUES
(1, 1, 'testreply1', '2024-04-21 00:00:00', 2),
(2, 1, 'asdas', '2024-04-21 00:00:00', 2),
(3, 1, 'sasankreply', '2024-04-21 15:17:51', 1);

-- --------------------------------------------------------

--
-- Table structure for table `sports`
--

CREATE TABLE `sports` (
  `sno` int(11) NOT NULL,
  `sport` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sports`
--

INSERT INTO `sports` (`sno`, `sport`) VALUES
(1, 'Table tennis'),
(2, 'Fussball'),
(3, 'Carrom'),
(4, 'chess');

-- --------------------------------------------------------

--
-- Table structure for table `sports_mapping`
--

CREATE TABLE `sports_mapping` (
  `sport` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `slot` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `end_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sports_mapping`
--

INSERT INTO `sports_mapping` (`sport`, `user_id`, `start_time`, `slot`, `date`, `end_time`) VALUES
('chess', 2, '2024-04-21 17:24:00', 15, '2024-04-21', '2024-04-21 17:39:00');

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
  `password` varchar(255) DEFAULT NULL,
  `manager_id` int(11) NOT NULL,
  `role` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `adid`, `name`, `empcode`, `isactive`, `password`, `manager_id`, `role`) VALUES
(1, 'sasankperumalla', 'sasank perumalla', '2040012', 1, 'Sasank@123', 4, 'employee'),
(2, 'alapativiswanath', 'alapati viswanath', '2040010', 1, 'Sasank@123', 4, 'employee'),
(4, 'jigneshbhai', 'Jignesh bhai', '3000233', 1, 'Sasank@123', 5, 'manager');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `foodmenu`
--
ALTER TABLE `foodmenu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `queries`
--
ALTER TABLE `queries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `query_replies`
--
ALTER TABLE `query_replies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sports`
--
ALTER TABLE `sports`
  ADD PRIMARY KEY (`sno`);

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
-- AUTO_INCREMENT for table `queries`
--
ALTER TABLE `queries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `query_replies`
--
ALTER TABLE `query_replies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sports`
--
ALTER TABLE `sports`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
