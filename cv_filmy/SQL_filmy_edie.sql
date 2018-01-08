/*
Pøíklad 2. – pomocí jazyka SQL vyøešte následující zadání:

FILM (id_film, nazev, rok, reziser)
HODNOCENÍ (id_reviewer, id_film, hodnoceni, datum)
REVIEWER (id_reviewer, jmeno, vip)
*/

-- 1. Najdìte názvy filmù, které režíroval Steve Spielberg.
SELECT nazev FROM Film WHERE reziser = 'Steven Spielberg'

-- 2. Najdìte všechny roky filmù, které mají hodnocení 4 nebo 5 a seøaïte je vzestupnì.
SELECT DISTINCT rok FROM Film A, Hodnoceni B WHERE A.id_film = B.id_film AND B.hodnoceni > 3

-- 3. Najdìte názvy všech filmù, které nemají hodnocení.
SELECT DISTINCT nazev FROM Film, Hodnoceni WHERE Film.id_film NOT IN (SELECT id_film FROM Hodnoceni)

-- 4. Nìkteøí hodnotitelé neposkytli datum svého hodnocení. Najdìte jména takových hodnotitelù.
SELECT jmeno FROM Hodnoceni A, Reviewer B WHERE A.id_reviewer = B.id_reviewer AND A.datum IS NULL
go
-- 5. Napište dotaz, který vrátí data o hodnocení v èitelnìjším formátu: 
--	  jméno hodnotitele, název filmu, hodnocení a datum hodnocení. 
--    Setøiïte data podle jména hodnotitele, názvu filmu a nakonec podle hodnocení.
CREATE VIEW uv_Prehled
AS
SELECT DISTINCT jmeno AS 'Jmeno hodnotitele', nazev AS 'Nazev filmu', hodnoceni AS 'Hodnoceni', datum AS 'Datum hodnoceni'
FROM Hodnoceni A, Film B, Reviewer C WHERE C.id_reviewer = A.id_reviewer AND B.id_film = A.id_film 
ORDER BY jmeno, nazev, hodnoceni
go

SELECT * FROM uv_Prehled ORDER BY 'Jmeno hodnotitele', 'Nazev filmu', 'Hodnoceni'

-- 6. Pro všechny pøípady, kdy urèitý reviewer hodnotil stejný film dvakrát a dal mu podruhé vyšší hodnocení, 
--    vrate jméno reviewera a název filmu.
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

-- 7. Pro každý film, který má nìjaké hodnocení, najdìte nejvyšší dosažené hodnocení. Vypište název filmu a hodnocení, setøiïte podle názvu filmu.
/* A */ SELECT nazev, MAX(hodnoceni) as maximum FROM Film, Hodnoceni WHERE Film.id_film = Hodnoceni.id_film GROUP BY nazev ORDER BY nazev
/* B */ SELECT nazev, maximum FROM Film, (
			SELECT id_film, max(Hodnoceni) AS maximum FROM Hodnoceni GROUP BY id_film
		) MXM WHERE MXM.id_film = Film.id_film ORDER BY nazev

-- 8. Pro každý film naleznìte název filmu a rozsah hodnocení, což je rozdíl mezi nejvyšším a nejnižším hodnocením. Setøiïte nejdøíve podle rozsahu od nejvyššího po nejnižší, potom podle názvu filmu.
/* A */ SELECT nazev, (maximum-minimum) AS rozsah FROM Film, (
			SELECT id_film, MAX(hodnoceni) AS maximum, MIN(hodnoceni) AS minimum FROM Hodnoceni GROUP BY id_film
		) R
		WHERE R.id_film = Film.id_film ORDER BY rozsah DESC, nazev
/* B */ SELECT nazev, MAX(hodnoceni)-MIN(hodnoceni) AS rozsah FROM Film F, Hodnoceni H
		WHERE H.id_film = F.id_film GROUP BY nazev ORDER BY rozsah, nazev

-- 9. Najdìte rozdíl mezi prùmìrným hodnocením filmù uvedených pøed rokem 1980 a prùmìrné hodnocení filmù uvedených od roku 1980. Ujistìte se, že jste spoèítali prùmìrné hodnocení nejdøíve pro každý film a pak prùmìr tìchto prùmìrù pøed rokem 1980 a po roce 1980.
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

-- 10. Najdìte jména všech reviewerù, kteøí pøispìli tøemi a více hodnoceními. Pokuste se napsat dotaz bez použití HAVING nebo bez Count.
 SELECT jmeno FROM Reviewer R JOIN HODNOCENI H ON (R.id_reviewer = H.id_reviewer) GROUP BY jmeno HAVING COUNT(H.id_reviewer)>=3

 --nefunguje uplne spravne
 SELECT DISTINCT H1.id_reviewer FROM Hodnoceni H1,Hodnoceni H2,Hodnoceni H3 
 WHERE H1.id_reviewer=H2.id_reviewer AND H1.id_reviewer=H3.id_reviewer AND H2.id_reviewer=H3.id_reviewer AND H1.id_film!=H2.id_film AND H1.id_film!=H3.id_film AND H2.id_film!=H3.id_film






