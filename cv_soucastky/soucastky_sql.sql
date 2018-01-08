/********************************************************************************
Práce s databází Soucastky

Dodavatel (jmeno, adresa, mesto, cisdod (PK))
Dodava (cisdod (PFK), cissou (PFK))
Soucastka (cissou(PK), cena, barva)

Pomocí createScriptu si vytvoøte databázy.
Pomocí insert scriptu do ní vložte data

Pomocí SQL napište dotazy:
*********************************************************************************/

/********************************************************************************
1. Vypište seznam dodavatelù (jmeno, mesto), z nichž každý nìco dodává.
*********************************************************************************/
 select jmeno, mesto from Dodavatel where cisdod in (select cisdod from Dodava group by cisdod);
/************************************************************************************
2. Vypište seznam dodavatelù (jmeno, mesto), kteøí nic nedodávají.
*************************************************************************************/
 select jmeno, mesto from Dodavatel where cisdod not in (select cisdod from Dodava group by cisdod);
/************************************************************************************
3. Najdìte èísla dodavatelù, kteøí dodávají souèástku èíslo 15.
*************************************************************************************/
select cisdod from Dodava where cissou=15;
/************************************************************************************
4. Najdìte èísla dodavatelù, kteøí dodávají nìco, co není souèástka èíslo 15.
*************************************************************************************/
select cisdod from Dodava where cissou!=15;
/************************************************************************************
5. Najdìte èísla dodavatelù, kteøí nedodávají souèástku èíslo 15.
*************************************************************************************/
select cisdod from Dodavatel where cisdod not in (select cisdod from Dodava where cissou=15);
/************************************************************************************
6.Najdìte èísla dodavatelù, kteøí dodávají nìco i mimo souèástku èíslo 15.
*************************************************************************************/
select cisdod from Dodavatel where cisdod in (select cisdod from Dodava where cissou=15)
and cisdod in (select cisdod from Dodava where cissou!=15);
/************************************************************************************
7. Najdìte èísla dodavatelù, kteøí dodávají pouze souèástku èíslo 15.
*************************************************************************************/
select cisdod from Dodavatel where cisdod in (select cisdod from Dodava where cissou=15)
and cisdod not in (select cisdod from Dodava where cissou!=15);
/************************************************************************************
8. Najdìte èísla dodavatelù, kteøí dodávají nìco, ale nedodávají souèástku èíslo 15.
*************************************************************************************/
select cisdod from Dodavatel where cisdod in (select cisdod from Dodava where cissou!=15)
and cisdod not in (select cisdod from Dodava where cissou=15);
/************************************************************************************
9. Najdìte èísla dodavatelù, kteøí dodávají alespoò souèástky 12, 13, 15. 
*************************************************************************************/
--/A/--
select d1.cisdod from Dodava as d1 
	left join Dodava as d2 on d1.cisdod=d2.cisdod  
	left join Dodava as d3 on d2.cisdod=d3.cisdod 
	where d1.cissou=12 and d2.cissou=13 and d3.cissou=15
	
--/B/--
select cisdod from Dodava where cissou=12
INTERSECT
select cisdod from Dodava where cissou=13
INTERSECT
select cisdod from Dodava where cissou=15

/************************************************************************************
10. Najdìte èísla dodavatelù, kteøí dodávají všechny dodávané souèástky.
*************************************************************************************/
/* A */ SELECT cisdod FROM Dodava 
		EXCEPT 
		SELECT DISTINCT cisdod FROM (
			SELECT * FROM (
				SELECT cisdod FROM Dodava
			) R1, ( 
				SELECT cissou FROM Dodava
			) R2
			EXCEPT
			SELECT * FROM Dodava
		) R3
/* B */ SELECT DISTINCT A.cisdod, B.cissou FROM Dodava A CROSS JOIN Dodava B
		EXCEPT 
		SELECT cisdod FROM (
			SELECT DISTINCT A.cisdod, B.cissou
			FROM Dodava A, Dodava B
			EXCEPT
			SELECT cisdod, cissou FROM Dodava
		) AS X
/* C */ SELECT cisdod FROM Dodava
		GROUP BY cisdod
		HAVING COUNT(cissou) = (SELECT COUNT(DISTINCT cissou) FROM Dodava)
/* D */ SELECT X.cisdod FROM Dodavatel X 
		WHERE NOT EXISTS(
			SELECT Y.cisdod FROM Dodava Y
			WHERE Y.cissou NOT IN (
				SELECT Z.cissou FROM Dodava Z
				WHERE Z.cisdod = X.cisdod
			)
		)
			
/************************************************************************************
X odstranìno 11. Vypište seznam mìst, odkud pochází alespoò jedna èervená souèástka.
*************************************************************************************/
SELECT DISTINCT mesto FROM Dodavatel, Dodava, Soucastka 
WHERE Dodavatel.cisdod = Dodava.cisdod 
AND Dodava.cissou = Soucastka.cissou
AND barva = 'cervena'
/************************************************************************************
11. Vypište prùmìrnou cenu souèástky.
*************************************************************************************/
SELECT AVG(cena) AS 'Prumerna cena' FROM Soucastka
/************************************************************************************
12. Vypište souèet cen dodávaných souèástek pro každého dodavatele z Liberec, který dodává alespoò 5 souèástek.
*************************************************************************************/
--/ A /--
select Dodavatel.cisdod, d.cena from Dodavatel right 
	join (select cisdod, sum(cena) as 'cena' from Dodava join Soucastka on Dodava.cissou=Soucastka.cissou
		  where Dodava.cisdod in (select cisdod from Dodava group by cisdod having count(cisdod)>=2)group by cisdod) as d 
	on Dodavatel.cisdod = d.cisdod where dodavatel.mesto='Liberec'

--/ B /--
SELECT jmeno AS 'Jmeno dodavatele', SUM(cena) AS 'Soucet cen' FROM Dodavatel A, Dodava B, Soucastka C 
WHERE A.cisdod = B.cisdod AND B.cissou = C.cissou AND mesto LIKE 'Jablonec%'
GROUP BY jmeno
HAVING COUNT(B.cissou) > 4