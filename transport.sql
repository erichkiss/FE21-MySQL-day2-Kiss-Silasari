-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 14. Apr 2021 um 14:51
-- Server-Version: 10.4.18-MariaDB
-- PHP-Version: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `transport`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bus`
--

CREATE TABLE `bus` (
  `bus_id` int(10) UNSIGNED NOT NULL,
  `model` varchar(20) DEFAULT NULL,
  `license_plate` varchar(20) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `driver` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `bus`
--

INSERT INTO `bus` (`bus_id`, `model`, `license_plate`, `capacity`, `driver`) VALUES
(1, 'Mercedes', 'W-123AB', 80, 'Franz'),
(2, 'Volvo', 'W-245A5', 75, 'Karl'),
(3, 'VW', 'MD-777B', 30, 'Joseph'),
(4, 'MAN', 'EU-237F', 85, 'Renate');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bus_station`
--

CREATE TABLE `bus_station` (
  `bus_station_id` int(10) UNSIGNED NOT NULL,
  `city` varchar(20) DEFAULT NULL,
  `adress` varchar(20) DEFAULT NULL,
  `phone_number` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `bus_station`
--

INSERT INTO `bus_station` (`bus_station_id`, `city`, `adress`, `phone_number`) VALUES
(1, 'Vienna', 'Erdbergstraße', 1234567),
(2, 'Berlin', 'Torstraße', 54654654),
(3, 'München', 'Oktoberfeststraße', 56464654),
(4, 'Amsterdam', 'Canalgracht', 8454654),
(5, 'Salzburg', 'Burgstraße', 465465456),
(6, 'Budapest', 'Fertö-ut', 54648);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `route`
--

CREATE TABLE `route` (
  `route_id` int(10) UNSIGNED NOT NULL,
  `route_code` varchar(20) DEFAULT NULL,
  `distance` int(11) DEFAULT NULL,
  `departure` int(10) UNSIGNED DEFAULT NULL,
  `arrival` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `route`
--

INSERT INTO `route` (`route_id`, `route_code`, `distance`, `departure`, `arrival`) VALUES
(1, 'VIE-BUD', 300, 1, 6),
(2, 'BUD-VIE', 300, 6, 1),
(3, 'AMS-VIE', 1500, 4, 1),
(4, 'BER-SAL', 900, 2, 5),
(5, 'SAL-BER', 900, 5, 2),
(6, 'MUN-AMS', 1000, 3, 4);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `stop_list`
--

CREATE TABLE `stop_list` (
  `order_number` varchar(20) DEFAULT NULL,
  `fk_bus_station` int(10) UNSIGNED NOT NULL,
  `fk_route_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `stop_list`
--

INSERT INTO `stop_list` (`order_number`, `fk_bus_station`, `fk_route_id`) VALUES
('5', 1, 3),
('2', 2, 3),
('3', 2, 5),
('3', 3, 3),
('2', 3, 5),
('1', 4, 3),
('4', 5, 3),
('1', 5, 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `travel`
--

CREATE TABLE `travel` (
  `travel_id` int(10) UNSIGNED NOT NULL,
  `fk_bus_id` int(10) UNSIGNED DEFAULT NULL,
  `fk_route_id` int(10) UNSIGNED DEFAULT NULL,
  `travel_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `travel`
--

INSERT INTO `travel` (`travel_id`, `fk_bus_id`, `fk_route_id`, `travel_date`) VALUES
(1, 1, 1, '2021-04-20'),
(2, 2, 3, '2021-04-30'),
(3, 4, 5, '2021-05-20');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `bus`
--
ALTER TABLE `bus`
  ADD PRIMARY KEY (`bus_id`);

--
-- Indizes für die Tabelle `bus_station`
--
ALTER TABLE `bus_station`
  ADD PRIMARY KEY (`bus_station_id`);

--
-- Indizes für die Tabelle `route`
--
ALTER TABLE `route`
  ADD PRIMARY KEY (`route_id`),
  ADD KEY `departure` (`departure`),
  ADD KEY `arrival` (`arrival`);

--
-- Indizes für die Tabelle `stop_list`
--
ALTER TABLE `stop_list`
  ADD PRIMARY KEY (`fk_bus_station`,`fk_route_id`),
  ADD KEY `fk_route_id` (`fk_route_id`);

--
-- Indizes für die Tabelle `travel`
--
ALTER TABLE `travel`
  ADD PRIMARY KEY (`travel_id`),
  ADD KEY `fk_bus_id` (`fk_bus_id`),
  ADD KEY `fk_route_id` (`fk_route_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `bus`
--
ALTER TABLE `bus`
  MODIFY `bus_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `bus_station`
--
ALTER TABLE `bus_station`
  MODIFY `bus_station_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `route`
--
ALTER TABLE `route`
  MODIFY `route_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `travel`
--
ALTER TABLE `travel`
  MODIFY `travel_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `route`
--
ALTER TABLE `route`
  ADD CONSTRAINT `route_ibfk_1` FOREIGN KEY (`departure`) REFERENCES `bus_station` (`bus_station_id`),
  ADD CONSTRAINT `route_ibfk_2` FOREIGN KEY (`arrival`) REFERENCES `bus_station` (`bus_station_id`);

--
-- Constraints der Tabelle `stop_list`
--
ALTER TABLE `stop_list`
  ADD CONSTRAINT `stop_list_ibfk_1` FOREIGN KEY (`fk_bus_station`) REFERENCES `bus_station` (`bus_station_id`),
  ADD CONSTRAINT `stop_list_ibfk_2` FOREIGN KEY (`fk_route_id`) REFERENCES `route` (`route_id`);

--
-- Constraints der Tabelle `travel`
--
ALTER TABLE `travel`
  ADD CONSTRAINT `travel_ibfk_1` FOREIGN KEY (`fk_bus_id`) REFERENCES `bus` (`bus_id`),
  ADD CONSTRAINT `travel_ibfk_2` FOREIGN KEY (`fk_route_id`) REFERENCES `route` (`route_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
