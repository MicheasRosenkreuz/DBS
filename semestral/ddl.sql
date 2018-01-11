/*
Created		07.01.2018
Modified		08.01.2018
Project		DBS2017 Semestral Project
Model		
Company		TUL
Author		Micheas Rosenkreuz
Version		2.2
Database		mySQL 5 

zmeny:
presunut atribut davkovani z tabulky recept do recept_leky
*/


drop table IF EXISTS recept_leky;
drop table IF EXISTS recept;
drop table IF EXISTS pojistovna;
drop table IF EXISTS leky;
drop table IF EXISTS nemocnice;
drop table IF EXISTS lekar;
drop table IF EXISTS zaznam;
drop table IF EXISTS pacient;


Create table pacient (
	pacient_rc Bigint NOT NULL,
	superpojistenec_rc Bigint,
	lekar_id Int NOT NULL,
	kod_pojistovny Int,
	jmeno Varchar(50) NOT NULL,
	prijmeni Varchar(50) NOT NULL,
	adresa Varchar(20) NOT NULL,
	telefon Varchar(13) NOT NULL,
	email Varchar(100),
 Primary Key (pacient_rc)) ENGINE = MyISAM;

Create table zaznam (
	pacient_rc Bigint NOT NULL,
	lekar_id Int NOT NULL,
	diagnoza Text NOT NULL,
	datum Timestamp NOT NULL,
	recept_id Int,
 Primary Key (pacient_rc,datum)) ENGINE = MyISAM;

Create table lekar (
	lekar_id Int NOT NULL,
	nemocnice_id Int NOT NULL,
	heslo Varchar(50) NOT NULL,
	specializace Varchar(100) NOT NULL,
	jmeno Varchar(50) NOT NULL,
	prijmeni Varchar(50) NOT NULL,
	telefon Varchar(13) NOT NULL,
	adresa Varchar(200) NOT NULL,
 Primary Key (lekar_id)) ENGINE = MyISAM;

Create table nemocnice (
	nemocnice_id Int NOT NULL,
	nazev Varchar(200) NOT NULL,
	adresa Varchar(200) NOT NULL,
	telefon Varchar(13) NOT NULL,
 Primary Key (nemocnice_id)) ENGINE = MyISAM;

Create table leky (
	lek_id Int NOT NULL,
	jmeno Varchar(20) NOT NULL,
	ucel Text NOT NULL,
	vedlejsi_ucinky Text NOT NULL,
	UNIQUE (jmeno),
 Primary Key (lek_id)) ENGINE = MyISAM;

Create table pojistovna (
	kod_pojistovny Int NOT NULL,
	nazev Varchar(100) NOT NULL,
 Primary Key (kod_pojistovny)) ENGINE = MyISAM;

Create table recept (
	recept_id Int NOT NULL,
	pacient_rc Int NOT NULL,
	lekar_id Int NOT NULL,
	datum_vydani Timestamp NOT NULL,
 Primary Key (recept_id)) ENGINE = MyISAM;

Create table recept_leky (
	recept_id Int NOT NULL,
	lek_id Int NOT NULL,
	davkovani Varchar(100) NOT NULL,
 Primary Key (recept_id,lek_id)) ENGINE = MyISAM;


Alter table zaznam add Foreign Key (pacient_rc) references pacient (pacient_rc) on delete  restrict on update cascade;
Alter table recept add Foreign Key (pacient_rc) references pacient (pacient_rc) on delete  restrict on update  restrict;
Alter table pacient add Foreign Key (superpojistenec_rc) references pacient (pacient_rc) on delete  restrict on update  restrict;
Alter table pacient add Foreign Key (lekar_id) references lekar (lekar_id) on delete  restrict on update cascade;
Alter table zaznam add Foreign Key (lekar_id) references lekar (lekar_id) on delete  restrict on update cascade;
Alter table recept add Foreign Key (lekar_id) references lekar (lekar_id) on delete  restrict on update cascade;
Alter table lekar add Foreign Key (nemocnice_id) references nemocnice (nemocnice_id) on delete  restrict on update cascade;
Alter table recept_leky add Foreign Key (lek_id) references leky (lek_id) on delete  restrict on update  restrict;
Alter table pacient add Foreign Key (kod_pojistovny) references pojistovna (kod_pojistovny) on delete set null on update cascade;
Alter table zaznam add Foreign Key (recept_id) references recept (recept_id) on delete  restrict on update cascade;
Alter table recept_leky add Foreign Key (recept_id) references recept (recept_id) on delete  restrict on update  restrict;


