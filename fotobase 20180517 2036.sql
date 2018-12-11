--
-- Скрипт сгенерирован Devart dbForge Studio for MySQL, Версия 7.2.78.0
-- Домашняя страница продукта: http://www.devart.com/ru/dbforge/mysql/studio
-- Дата скрипта: 17.05.2018 20:36:02
-- Версия сервера: 5.7.17
-- Версия клиента: 4.1
--


-- 
-- Отключение внешних ключей
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Установить режим SQL (SQL mode)
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Установка кодировки, с использованием которой клиент будет посылать запросы на сервер
--
SET NAMES 'utf8';

-- 
-- Установка базы данных по умолчанию
--
USE fotobase;

--
-- Описание для таблицы `order number`
--
DROP TABLE IF EXISTS `order number`;
CREATE TABLE `order number` (
  id INT(11) NOT NULL AUTO_INCREMENT,
  number INT(11) NOT NULL,
  date DATE NOT NULL,
  id_user INT(11) NOT NULL,
  id_payment INT(11) NOT NULL,
  id_receiving INT(11) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX number (number),
  CONSTRAINT `FK_order number_payment_id` FOREIGN KEY (id_payment)
    REFERENCES payment(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_order number_receiving_id` FOREIGN KEY (id_receiving)
    REFERENCES receiving(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_order number_user_id` FOREIGN KEY (id_user)
    REFERENCES user(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 7
AVG_ROW_LENGTH = 3276
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

--
-- Описание для таблицы `order`
--
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  id INT(11) NOT NULL AUTO_INCREMENT,
  id_number INT(11) NOT NULL,
  id_availability INT(11) NOT NULL,
  quantity INT(11) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT FK_order_availability_id FOREIGN KEY (id_availability)
    REFERENCES availability(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_order_order number_id` FOREIGN KEY (id_number)
    REFERENCES `order number`(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 7
AVG_ROW_LENGTH = 2730
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

--
-- Описание для таблицы availability
--
DROP TABLE IF EXISTS availability;
CREATE TABLE availability (
  id INT(11) NOT NULL AUTO_INCREMENT,
  id_product INT(11) NOT NULL,
  id_building INT(11) NOT NULL,
  quantity INT(11) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT FK_availability_building_id FOREIGN KEY (id_building)
    REFERENCES building(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_availability_product_id FOREIGN KEY (id_product)
    REFERENCES product(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 64
AVG_ROW_LENGTH = 292
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

--
-- Описание для таблицы building
--
DROP TABLE IF EXISTS building;
CREATE TABLE building (
  id INT(11) NOT NULL AUTO_INCREMENT,
  address VARCHAR(255) NOT NULL,
  telephone VARCHAR(255) NOT NULL,
  schedule VARCHAR(255) NOT NULL,
  number_chet VARCHAR(255) NOT NULL,
  type INT(11) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX number_chet (number_chet)
)
ENGINE = INNODB
AUTO_INCREMENT = 4
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

--
-- Описание для таблицы mark
--
DROP TABLE IF EXISTS mark;
CREATE TABLE mark (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 10
AVG_ROW_LENGTH = 4096
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

--
-- Описание для таблицы payment
--
DROP TABLE IF EXISTS payment;
CREATE TABLE payment (
  id INT(11) NOT NULL AUTO_INCREMENT,
  type VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 3
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

--
-- Описание для таблицы product
--
DROP TABLE IF EXISTS product;
CREATE TABLE product (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  articul VARCHAR(255) NOT NULL,
  price DOUBLE NOT NULL,
  characteristic VARCHAR(255) NOT NULL,
  `use` VARCHAR(255) NOT NULL,
  id_provider INT(11) NOT NULL,
  id_subtype INT(11) NOT NULL,
  id_mark INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX articul (articul),
  CONSTRAINT FK_product_mark_id FOREIGN KEY (id_mark)
    REFERENCES mark(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_product_provider_id FOREIGN KEY (id_provider)
    REFERENCES provider(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_product_subtype_id FOREIGN KEY (id_subtype)
    REFERENCES subtype(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 22
AVG_ROW_LENGTH = 862
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

--
-- Описание для таблицы provider
--
DROP TABLE IF EXISTS provider;
CREATE TABLE provider (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  number_license VARCHAR(255) NOT NULL,
  address VARCHAR(255) NOT NULL,
  telephone VARCHAR(255) NOT NULL,
  fax VARCHAR(255) NOT NULL,
  schedule VARCHAR(255) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX number_license (number_license)
)
ENGINE = INNODB
AUTO_INCREMENT = 4
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

--
-- Описание для таблицы receiving
--
DROP TABLE IF EXISTS receiving;
CREATE TABLE receiving (
  id INT(11) NOT NULL AUTO_INCREMENT,
  type VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 3
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

--
-- Описание для таблицы subtype
--
DROP TABLE IF EXISTS subtype;
CREATE TABLE subtype (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  id_type INT(11) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT FK_subtype_type_id FOREIGN KEY (id_type)
    REFERENCES type(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 16
AVG_ROW_LENGTH = 1170
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

--
-- Описание для таблицы type
--
DROP TABLE IF EXISTS type;
CREATE TABLE type (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 5
AVG_ROW_LENGTH = 4096
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

--
-- Описание для таблицы user
--
DROP TABLE IF EXISTS user;
CREATE TABLE user (
  id INT(11) NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  login VARCHAR(255) NOT NULL,
  parol VARCHAR(255) NOT NULL,
  access INT(11) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX login (login)
)
ENGINE = INNODB
AUTO_INCREMENT = 10
AVG_ROW_LENGTH = 2048
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

DELIMITER $$

--
-- Описание для процедуры prot_order
--
DROP PROCEDURE IF EXISTS prot_order$$
CREATE PROCEDURE prot_order(a varchar(50))
  SQL SECURITY INVOKER
BEGIN
  SELECT
    p.name,
    p.price
  FROM product p
  WHERE p.id LIKE a;
END
$$

--
-- Описание для функции users_add
--
DROP FUNCTION IF EXISTS users_add$$
CREATE FUNCTION users_add(u_name varchar(50), u_fam varchar(255), u_mail varchar(255), u_parol varchar(255))
  RETURNS int(11)
  SQL SECURITY INVOKER
BEGIN

  INSERT IGNORE INTO user (first_name, last_name, login, parol, access)
    VALUES (u_name, u_fam, u_mail, u_parol, 1);


  RETURN 1;
END
$$

DELIMITER ;

-- 
-- Вывод данных для таблицы `order number`
--
INSERT INTO `order number` VALUES
(1, 4158, '2018-03-07', 1, 1, 1),
(2, 5687, '2018-04-04', 2, 2, 2),
(3, 9574, '2018-01-02', 4, 2, 1),
(4, 7419, '2017-12-15', 5, 1, 2),
(5, 6328, '2017-11-16', 7, 2, 1),
(6, 6281, '2018-04-06', 3, 1, 1);

-- 
-- Вывод данных для таблицы `order`
--
INSERT INTO `order` VALUES
(1, 1, 3, 1),
(2, 2, 13, 3),
(3, 3, 16, 2),
(4, 4, 28, 1),
(5, 6, 23, 5),
(6, 5, 6, 4);

-- 
-- Вывод данных для таблицы availability
--
INSERT INTO availability VALUES
(1, 1, 2, 5),
(2, 2, 3, 10),
(3, 3, 2, 6),
(4, 1, 3, 3),
(5, 1, 1, 2),
(6, 4, 2, 9),
(7, 5, 2, 3),
(8, 6, 1, 4),
(9, 6, 2, 4),
(10, 7, 1, 1),
(11, 8, 3, 6),
(12, 9, 3, 2),
(13, 10, 1, 20),
(14, 10, 2, 13),
(15, 10, 3, 40),
(16, 11, 1, 3),
(17, 11, 2, 4),
(18, 11, 3, 10),
(19, 12, 3, 6),
(20, 13, 2, 4),
(21, 14, 1, 13),
(22, 14, 2, 5),
(23, 14, 3, 15),
(24, 15, 3, 16),
(25, 16, 1, 2),
(26, 17, 2, 4),
(27, 18, 3, 5),
(28, 19, 3, 8),
(29, 20, 2, 6),
(30, 21, 1, 4),
(31, 2, 1, 0),
(32, 2, 2, 0),
(33, 3, 1, 3),
(34, 3, 3, 0),
(35, 4, 1, 2),
(36, 4, 3, 0),
(37, 5, 1, 6),
(38, 5, 3, 0),
(39, 6, 3, 0),
(40, 7, 2, 5),
(41, 7, 3, 0),
(42, 8, 1, 3),
(43, 8, 2, 0),
(44, 9, 1, 4),
(45, 9, 2, 0),
(46, 12, 2, 0),
(47, 12, 1, 0),
(48, 13, 3, 0),
(49, 13, 1, 3),
(50, 15, 1, 0),
(51, 15, 2, 19),
(52, 16, 2, 3),
(53, 16, 3, 0),
(54, 17, 3, 6),
(55, 17, 1, 2),
(56, 18, 2, 7),
(57, 18, 1, 7),
(58, 19, 1, 14),
(59, 19, 2, 0),
(60, 20, 1, 35),
(61, 20, 3, 6),
(62, 21, 2, 31),
(63, 21, 3, 8);

-- 
-- Вывод данных для таблицы building
--
INSERT INTO building VALUES
(1, 'ул. Якубовича, д.3', '8574392', '9-22', '369875248', 1),
(2, 'ул Мира, д.9', '7543921', '9-21', '745218457', 1),
(3, 'ул. Турку, д.19', '7698542', '8-15', '159746584', 2);

-- 
-- Вывод данных для таблицы mark
--
INSERT INTO mark VALUES
(1, 'Canon'),
(2, 'Nikon'),
(3, 'Sony'),
(4, 'PANASONIC'),
(5, 'Pentax'),
(6, 'TRANSCEND'),
(7, 'Xiaomi'),
(8, 'VANGUARD'),
(9, 'Falcon Eyes');

-- 
-- Вывод данных для таблицы payment
--
INSERT INTO payment VALUES
(1, 'наличными'),
(2, 'картой');

-- 
-- Вывод данных для таблицы product
--
INSERT INTO product VALUES
(1, 'CANON EOS 2000D Kit c EF-S 18-55mm IS II', '2728C003', 28990, 'Датчик изображения:\t22.3 x 14.9 мм CMOS\r\nСоотношение сторон:\t3:2\r\nСветочувствительность:\tISO 100 – 6400 с расширением до H: 12800\r\nОптический зум:\t3х\r\nОбъектив:\tEF-S 18-55mm f/3.5-5.6 IS II\r\nФормат файла:\tJPEG, RAW (14 бит)', 'Canon EOS 2000D – идеальный выбор в качестве первой цифровой зеркальной камеры: интуитивно понятноеуправление для создания и публикации красивых снимков с размытым задним планом.', 1, 5, 1),
(2, 'NIKON D3400 Kit c AF-P 18-55 II DX', 'VBA490K002', 30990, 'Датчик изображения:\t23.5 х 15.6 мм КМОП\r\nСветочувствительность:\tISO 100 - 25600 (фото и видео)\r\nОбъектив:\tAF-P DX NIKKOR 18-55mm f/3.5-5.6G\r\nФормат файла:\tRAW (12 бит, сжатый), JPEG\r\nБаланс белого:\tавто, 12 предустановок (с тонкой настройкой), ручной', 'С цифровой зеркальной фотокамерой D3400 вы можете с необычайной легкостью ловить интересные моменты и обмениваться ими на ходу. Приложение Nikon SnapBridge может автоматически подгружать сжатые до 2 Мп. снимки на ваше мобильное устройство.', 3, 5, 2),
(3, 'PANASONIC DMC-LX100 черный', 'DMC-LX100EE-K', 44990, 'Датчик изображения:\t17.3мм x 13.0мм, CMOS\r\nСоотношение сторон:\t4/3\r\nОбъектив:\tLEICA DC VARIO-SUMMILUX\r\nФормат файла:\tJPEG (DCF/Exif2.3) / RAW, DPOF\r\nБаланс белого:\tавтоматический, ручная установка, из списка', 'Фотокамера DMC-LX100 разработана для передачи поразительной градации тонов и богатых текстур во всей их естественной красоте. Фотокамера оснащена новым большим высокочувствительным MOS-сенсором размером 4/3 дюйма с поддержкой различных соотношений сторон.', 1, 1, 4),
(4, 'SONY Cyber-shot DSC-W810 black', 'DSCW810B.RU3', 7490, 'Датчик изображения:\t1/2.3" Super HAD CCD\r\nСоотношение сторон:\t4:3\r\nОптический зум:\t6х\r\nОбъектив:\tf 4.6-27.6 mm/ 3.5-6.5 (26-130 мм в 35-мм эквиваленте)\r\nФормат файла:\tJPEG\r\nБаланс белого:\tавто, 7 предустановок', 'Снимайте все — от вечеринок до отпуска; Камера W810 оснащена множеством функций для удобства съемки четких фотографий и видеороликов в разрешении HD. Делайте четкие снимки крупным планом с помощью 6-кратного оптического зума.', 3, 1, 3),
(5, 'PENTAX 645Z body', 'S0016613', 399999, 'Датчик изображения:\t44 х 33 мм КМОП без сглаживающего фильтра\r\nЧисло эффективных пикселей:\t51.4 млн.\r\nОбъектив:\tнет в комплекте.\r\nБаланс белого:\tRGB-датчик + основная матрица; автоматический, многозонный автоматический, 9 предустановок, ручной.', 'Зеркальная камера среднего формата Pentax 645Z предлагает высочайшую детализацию и сверхширокий динамический диапазон и в то же время многоточечную систему быстрой фазовой фокусировки, высокоскоростную серийную съемку.', 1, 5, 5),
(6, 'CANON EF-S 10-18mm f/4.5-5.6 IS STM', '9519B005', 16490, 'Байонет:\tCanon EF-S\r\nФокусное расстояние:\t10 - 18mm\r\nОтносительное отверстие:\tf/4.5 - 5.6\r\nМинимальная диафрагма:\tf/22 - 29\r\nМинимальная дистанция фокусировки:\t0.22 м\r\nУгол поля зрения:\t107° 30'' - 74° 20''\r\nДиаметр светофильтра:\t67 мм', 'Объектив EF-S 10–18mm f/4.5–5.6 IS STM — идеальное решение для тех, кто хотел бы расширить диапазон фокусных расстояний своего фотооборудования и снимать на широкоугольный объектив.', 2, 6, 1),
(7, 'PANASONIC Leica DG Vario-Elmarit 8-18mm', 'H-E08018E', 89990, 'Байонет:\tMicro 4/3\r\nФокусное расстояние:\t8 - 18 мм\r\nМинимальная диафрагма:\t1:22\r\nМинимальная дистанция фокусировки:\t0.23 м\r\nУгол поля зрения:\tнет данных\r\nКонструкция объектива:\t15 элементов в 10 группах\r\nДиаметр светофильтра:\t67 мм', 'Сверхширокоугольный зум-объектив для камер формата Micro 4/3. По сравнению с предыдущей моделью, LUMIX G VARIO 7-14mm F4.0 ASPH., угол поля зрения стал чуть меньше, но зато значительно повысилась светосила, особенно в наиболее широком положении.', 1, 15, 4),
(8, 'NIKON 1 NIKKOR 32mm f/1.2 чёрный', 'JVA301DA', 61990, 'Байонет:\tNikon 1 (CX)\r\nФокусное расстояние:\t32 мм (прибл. 86 мм в 35-мм эквиваленте)\r\nОтносительное отверстие:\t1/1.2\r\nМинимальная диафрагма:\t1/16\r\nМинимальная дистанция фокусировки:\t0.45 м\r\nУгол поля зрения:\t28°\r\nДиаметр светофильтра:\t52 мм', 'Nikon 1 Nikkor 32mm f/1.2 - новый объектив для камер системы Nikon 1. По фокусному расстоянию он относится к "портретным", т.е. лучше всего подходит для съемки людей, для создания натюрмортов и для других подобных жанров.', 3, 8, 2),
(9, 'PENTAX FA 31mm f/1.8 AL SMC Limited серебристый', '20280', 74990, 'Байонет:\tPentax KAF (35 мм)\r\nФокусное расстояние:\t31 мм\r\nБайонет:\tPentax KAF (35 мм)\r\nФокусное расстояние:\t31 мм\r\nМинимальная диафрагма:\t1:22\r\nМинимальная дистанция фокусировки:\t0.3 м\r\nУгол поля зрения:\t70°\r\nДиаметр светофильтра:\t58 мм', 'Компактный широкоугольный объектив с высокой светосилой, позволяющей вести съемку без дополнительного освещения. Отличается высокой разрешающей способностью, очень низким уровнем хроматических аберраций и приятным, мягким размытием фона.', 1, 7, 5),
(10, 'TRANSCEND SDHC 8GB Class 10 (TS8GSDHC10)', 'TS8GSDHC10', 550, 'Производитель: Transcend\r\nМодель: TS8GSDHC10\r\nТип: SDHC Class 10 card (Premium)\r\nОбъём памяти: 8 Гб\r\nРабочее напряжение: 2.7 - 3.6 В\r\nСкорость чтения: до 20 Мб/сек\r\nСкорость записи: до 16 Мб/сек\r\nРазмеры (Ш х Д х В): 32 x 24 x 2.1 мм\r\nВес: 2 г', 'SDHC 8GB Transcend Class 10 - карта памяти объемом 8Гб c высокой скоростью чтения/записи более 10 МБ/с. Данная карта подойдет для большинства современных цифровых фотокамер, а также, видео-, аудио- и компьютерной техники. ', 2, 11, 6),
(11, 'TRANSCEND SDXC 64GB Class 10 UHS-I 600x Ultimate', 'TS64GSDXC10U1', 3290, 'Размеры: 32 x 24 x 2.1 мм\r\nНапряжение питания: 2,7 В~3,6 В\r\nРабочая температура: от -25°C до 85°C\r\nРесурс: 10 000 циклов установки/извлечения\r\nВес: 2г\r\nСкорость передачи данных (макс.)*: 90 МБ/с 600x', 'Карты памяти Transcend Class UHS-I были созданы для профессионалов, которые работают с самой современной фото- и видеотехникой. Кроме того, используемые в этих картах микросхемы флэш-памяти отличаются долговечностью и высокой надежностью', 2, 11, 6),
(12, 'Чехол SONY LCJ-RXJ для RX10M3 / RX10M4', 'LCJ-RXJ', 9990, 'Материал: полиуретан.\r\nДля предыдущих моделей, DSC-RX10 и DSC-RX10 II, необходим LCJ-RXE.', 'Оригинальный чехол для фотоаппаратов Cyber-Shot DSC-RX10 III и DSC-RX10 IV. Стильно выглядит и идеально подходит по форме, не болтается и обеспечивает отличную защиту без большой прибавки в весе.', 2, 10, 3),
(13, 'Сумка CANON Holster HL100', '1575C001', 2490, 'Размеры внешние:\t22.5 х 17.5 х 13 см\r\nМатериалы:\tполиэстер, полиуретан\r\nВместимость:\tзеркальный фотоаппарат типа Canon 700D с объективом до 18-135 STM\r\nВес:\t340 г\r\nРазмеры:\t22.5 х 17.5 х 13 см', 'Классическая «треуголка» для зеркальных камер Canon начального и среднего уровня. Хорошо подходит к таким камерам как Canon EOS 700D, 750D, 760D, 70D, 80D, 1300D. ', 2, 10, 1),
(14, 'Xiaomi Mi Power Bank 2, 10000 мАч, QC 2.0', 'PLM02ZM', 1390, 'Тип ячеек: литий-полимерные\r\nЕмкость: 10 000 мАч при 3.85 В (38.5 Вт*ч); 6900 мАч при 5.1 В\r\nВремя зарядки: 4.2 ч с зарядным устройством QC 2.0 (18 Вт), 6.2 ч с зарядным устройством 5 В, 2 А\r\nРазмеры: 130 х 71 х 14.1 мм\r\n\r\n', 'Xiaomi Mi Power Bank 2 - обновленный универсальный аккумулятор, теперь с поддержкой технологии быстрой зарядки Quick Charge 2.0 на вход и на выход. Зарядка самого аккумулятора и зарядка совместимых мобильных устройств стала быстрее и удобнее.', 2, 12, 7),
(15, 'Xiaomi Mi Power Bank ZMI 7800 mAh, 3G/4G, белый', 'MF855', 4990, 'SIM карта:       Micro SIM\r\nDHCP-сервер:       есть\r\nWeb-интерфейс:    есть\r\nЗащита информации:       WPA2\r\nЧастотный диапазон, Ггц:   2.4\r\nСтандарт беспроводной связи: 802.11n', 'Китайский производитель Xiaomi всегда радовал потребителей достаточно качественными и полезными товарами. Они отличались многофункциональностью и длительным сроком службы.', 2, 12, 7),
(16, 'Штатив SONY VCT-R640', 'VCT-R64', 4490, 'Головка:\t3D\r\nПузырьковый уровень:\tнет\r\nКоличество секций:\t3\r\nБыстросъемная площадка:\tесть\r\nМаксимальная нагрузка:\t3 кг\r\nМинимальная высота:\t55 см\r\nМаксимальная высота:\t144 см\r\n', 'SONY VCT-R640 - оригинальный штатив для камер Sony.', 1, 2, 3),
(17, 'Штатив VANGUARD Espod CX 203 AP', '90640', 2990, 'Головка:\tPH-23, панорамная, несъемная\r\nКоличество секций:\t3\r\nБыстросъемная площадка:\tQS-29\r\nДиаметр ног:\t20 мм\r\nМаксимальная нагрузка:\t3.5 кг\r\nМаксимальная высота:\t155 см\r\nДлина в сложенном положении:\t57 см\r\nМатериал:\tалюминиевый сплав', 'Espod CX 203 AP без сомнения впечатлит вас современным стилем и простотой в использовании. Такой компактный штатив как Espod CX 203 AP обладает впечатляющими показателями максимальной грузоподъёмности - до 3,5кг.', 2, 2, 8),
(18, 'Софтбокс Falcon Eyes FEA-SB BW, 45х45 см', '20290', 2600, 'Вес:\t0,6 кг\r\nРазмеры:\t45х45 см', 'Устройство состоит из отражателя, внешнего и внутреннего рассеивателя, несущего каркаса. Для установки FEA-SB 4545 BW на осветительные приборы с другим байонетом можно использовать переходные кольца.', 3, 3, 9),
(19, 'Софтбокс Falcon Eyes SBQ-80120 BW, жаропрочный', '20798', 5630, 'Жаропрочный с сотовой насадкой — световой модификатор для студийных осветительных приборов с байонетом Bowens. Размер софтбокса 80х120 см. Может использоваться практически с любыми студийными вспышками мощностью до 1000 Вт.\r\nВес: 900 г.', 'Жаропрочный софтбокс, размер 80х120 см, отражающая поверхность: серебро, байонет Bowens. Может использоваться со вспышками и галогенными осветителями мощностью до 1000 Вт. Сотовая насадка входит в комплект.', 2, 3, 9),
(20, 'Радиосинхронизатор Falcon Eyes SLT-4', '19929', 1630, 'Рабочая частота: 433 МГц\r\nСинхронизация со студийными вспышками: нет\r\nСинхронизация с накамерными вспышками: есть\r\nПитание приемника: 2xAAA батареи\r\nПитание передатчика: 23 A 12 В батарея\r\nДистанция: до 50 метров\r\nСкорость синхронизации: 1/125 сек', 'Радиосинхронизатор SLT-4 — предназначен для беспроводной синхронизации накамерной вспышки (или нескольких вспышек, при использовании дополнительных приемников SLT-4RCR) по радиоканалу на расстоянии до 50 метров. Скорость синхронизации : 1/125 с.', 1, 4, 9),
(21, 'Приемник Falcon Eyes SLT-4RCR универсальный', '19930 ', 1090, 'Рабочая частота: 433 МГц\r\nСинхронизация со студийными вспышками: PC-разъем (синхрокабель в комплект не входит)\r\nСинхронизация с накамерными вспышками: есть\r\nПитание: 2xAAA батареи\r\nДистанция: до 50 метров\r\nСкорость синхронизации: 1/125 сек', 'SLT-4RCR – дополнительный приемник к комплекту SLT-4, предназначен для подключения дополнительной накамерной или студийной вспышки. Устанавливается на стандартный винт 1/4" или в башмак камеры. ', 1, 4, 9);

-- 
-- Вывод данных для таблицы provider
--
INSERT INTO provider VALUES
(1, 'phototech', '87469251', 'ул. Пушкина, д. 17', '7419258', '63948', '10-20'),
(2, 'accessoriesforyou', '74963192', 'ул. Спирина, д.34', '7196483', '75842', '10-18'),
(3, 'photographic equipment', '74184692', 'ул. Заставская, д 10', '7593147', '95427', '10-19');

-- 
-- Вывод данных для таблицы receiving
--
INSERT INTO receiving VALUES
(1, 'доставка'),
(2, 'самовывоз');

-- 
-- Вывод данных для таблицы subtype
--
INSERT INTO subtype VALUES
(1, 'компакты', 1),
(2, 'штатив', 4),
(3, 'софбокс', 4),
(4, 'синхронизаторы', 4),
(5, 'зеркальные', 1),
(6, 'Для Canon', 2),
(7, 'Для Pentax', 2),
(8, 'Для Nikon', 2),
(9, 'Для Sony', 2),
(10, 'чехол/сумка', 3),
(11, 'носитель', 3),
(12, 'внешний аккумулятор', 3),
(15, 'Для micro 4/3 (Olympus, Panasonic)', 2);

-- 
-- Вывод данных для таблицы type
--
INSERT INTO type VALUES
(1, 'фотоаппарат'),
(2, 'объктив'),
(3, 'аксессуар'),
(4, 'студийное оборудование');

-- 
-- Вывод данных для таблицы user
--
INSERT INTO user VALUES
(1, 'Агап', 'Галкин', 'aggal@mail.ru', '123', 1),
(2, 'Али', 'Сорокин', 'alsor@mail.ru', '132', 1),
(3, 'Евгений', 'Гурин', 'evgen@mail.ru', 'step', 1),
(4, 'Ислам', 'Иванов', 'isivlam@mail.ru', '456', 1),
(5, 'Жигер', 'Смирнов', 'gigsmir@mail.ru', '657', 1),
(6, 'Евстахий', 'Анисимов', 'evani@mail.ru', 'qwerty', 1),
(7, 'Цефас', 'Максимов', 'qwjsdh@mail.ru', 'mnbv', 1),
(8, 'разработчик', 'Ксюша)', 'admin', '322', 2),
(9, 'проверка', 'вот', '123', '123', 1);

-- 
-- Восстановить предыдущий режим SQL (SQL mode)
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Включение внешних ключей
-- 
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;