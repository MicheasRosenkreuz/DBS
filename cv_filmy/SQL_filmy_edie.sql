/*
P��klad 2. � pomoc� jazyka SQL vy�e�te n�sleduj�c� zad�n�:

FILM (id_film, nazev, rok, reziser)
HODNOCEN� (id_reviewer, id_film, hodnoceni, datum)
REVIEWER (id_reviewer, jmeno, vip)
*/

-- 1. Najd�te n�zvy film�, kter� re��roval Steve Spielberg.
SELECT nazev FROM Film WHERE reziser = 'Steven Spielberg'

-- 2. Najd�te v�echny roky film�, kter� maj� hodnocen� 4 nebo 5 a se�a�te je vzestupn�.
SELECT DISTINCT rok FROM Film A, Hodnoceni B WHERE A.id_film = B.id_film AND B.hodnoceni > 3

-- 3. Najd�te n�zvy v�ech film�, kter� nemaj� hodnocen�.
SELECT DISTINCT nazev FROM Film, Hodnoceni WHERE Film.id_film NOT IN (SELECT id_film FROM Hodnoceni)

-- 4. N�kte�� hodnotitel� neposkytli datum sv�ho hodnocen�. Najd�te jm�na takov�ch hodnotitel�.
SELECT jmeno FROM Hodnoceni A, Reviewer B WHERE A.id_reviewer = B.id_reviewer AND A.datum IS NULL
go
-- 5. Napi�te dotaz, kter� vr�t� data o hodnocen� v �iteln�j��m form�tu: 
--	  jm�no hodnotitele, n�zev filmu, hodnocen� a datum hodnocen�. 
--    Set�i�te data podle jm�na hodnotitele, n�zvu filmu a nakonec podle hodnocen�.
CREATE VIEW uv_Prehled
AS
SELECT DISTINCT jmeno AS 'Jmeno hodnotitele', nazev AS 'Nazev filmu', hodnoceni AS 'Hodnoceni', datum AS 'Datum hodnoceni'
FROM Hodnoceni A, Film B, Reviewer C WHERE C.id_reviewer = A.id_reviewer AND B.id_film = A.id_film 
ORDER BY jmeno, nazev, hodnoceni
go

SELECT * FROM uv_Prehled ORDER BY 'Jmeno hodnotitele', 'Nazev filmu', 'Hodnoceni'

-- 6. Pro v�echny p��pady, kdy ur�it� reviewer hodnotil stejn� film dvakr�t a dal mu podruh� vy��� hodnocen�, 
--    vra�te jm�no reviewera a n�zev filmu.
SELECT nazev, jmeno FROM Reviewer, Film, (
	SELECT id_reviewer, id_film FROM Hodnoceni H1 WHERE EXISTS (
		SELECT * FROM Hodnoceni H2
		WHERE H1.id_film = H2.id_film 
			AND H1.id_reviewer = H2.id_reviewer
			AND H1.hodnoceni > H2.hodnoceni
			AND H1.datum > H2.datum
	)
) R
WHERE R.id_film = Film.id_film AND R.id_reviewer = Reviewer.id_reviewer

-- 7. Pro ka�d� film, kter� m� n�jak� hodnocen�, najd�te nejvy��� dosa�en� hodnocen�. Vypi�te n�zev filmu a hodnocen�, set�i�te podle n�zvu filmu.
/* A */ SELECT nazev, MAX(hodnoceni) as maximum FROM Film, Hodnoceni WHERE Film.id_film = Hodnoceni.id_film GROUP BY nazev ORDER BY nazev
/* B */ SELECT nazev, maximum FROM Film, (
			SELECT id_film, max(Hodnoceni) AS maximum FROM Hodnoceni GROUP BY id_film
		) MXM WHERE MXM.id_film = Film.id_film ORDER BY nazev

-- 8. Pro ka�d� film nalezn�te n�zev filmu a rozsah hodnocen�, co� je rozd�l mezi nejvy���m a nejni���m hodnocen�m. Set�i�te nejd��ve podle rozsahu od nejvy���ho po nejni���, potom podle n�zvu filmu.
/* A */ SELECT nazev, (maximum-minimum) AS rozsah FROM Film, (
			SELECT id_film, MAX(hodnoceni) AS maximum, MIN(hodnoceni) AS minimum FROM Hodnoceni GROUP BY id_film
		) R
		WHERE R.id_film = Film.id_film ORDER BY rozsah DESC, nazev
/* B */ SELECT nazev, MAX(hodnoceni)-MIN(hodnoceni) AS rozsah FROM Film F, Hodnoceni H
		WHERE H.id_film = F.id_film GROUP BY nazev ORDER BY rozsah, nazev

-- 9. Najd�te rozd�l mezi pr�m�rn�m hodnocen�m film� uveden�ch p�ed rokem 1980 a pr�m�rn� hodnocen� film� uveden�ch od roku 1980. Ujist�te se, �e jste spo��tali pr�m�rn� hodnocen� nejd��ve pro ka�d� film a pak pr�m�r t�chto pr�m�r� p�ed rokem 1980 a po roce 1980.
SELECT pred.avgpred1980 - po.avgpo1980 AS rozdil FROM(
	SELECT AVG(prumer) AS avgpred1980 FROM (
		SELECT Film.id_film, AVG(CONVERT(float, hodnoceni)) AS prumer
		FROM Film, Hodnoceni WHERE Film.id_film = Hodnoceni.id_film AND rok < 1980 
		GROUP BY Film.id_film 
	) avgpred1980
) pred, (
	SELECT AVG(prumer) AS avgpo1980 FROM (
		SELECT Film.id_film, AVG(CONVERT(float, hodnoceni)) AS prumer
		FROM Film, Hodnoceni WHERE Film.id_film = Hodnoceni.id_film AND rok >= 1980 
		GROUP BY Film.id_film 
	) avgpo1980
) po

-- 10. Najd�te jm�na v�ech reviewer�, kte�� p�isp�li t�emi a v�ce hodnocen�mi. Pokuste se napsat dotaz bez pou�it� HAVING nebo bez Count.
 SELECT jmeno FROM Reviewer R JOIN HODNOCENI H ON (R.id_reviewer = H.id_reviewer) GROUP BY jmeno HAVING COUNT(H.id_reviewer)>=3

 --nefunguje uplne spravne
 SELECT DISTINCT H1.id_reviewer FROM Hodnoceni H1,Hodnoceni H2,Hodnoceni H3 
 WHERE H1.id_reviewer=H2.id_reviewer AND H1.id_reviewer=H3.id_reviewer AND H2.id_reviewer=H3.id_reviewer AND H1.id_film!=H2.id_film AND H1.id_film!=H3.id_film AND H2.id_film!=H3.id_film






