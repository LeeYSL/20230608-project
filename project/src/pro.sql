SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS board;
DROP TABLE IF EXISTS dayoff;
DROP TABLE IF EXISTS menu;
DROP TABLE IF EXISTS review;
DROP TABLE IF EXISTS reservation;
DROP TABLE IF EXISTS restaurant;
DROP TABLE IF EXISTS user;




/* Create Tables */

CREATE TABLE board
(
	num int NOT NULL,
	user_id varchar(15) NOT NULL,
	title varchar(200) NOT NULL,
	content varchar(2000) NOT NULL,
	file1 varchar(200),
	reg_date datetime,
	read_cnt int,
	board_id int,
	grp int,
	grp_level int,
	grp_step int,
	comm_cnt int,
	secret varchar(1),
	PRIMARY KEY (num)
);


CREATE TABLE comment
(
	num int NOT NULL,
	seq int NOT NULL,
	user_id varchar(15) NOT NULL,
	date datetime,
	content varchar(100),
	PRIMARY KEY (num, seq)
);


CREATE TABLE dayoff
(
	rest_num int NOT NULL,
	Mon varchar(50),
	Tue varchar(50),
	Wed varchar(50),
	Thur varchar(50),
	Fri varchar(50),
	Sat varchar(50),
	Sun varchar(50),
	holiday varchar(50),
	PRIMARY KEY (rest_num)
);


CREATE TABLE menu
(
	seq int NOT NULL,
	rest_num int NOT NULL,
	menu_name varchar(100),
	price int,
	PRIMARY KEY (seq, rest_num)
);


CREATE TABLE reservation
(
	num int NOT NULL,
	rest_num int NOT NULL,
	rsrvt_date varchar(100) NOT NULL,
	people int NOT NULL,
	reg_date datetime,
	confirm int NOT NULL,
	phone_no varchar(100) NOT NULL,
	rsrvt_name varchar(100),
	user_id varchar(100) NOT NULL,
	PRIMARY KEY (num)
);


CREATE TABLE restaurant
(
	rest_num int NOT NULL,
	user_id varchar(15) NOT NULL,
	tel varchar(100) NOT NULL,
	name varchar(40) NOT NULL,
	address varchar(100) NOT NULL,
	license_num int(12) NOT NULL,
	picture varchar(100),
	maxpeople int NOT NULL,
	open varchar(100),
	close varchar(100),
	menu varchar(100),
	rest_phoneno varchar(100),
	PRIMARY KEY (rest_num),
	UNIQUE (license_num)
);


CREATE TABLE review
(
	num int NOT NULL,
	seq int NOT NULL,
	rest_num int NOT NULL,
	date datetime,
	point int,
	photo varchar(100),
	content varchar(100),
	grp_step int,
	grp_level int,
	grp int,
	user_id varchar(15) NOT NULL,
	PRIMARY KEY (num, seq),
	UNIQUE (user_id)
);


CREATE TABLE user
(
	user_id varchar(15) NOT NULL,
	pw varchar(200) NOT NULL,
	name varchar(15) NOT NULL,
	address varchar(50) NOT NULL,
	nickname varchar(40) NOT NULL,
	batch int(1) NOT NULL,
	tel varchar(13) NOT NULL,
	reg_date date NOT NULL,
	photo varchar(100),
	PRIMARY KEY (user_id),
	UNIQUE (user_id),
	UNIQUE (nickname),
	UNIQUE (tel)
);



/* Create Foreign Keys */

ALTER TABLE comment
	ADD FOREIGN KEY (num)
	REFERENCES board (num)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE review
	ADD FOREIGN KEY (num)
	REFERENCES reservation (num)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE dayoff
	ADD FOREIGN KEY (rest_num)
	REFERENCES restaurant (rest_num)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE menu
	ADD FOREIGN KEY (rest_num)
	REFERENCES restaurant (rest_num)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE reservation
	ADD FOREIGN KEY (rest_num)
	REFERENCES restaurant (rest_num)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE board
	ADD FOREIGN KEY (user_id)
	REFERENCES user (user_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE comment
	ADD FOREIGN KEY (user_id)
	REFERENCES user (user_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



