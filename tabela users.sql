
CREATE TABLE
IF NOT EXISTS `users`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `status` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
) AUTO_INCREMENT=00;