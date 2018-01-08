-- 1. Najd�te n�zvy film�, kter� re��roval Steven Spielberg.
SELECT nazev from Film  where reziser='Steven Spielberg'
-- 2. Najd�te v�echny roky film�, kter� maj� hodnocen� 4 nebo 5 a se�a�te je vzestupn�.
select distinct rok from Film join Hodnoceni on Film.id_film=Hodnoceni.id_film where hodnoceni=4 or hodnoceni=5 order by rok
-- 3. Najd�te n�zvy v�ech film�, kter� nemaj� hodnocen�.
select nazev from Film where id_film not in(select id_film from Hodnoceni)

-- 4. N�kte�� hodnotitel� neposkytli datum sv�ho hodnocen�. Najd�te jm�na takov�ch hodnotitel�.
select distinct jmeno from Hodnoceni  h join Reviewer r on h.id_reviewer=r.id_reviewer 
-- 5. Napi�te dotaz, kter� vr�t� data o hodnocen� v �iteln�j��m form�tu: jm�no hodnotitele, n�zev filmu, hodnocen� a datum hodnocen�. Set�i�te data podle jm�na hodnotitele, n�zvu filmu a nakonec podle hodnocen�.
select jmeno, nazev, hodnoceni, datum from Hodnoceni h left outer join Film f on h.id_film=f.id_film left outer join Reviewer r on r.id_reviewer=h.id_reviewer order by jmeno, nazev, hodnoceni
-- 6. Pro v�echny p��pady, kdy ur�it� reviewer hodnotil stejn� film dvakr�t a dal mu podruh� vy��� hodnocen�, vra�te jm�no reviewera a n�zev filmu.
select jmeno, nazev FROM Reviewer re, Film f, 
	(select h1.id_reviewer,h1.id_film from Hodnoceni h1  join Hodnoceni h2 on h1.id_film=h2.id_film and h1.id_reviewer=h2.id_reviewer
	where h1.hodnoceni > h2.hodnoceni and h1.datum > h2.datum) R 
where re.id_reviewer=R.id_reviewer and f.id_film=R.id_film

-- 7. Pro ka�d� film, kter� m� n�jak� hodnocen�, najd�te nejvy��� dosa�en� hodnocen�. Vypi�te n�zev filmu a hodnocen�, set�i�te podle n�zvu filmu.
-- /A/ --
select nazev, hod.hodnoceni from Film f join  (select id_film, max(hodnoceni) as hodnoceni  from Hodnoceni group by id_film) hod on f.id_film=hod.id_film order by nazev
-- /B/ --
select nazev, max(h.hodnoceni) as hodnoceni from Film f join  Hodnoceni h on f.id_film=h.id_film group by h.id_film, nazev order by nazev

-- 8. Pro ka�d� film nalezn�te n�zev filmu a rozsah hodnocen�, co� je rozd�l mezi nejvy���m a nejni���m hodnocen�m. Set�i�te nejd��ve podle rozsahu od nejvy���ho po nejni���, potom podle n�zvu filmu.
select f.nazev, MAX(h.hodnoceni)-MIN(h.hodnoceni) as rozsah 
	from Hodnoceni h join Film f on h.id_film=f.id_film 
	group by h.id_film, f.nazev 
	order by rozsah desc, f.nazev asc
-- 9. Najd�te rozd�l mezi pr�m�rn�m hodnocen�m film� uveden�ch p�ed rokem 1980 a pr�m�rn� hodnocen� film� uveden�ch od roku 1980. Ujist�te se, �e jste spo��tali pr�m�rn� hodnocen� nejd��ve pro ka�d� film a pak pr�m�r t�chto pr�m�r� p�ed rokem 1980 a po roce 1980.
with avgs (id, avghod) as (select id_film, avg(convert(float, hodnoceni))  from Hodnoceni group by id_film)
	select (select avg(avghod) from avgs join Film f on f.id_film=avgs.id where rok<1980) - (select avg(avghod) from avgs join Film f on f.id_film=avgs.id where rok>1980) as rozdil


-- 10. Najd�te jm�na v�ech reviewer�, kte�� p�isp�li t�emi a v�ce hodnocen�mi. Pokuste se napsat dotaz bez pou�it� HAVING nebo bez Count.
 SELECT jmeno FROM Reviewer R JOIN HODNOCENI H ON (R.id_reviewer = H.id_reviewer) GROUP BY jmeno HAVING COUNT(H.id_reviewer)>=3