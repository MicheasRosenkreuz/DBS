-- 1. Seznam dodavatel� (jm�no, m�sto), z nich� ka�d� n�co dod�v� (C je nejlep�� / nejrychlejsi)
/* A */ SELECT DISTINCT jmeno, mesto FROM Dodavatel INNER JOIN Dodava ON Dodavatel.cisdod = Dodava.cisdod
/* B */ SELECT DISTINCT jmeno, mesto FROM Dodavatel, Dodava WHERE Dodavatel.cisdod = Dodava.cisdod
/* C */ SELECT DISTINCT jmeno, mesto FROM Dodavatel WHERE cisdod IN ( SELECT cisdod FROM Dodava )
/* D */ SELECT jmeno, mesto FROM Dodavatel WHERE cisdod IN ( SELECT cisdod FROM Dodava GROUP BY cisdod )

-- 2. Seznam dodavatel� (jm�no, m�sto), kte�� nic nedod�vaj� (A je nejlep�� / nejrychlejsi)
/* A */ SELECT jmeno, mesto FROM Dodavatel WHERE Dodavatel.cisdod NOT IN ( SELECT cisdod FROM Dodava)
/* B */ SELECT DISTINCT jmeno, mesto FROM Dodavatel LEFT JOIN Dodava ON (Dodavatel.cisdod = Dodava.cisdod) WHERE Dodava.cisdos IS NULL
/* C */ SELECT cisdod FROM Dodavatel EXCEPT SELECT cisdod FROM Dodava // Tyl se pt� na ��sla dodavatel� pro tento p��pad.

-- 3. ��sla dodavatel�, kte�� dod�vaj� sou��stku ��slo 15
/* A */ SELECT cisdod FROM Dodava WHERE cissou = 15

-- 4. ��sla dodavatel�, kte�� dod�vaj� n�co, co nen� sou��stka ��slo 15
/* A */ SELECT DISTINCT cisdod FROM Dodava WHERE cissou != 15 -- <> nen� rovno

-- 5. ��sla dodavatel�, kte�� nedod�vaj� sou��stku ��slo 15
/* A */ SELECT cisdod FROM Dodavatel EXCEPT SELECT cisdod FROM Dodava WHERE cissou = 15
/* B */ SELECT cisdod FROM Dodavatel WHERE cisdod NOT IN ( SELECT cisdod FROM Dodava WHERE cissou = 15 )

-- 6. ��sla dodavatel�, kte�� dod�vaj� n�co i mimo sou��stky ��slo 15 (Neexistuj� dodavatel�)
/* A */ SELECT cisdod FROM Dodava WHERE cissou = 15 INTERSECT SELECT cisdod FROM Dodava WHERE cissou != 15
/* B */ SELECT DISTINCT cisdod FROM Dodava WHERE cissou != 15 AND cisdod IN ( SELECT cisdod FROM Dodava WHERE cissou = 15)
/* C */ SELECT X.cisdod FROM Dodava X, Dodava Y WHERE X.cissou = 15 AND Y.cissou != 15 AND X.cisdod = Y.cisdod

-- 7. ��sla dodavatel�, kte�� dod�vaj� pouze sou��stku ��slo 15
/* A */ SELECT cisdod FROM Dodava WHERE cissou = 15 EXCEPT SELECT cisdod FROM Dodava WHERE cissou != 15
/* B */ SELECT cisdod FROM Dodava WHERE cissou = 15 AND cisdod NOT IN ( SELECT cisdod FROM Dodava Where cissou != 15)
/* C */ SELECT X.cisdod FROM Dodava X WHERE X.cissou = 15 AND NOT EXISTS (SELECT Y.cisdod FROM Dodava Y WHERE X.cisdod = Y.cisdod AND Y.cissou <> 15)

-- 8. ��sla dodavatel�, kte�� dod�vaj� n�co, ale nedod�vaj� sou��stku ��slo 15
/* A */ SELECT cisdod FROM Dodava EXCEPT SELECT cisdod FROM Dodava WHERE cissou = 15
/* B */ SELECT DISTINCT cisdod FROM Dodava WHERE cisdod NOT IN (SELECT cisdod FROM Dodava WHERE cissou = 15) 

-- 9. ��sla dodavatel�, kte�� dod�vaj� alespo� sou��stky 12, 13, 15 (D je nejlep�� / nejrychlejsi)
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

-- 10. ��sla dodavatel�, kte�� dod�vaj� v�echny dod�van� sou��stky
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
			
-- 11. Seznam m�st, odkud poch�z� alespo� jedna �erven� sou��stka
SELECT DISTINCT mesto FROM Dodavatel, Dodava, Soucastka 
WHERE Dodavatel.cisdod = Dodava.cisdod 
AND Dodava.cissou = Soucastka.cissou
AND barva = 'cervena'

-- 12. Pr�m�rn� cena sou��stky
SELECT AVG(cena) AS 'Prumerna cena' FROM Soucastka

-- 13. Sou�et cen dod�van�ch sou��stek pro ka�d�ho dodavatele z Liberce, kter� dod�v� alespo� 5 sou��stek
SELECT jmeno AS 'Jmeno dodavatele', SUM(cena) AS 'Soucet cen' FROM Dodavatel A, Dodava B, Soucastka C 
WHERE A.cisdod = B.cisdod AND B.cissou = C.cissou AND mesto LIKE 'Jablonec%'
GROUP BY jmeno
HAVING COUNT(B.cissou) > 4