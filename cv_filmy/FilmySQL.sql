-- 1. Najdìte názvy filmù, které režíroval Steven Spielberg.
SELECT nazev from Film  where reziser='Steven Spielberg'
-- 2. Najdìte všechny roky filmù, které mají hodnocení 4 nebo 5 a seøaïte je vzestupnì.
select distinct rok from Film join Hodnoceni on Film.id_film=Hodnoceni.id_film where hodnoceni=4 or hodnoceni=5 order by rok
-- 3. Najdìte názvy všech filmù, které nemají hodnocení.
select nazev from Film where id_film not in(select id_film from Hodnoceni)

-- 4. Nìkteøí hodnotitelé neposkytli datum svého hodnocení. Najdìte jména takových hodnotitelù.
select distinct jmeno from Hodnoceni  h join Reviewer r on h.id_reviewer=r.id_reviewer 
-- 5. Napište dotaz, který vrátí data o hodnocení v èitelnìjším formátu: jméno hodnotitele, název filmu, hodnocení a datum hodnocení. Setøiïte data podle jména hodnotitele, názvu filmu a nakonec podle hodnocení.
select jmeno, nazev, hodnoceni, datum from Hodnoceni h left outer join Film f on h.id_film=f.id_film left outer join Reviewer r on r.id_reviewer=h.id_reviewer order by jmeno, nazev, hodnoceni
-- 6. Pro všechny pøípady, kdy urèitý reviewer hodnotil stejný film dvakrát a dal mu podruhé vyšší hodnocení, vrate jméno reviewera a název filmu.
select jmeno, nazev FROM Reviewer re, Film f, 
	(select h1.id_reviewer,h1.id_film from Hodnoceni h1  join Hodnoceni h2 on h1.id_film=h2.id_film and h1.id_reviewer=h2.id_reviewer
	where h1.hodnoceni > h2.hodnoceni and h1.datum > h2.datum) R 
where re.id_reviewer=R.id_reviewer and f.id_film=R.id_film

-- 7. Pro každý film, který má nìjaké hodnocení, najdìte nejvyšší dosažené hodnocení. Vypište název filmu a hodnocení, setøiïte podle názvu filmu.
-- /A/ --
select nazev, hod.hodnoceni from Film f join  (select id_film, max(hodnoceni) as hodnoceni  from Hodnoceni group by id_film) hod on f.id_film=hod.id_film order by nazev
-- /B/ --
select nazev, max(h.hodnoceni) as hodnoceni from Film f join  Hodnoceni h on f.id_film=h.id_film group by h.id_film, nazev order by nazev

-- 8. Pro každý film naleznìte název filmu a rozsah hodnocení, což je rozdíl mezi nejvyšším a nejnižším hodnocením. Setøiïte nejdøíve podle rozsahu od nejvyššího po nejnižší, potom podle názvu filmu.
select f.nazev, MAX(h.hodnoceni)-MIN(h.hodnoceni) as rozsah 
	from Hodnoceni h join Film f on h.id_film=f.id_film 
	group by h.id_film, f.nazev 
	order by rozsah desc, f.nazev asc
-- 9. Najdìte rozdíl mezi prùmìrným hodnocením filmù uvedených pøed rokem 1980 a prùmìrné hodnocení filmù uvedených od roku 1980. Ujistìte se, že jste spoèítali prùmìrné hodnocení nejdøíve pro každý film a pak prùmìr tìchto prùmìrù pøed rokem 1980 a po roce 1980.
with avgs (id, avghod) as (select id_film, avg(convert(float, hodnoceni))  from Hodnoceni group by id_film)
	select (select avg(avghod) from avgs join Film f on f.id_film=avgs.id where rok<1980) - (select avg(avghod) from avgs join Film f on f.id_film=avgs.id where rok>1980) as rozdil


-- 10. Najdìte jména všech reviewerù, kteøí pøispìli tøemi a více hodnoceními. Pokuste se napsat dotaz bez použití HAVING nebo bez Count.
 SELECT jmeno FROM Reviewer R JOIN HODNOCENI H ON (R.id_reviewer = H.id_reviewer) GROUP BY jmeno HAVING COUNT(H.id_reviewer)>=3