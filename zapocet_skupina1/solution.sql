/* 
reservation(reservation_id, user_id, car_id, parking_from_id, parking_to_id, status, date_from, date_to)
users(user_id, user_name, adress)
parking(park_id, park_adress, gps)
cars(car_id,car_name,popis)
*/

-- 2) Pomoc� SQL vypi�te pro v�echny u�ivatele z tab. User po�et jejich rezervac� (user_name, pocet).
-- Pro u�ivatele, kte�� nemaj� ��dn� rezervace bude ve v�pisu hodnota NULL.(3)

select user_name, pocet from users u left join (select user_id, count(reservation_id) as pocet from reservation group by user_id) r on u.user_id=r.user_id
go
select u.user_name,  nullif(count(r.reservation_id), 0) from users u left join reservation r on u.[user_id]=r.[user_id] group by u.[user_id], u.user_name
go

SELECT distinct user_name, null FROM users U  WHERE U.user_id NOT IN (SELECT user_id FROM reservation)
union
SELECT user_name, COUNT(reservation_id) as 'pocet' FROM users U, reservation R WHERE U.user_id = R.user_id GROUP BY U.user_name
go
-- 3) Pomoc� SQL vypi�te osoby (user_name), kter� jely, cht�li jet nebo cht�j� jet dva a v�cekr�t (li�� se jen atribut status)
-- stejn�m autem ze stejn�ho parkovi�t�.(3)
select user_name from users u join reservation r on u.user_id=r.user_id group by u.user_id, user_name, car_id, parking_from_id having count(reservation_id)>=2
go
/*select user_name from users u join reservation r on u.user_id=r.user_id 
							  join cars c on c.car_id=r.car_id
							  join parking p on p.park_id=r.parking_from_id
group by u.user_id, user_name having count(reservation_id)>=2
go*/
-- 4) Pomoc� SQL vypi�te jm�na osob(user_name), kter� nikdy nikam nejeli.
select user_name from users where users.user_id not in(select user_id from reservation)
go
-- 5) Pomoc� SQL vypi�te p�ehled j�zd - KDO (user_name), s ��m (car_name), ODKUD(departture, tj. parking_name),
-- KAM(arrival, tj. parking_name) a KDY(start_time)(3)
select user_name as KDO, car_name as CIM, odkud.park_adress as ODKUD, kam.park_adress as KAM, date_from as KDY
from reservation r left join users u on r.user_id=u.user_id 
					left join cars c on r.car_id=c.car_id
					left join parking odkud on odkud.park_id=r.parking_from_id
					left join parking kam on kam.park_id=r.parking_to_id
-- 6) Vysv�tlete parcialitu vztahu User - Reservation(1)
-- obpov��: Ka�d� u�ivatel M��E m�t v�ce rezervac� a ka�d� rezervace MUS� m�t u�ivatele...

-- 7) Napi�te ��st DDL skriptu, kter�m byste nastavili unik�nost atributu car_name z tab. Car(1)
ALTER TABLE cars ADD CONSTRAINT "uniq_car_name" UNIQUE (car_name)
GO 
