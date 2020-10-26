-- 1. Wyświetl nazwiska, stanowisko i id zespołu pracowników pracujących w tym samym zespole co pracownik o nazwisku KIRCKMAN .Wynik uporządkuj wg nazwisk pracowników
SELECT
    LASTNAME,
    POSITION,
    ID_TEAM
FROM USERS
WHERE ID_TEAM IN (
    SELECT ID_TEAM
    FROM USERS
    WHERE LASTNAME = "KIRCKMAN"
)
ORDER BY LASTNAME;



-- 2. Zmodyfikuj treść poprzedniego zapytania w taki sposób, aby zamiast identyfikatora zespołu pojawiła się jego nazwa.
SELECT
	LASTNAME,
    POSITION,
    NAME
FROM USERS
NATURAL JOIN TEAMS
WHERE ID_TEAM IN (
	SELECT ID_TEAM
    FROM USERS
    WHERE LASTNAME = "KIRCKMAN"
)
ORDER BY LASTNAME;



-- 3. Wyświetl nazwisko, stanowisko i datę zatrudnienia najdłużej zatrudnionego SENIORA
SELECT
	LASTNAME,
    POSITION,
    HIRED_AT
FROM USERS
WHERE HIRED_AT IN (
	SELECT MIN(HIRED_AT)
    FROM USERS
);



-- 4. Wyświetl najkrócej pracujących pracowników każdego zespołu. Uszereguj wyniki zgodnie z kolejnością zatrudnienia.
SELECT
	*
FROM USERS
WHERE HIRED_AT IN (
	SELECT MAX(HIRED_AT)
    FROM USERS
    GROUP BY ID_TEAM
)
ORDER BY HIRED_AT;



-- 5. Wyświetl informacje o zespołach, które nie zatrudniają pracowników
-- 6. Wyświetl nazwiska tych seniorów, którzy wśród swoich podwładnych nie mają żadnych stażystów.
-- 7. Wyświetl id zespołu wypłacającego miesięcznie swoim pracownikom najwięcej pieniędzy.
-- 8. Zmodyfikuj poprzednie zapytanie w taki sposób, aby zamiast numeru zespołu wyświetlona została jego nazwa.
-- 9. Znajdź zespoły zatrudniające więcej pracowników niż zespół administracji. Wynik posortuj wg nazw zespołów.
-- 10. Znajdź stanowisko które jest najliczniej reprezentowane w zbiorze pracowników.
-- - 9* Uzupełnij wynik poprzedniego zapytania o listę nazwisk pracowników na znalezionych etatach 
-- 11. Znajdź parę: pracownik – szef, dla której różnica między płacą pracownika a płacą jego szefa jest najniższa.