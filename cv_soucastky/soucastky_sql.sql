/********************************************************************************
Pr�ce s datab�z� Soucastky

Dodavatel (jmeno, adresa, mesto, cisdod (PK))
Dodava (cisdod (PFK), cissou (PFK))
Soucastka (cissou(PK), cena, barva)

Pomoc� createScriptu si vytvo�te datab�zy.
Pomoc� insert scriptu do n� vlo�te data

Pomoc� SQL napi�te dotazy:
*********************************************************************************/

/********************************************************************************
1. Vypi�te seznam dodavatel� (jmeno, mesto), z nich� ka�d� n�co dod�v�.
*********************************************************************************/
 select jmeno, mesto from Dodavatel where cisdod in (select cisdod from Dodava group by cisdod);
/************************************************************************************
2. Vypi�te seznam dodavatel� (jmeno, mesto), kte�� nic nedod�vaj�.
*************************************************************************************/
 select jmeno, mesto from Dodavatel where cisdod not in (select cisdod from Dodava group by cisdod);
/************************************************************************************
3. Najd�te ��sla dodavatel�, kte�� dod�vaj� sou��stku ��slo 15.
*************************************************************************************/
select cisdod from Dodava where cissou=15;
/************************************************************************************
4. Najd�te ��sla dodavatel�, kte�� dod�vaj� n�co, co nen� sou��stka ��slo 15.
*************************************************************************************/
select cisdod from Dodava where cissou!=15;
/************************************************************************************
5. Najd�te ��sla dodavatel�, kte�� nedod�vaj� sou��stku ��slo 15.
*************************************************************************************/
select cisdod from Dodavatel where cisdod not in (select cisdod from Dodava where cissou=15);
/************************************************************************************
6.Najd�te ��sla dodavatel�, kte�� dod�vaj� n�co i mimo sou��stku ��slo 15.
*************************************************************************************/
select cisdod from Dodavatel where cisdod in (select cisdod from Dodava where cissou=15)
and cisdod in (select cisdod from Dodava where cissou!=15);
/************************************************************************************
7. Najd�te ��sla dodavatel�, kte�� dod�vaj� pouze sou��stku ��slo 15.
*************************************************************************************/
select cisdod from Dodavatel where cisdod in (select cisdod from Dodava where cissou=15)
and cisdod not in (select cisdod from Dodava where cissou!=15);
/************************************************************************************
8. Najd�te ��sla dodavatel�, kte�� dod�vaj� n�co, ale nedod�vaj� sou��stku ��slo 15.
*************************************************************************************/
select cisdod from Dodavatel where cisdod in (select cisdod from Dodava where cissou!=15)
and cisdod not in (select cisdod from Dodava where cissou=15);
/************************************************************************************
9. Najd�te ��sla dodavatel�, kte�� dod�vaj� alespo� sou��stky 12, 13, 15. 
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
10. Najd�te ��sla dodavatel�, kte�� dod�vaj� v�echny dod�van� sou��stky.
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
X odstran�no 11. Vypi�te seznam m�st, odkud poch�z� alespo� jedna �erven� sou��stka.
*************************************************************************************/
SELECT DISTINCT mesto FROM Dodavatel, Dodava, Soucastka 
WHERE Dodavatel.cisdod = Dodava.cisdod 
AND Dodava.cissou = Soucastka.cissou
AND barva = 'cervena'
/************************************************************************************
11. Vypi�te pr�m�rnou cenu sou��stky.
*************************************************************************************/
SELECT AVG(cena) AS 'Prumerna cena' FROM Soucastka
/************************************************************************************
12. Vypi�te sou�et cen dod�van�ch sou��stek pro ka�d�ho dodavatele z Liberec, kter� dod�v� alespo� 5 sou��stek.
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