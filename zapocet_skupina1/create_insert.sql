
CREATE TABLE cars (
  car_id int NOT NULL PRIMARY KEY,
  car_name varchar(50) NOT NULL,
  popis varchar(200) NOT NULL
);
go
CREATE TABLE users (
  user_id int NOT NULL PRIMARY KEY,
  user_name varchar(50) NOT NULL,
  adress varchar(200) NOT NULL
);
go

CREATE TABLE parking (
  park_id int NOT NULL PRIMARY KEY,
  park_adress varchar(50) NOT NULL,
  GPS varchar(200) NOT NULL
);
go

create table reservation (
  reservation_id int NOT NULL PRIMARY KEY,
  user_id int NOT NULL,
  car_id int NOT NULL,
  parking_from_id int NOT NULL,
  parking_to_id int NOT NULL,
  status varchar(50) NOT NULL,
  date_from date NOT NULL,
  date_to date NOT NULL,
)
go

insert into cars (car_id, car_name, popis)
values (1, 'Skodofka', 'JezdiBenzin')
insert into cars (car_id, car_name, popis)
values (2, 'Ferari', 'NejezdiBenzin')
insert into cars (car_id, car_name, popis)
values (3, 'Fauve', 'Nafta')

insert into users (user_id, user_name, adress)
values (1, 'Jirka', 'V moste')
insert into users (user_id, user_name, adress)
values (2, 'Franta', 'Nad mostem')
insert into users (user_id, user_name, adress)
values (3, 'Pepek', 'Pod mostem')

insert into parking (park_id, park_adress, GPS)
values (1, 'U homouska', '22.18461305846,9.54136121583581')
insert into parking (park_id, park_adress, GPS)
values (2, 'U salamu', '10.72897941894338,89.8952636541581')
insert into parking (park_id, park_adress, GPS)
values (3, 'V jedlickane', '50.72897994515338,14.895263621583581')

insert into reservation (reservation_id, user_id, car_id, parking_from_id, parking_to_id, status, date_from, date_to)
values (1, 1, 1, 1, 2, 'vyzvednuto', getdate(), DATEADD(DAY, -7, GETDATE()))
insert into reservation (reservation_id, user_id, car_id, parking_from_id, parking_to_id, status, date_from, date_to)
values (2, 2, 2, 2, 3, 'vyzvednuto', getdate(), DATEADD(DAY, -7, GETDATE()))