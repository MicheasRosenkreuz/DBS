-- 1. Seznam dodavatelù (jméno, mìsto), z nichž každý nìco dodává (C je nejlepší / nejrychlejsi)
/* A */ SELECT DISTINCT jmeno, mesto FROM Dodavatel INNER JOIN Dodava ON Dodavatel.cisdod = Dodava.cisdod
/* B */ SELECT DISTINCT jmeno, mesto FROM Dodavatel, Dodava WHERE Dodavatel.cisdod = Dodava.cisdod
/* C */ SELECT DISTINCT jmeno, mesto FROM Dodavatel WHERE cisdod IN ( SELECT cisdod FROM Dodava )
/* D */ SELECT jmeno, mesto FROM Dodavatel WHERE cisdod IN ( SELECT cisdod FROM Dodava GROUP BY cisdod )

-- 2. Seznam dodavatelù (jméno, mìsto), kteøí nic nedodávají (A je nejlepší / nejrychlejsi)
/* A */ SELECT jmeno, mesto FROM Dodavatel WHERE Dodavatel.cisdod NOT IN ( SELECT cisdod FROM Dodava)
/* B */ SELECT DISTINCT jmeno, mesto FROM Dodavatel LEFT JOIN Dodava ON (Dodavatel.cisdod = Dodava.cisdod) WHERE Dodava.cisdos IS NULL
/* C */ SELECT cisdod FROM Dodavatel EXCEPT SELECT cisdod FROM Dodava // Tyl se ptá na èísla dodavatelù pro tento pøípad.

-- 3. Èísla dodavatelù, kteøí dodávají souèástku èíslo 15
/* A */ SELECT cisdod FROM Dodava WHERE cissou = 15

-- 4. Èísla dodavatelù, kteøí dodávají nìco, co není souèástka èíslo 15
/* A */ SELECT DISTINCT cisdod FROM Dodava WHERE cissou != 15 -- <> není rovno

-- 5. Èísla dodavatelù, kteøí nedodávají souèástku èíslo 15
/* A */ SELECT cisdod FROM Dodavatel EXCEPT SELECT cisdod FROM Dodava WHERE cissou = 15
/* B */ SELECT cisdod FROM Dodavatel WHERE cisdod NOT IN ( SELECT cisdod FROM Dodava WHERE cissou = 15 )

-- 6. Èísla dodavatelù, kteøí dodávají nìco i mimo souèástky èíslo 15 (Neexistují dodavatelé)
/* A */ SELECT cisdod FROM Dodava WHERE cissou = 15 INTERSECT SELECT cisdod FROM Dodava WHERE cissou != 15
/* B */ SELECT DISTINCT cisdod FROM Dodava WHERE cissou != 15 AND cisdod IN ( SELECT cisdod FROM Dodava WHERE cissou = 15)
/* C */ SELECT X.cisdod FROM Dodava X, Dodava Y WHERE X.cissou = 15 AND Y.cissou != 15 AND X.cisdod = Y.cisdod

-- 7. Èísla dodavatelù, kteøí dodávají pouze souèástku èíslo 15
/* A */ SELECT cisdod FROM Dodava WHERE cissou = 15 EXCEPT SELECT cisdod FROM Dodava WHERE cissou != 15
/* B */ SELECT cisdod FROM Dodava WHERE cissou = 15 AND cisdod NOT IN ( SELECT cisdod FROM Dodava Where cissou != 15)
/* C */ SELECT X.cisdod FROM Dodava X WHERE X.cissou = 15 AND NOT EXISTS (SELECT Y.cisdod FROM Dodava Y WHERE X.cisdod = Y.cisdod AND Y.cissou <> 15)

-- 8. Èísla dodavatelù, kteøí dodávají nìco, ale nedodávají souèástku èíslo 15
/* A */ SELECT cisdod FROM Dodava EXCEPT SELECT cisdod FROM Dodava WHERE cissou = 15
/* B */ SELECT DISTINCT cisdod FROM Dodava WHERE cisdod NOT IN (SELECT cisdod FROM Dodava WHERE cissou = 15) 

-- 9. Èísla dodavatelù, kteøí dodávají alespoò souèástky 12, 13, 15 (D je nejlepší / nejrychlejsi)
/* A */ SELECT cisdod FROM Dodava WHERE cissou = 12 
		INTERSECT 
		SELECT cisdod FROM Dodava WHERE cissou = 13 
		INTERSECT 
		SELECT cisdod FROM Dodava WHERE cissou = 15
/* B */ SELECT DISTINCT cisdod FROM Dodava D
		WHERE (12) IN (
			SELECT cissou FROM DODAVA E WHERE D.cisdod = E.cisdod
		) AND (13) IN (
			SELECT cissou FROM DODAVA E WHERE D.cisdod = E.cisdod
		) AND (15) IN (
			SELECT cissou FROM DODAVA E WHERE D.cisdod = E.cisdod
		)
/* C */ SELECT X.cisdod, 
			   X.cissou AS 'cissou X',
			   Y.cissou AS 'cissou Y',
			   Z.cissou AS 'cissou Z'
		FROM Dodava X, Dodava Y, Dodava Z
		WHERE X.cisdod = Y.cisdod AND Y.cisdod = Z.cisdod
			AND X.cissou = 12
			AND Y.cissou = 13
			AND Z.cissou = 15
/* D */ SELECT cisdod, COUNT(cisdod) FROM Dodava WHERE cissou IN (12, 13, 15) GROUP BY cisdod HAVING COUNT(cisdod) = 3

-- 10. Èísla dodavatelù, kteøí dodávají všechny dodávané souèástky
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
			
-- 11. Seznam mìst, odkud pochází alespoò jedna èervená souèástka
SELECT DISTINCT mesto FROM Dodavatel, Dodava, Soucastka 
WHERE Dodavatel.cisdod = Dodava.cisdod 
AND Dodava.cissou = Soucastka.cissou
AND barva = 'cervena'

-- 12. Prùmìrná cena souèástky
SELECT AVG(cena) AS 'Prumerna cena' FROM Soucastka

-- 13. Souèet cen dodávaných souèástek pro každého dodavatele z Liberce, který dodává alespoò 5 souèástek
SELECT jmeno AS 'Jmeno dodavatele', SUM(cena) AS 'Soucet cen' FROM Dodavatel A, Dodava B, Soucastka C 
WHERE A.cisdod = B.cisdod AND B.cissou = C.cissou AND mesto LIKE 'Jablonec%'
GROUP BY jmeno
HAVING COUNT(B.cissou) > 4