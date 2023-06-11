SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS border;
DROP TABLE IF EXISTS reservation;
DROP TABLE IF EXISTS restaurant;
DROP TABLE IF EXISTS owner;
DROP TABLE IF EXISTS user;




/* Create Tables */

CREATE TABLE border
(
	title varchar(200) NOT NULL,
	content varchar(2000) NOT NULL,
	file1 varchar(200),
	regdate datetime,
	readcnt int,
	num int NOT NULL,
	boardid int,
	grp int,
	grplevel int,
	grpstep int,
	commcnt int,
	id varchar(15) NOT NULL,
	PRIMARY KEY (num),
	UNIQUE (id)
);


CREATE TABLE owner
(
	restaurantnum int NOT NULL,
	id varchar(15) NOT NULL,
	PRIMARY KEY (restaurantnum),
	UNIQUE (id)
);


CREATE TABLE reservation
(
	num int NOT NULL,
	id varchar(15) NOT NULL,
	reservationdate datetime NOT NULL,
	people int NOT NULL,
	currenttime datetime,
	restaurantnum int NOT NULL,
	confirm int NOT NULL,
	PRIMARY KEY (num),
	UNIQUE (id)
);


CREATE TABLE restaurant
(
	id varchar(15) NOT NULL,
	tel int NOT NULL,
	license varchar(50) NOT NULL,
	name varchar(40) NOT NULL,
	address varchar(100) NOT NULL,
	licensenum int(12) NOT NULL,
	picture varchar(100),
	restaurantnum int NOT NULL,
	PRIMARY KEY (restaurantnum),
	UNIQUE (id),
	UNIQUE (licensenum)
);


CREATE TABLE user
(
	id varchar(15) NOT NULL,
	pw varchar(20) NOT NULL,
	name varchar(15) NOT NULL,
	address varchar(50) NOT NULL,
	birthday date NOT NULL,
	nickname varchar(40) NOT NULL,
	batch int(1) NOT NULL,
	email varchar(40) NOT NULL,
	tel int NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (id),
	UNIQUE (nickname),
	UNIQUE (email),
	UNIQUE (tel)
);



/* Create Foreign Keys */

ALTER TABLE restaurant
	ADD FOREIGN KEY (restaurantnum)
	REFERENCES owner (restaurantnum)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE reservation
	ADD FOREIGN KEY (restaurantnum)
	REFERENCES restaurant (restaurantnum)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE border
	ADD FOREIGN KEY (id)
	REFERENCES user (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE owner
	ADD FOREIGN KEY (id)
	REFERENCES user (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE reservation
	ADD FOREIGN KEY (id)
	REFERENCES user (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



