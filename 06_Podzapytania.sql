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
    SELECT MAX(HIRED_AT), ID_TEAM
    FROM USERS
    GROUP BY ID_TEAM
)
ORDER BY HIRED_AT;



-- 5. Wyświetl informacje o zespołach, które nie zatrudniają pracowników
SELECT *
FROM TEAMS
WHERE ID_TEAM IN (
    SELECT
        T.ID_TEAM
    FROM USERS U
    RIGHT JOIN TEAMS T
    ON U.ID_TEAM = T.ID_TEAM
    WHERE LASTNAME IS NULL
);



-- 6. Wyświetl nazwiska tych seniorów, którzy wśród swoich podwładnych nie mają żadnych stażystów.
SELECT LASTNAME
FROM USERS
WHERE POSITION = "SENIOR"
    AND ID_TEAM NOT IN (
        SELECT ID_TEAM
        FROM USERS
        WHERE POSITION = "INTERN"
    );



-- 7. Wyświetl id zespołu wypłacającego miesięcznie swoim pracownikom najwięcej pieniędzy.
SELECT
    ID_TEAM,
    SUM(SALARY_BASE + SALARY_ADD) AS HR_SPENDING
FROM USERS
GROUP BY ID_TEAM
ORDER BY HR_SPENDING DESC
LIMIT 1;



-- 8. Zmodyfikuj poprzednie zapytanie w taki sposób, aby zamiast numeru zespołu wyświetlona została jego nazwa.
SELECT
    NAME,
    SUM(SALARY_BASE + SALARY_ADD) AS HR_SPENDING
FROM USERS U
INNER JOIN TEAMS T
    ON T.ID_TEAM = U.ID_TEAM
GROUP BY U.ID_TEAM
ORDER BY HR_SPENDING DESC
LIMIT 1;



-- 9. Znajdź zespoły zatrudniające więcej pracowników niż zespół administracji. Wynik posortuj wg nazw zespołów.
SELECT
    U.ID_TEAM,
    NAME,
    COUNT(*) AS EMPLOYEE_COUNT
FROM USERS U
INNER JOIN TEAMS T
    ON U.ID_TEAM = T.ID_TEAM
GROUP BY U.ID_TEAM
HAVING EMPLOYEE_COUNT > (
    SELECT COUNT(*)
    FROM USERS U
    WHERE ID_TEAM = 10
)
ORDER BY NAME;



-- 10. Znajdź stanowisko które jest najliczniej reprezentowane w zbiorze pracowników.
SELECT
    POSITION
FROM USERS
GROUP BY POSITION
ORDER BY COUNT(*) DESC
LIMIT 1;



-- - 9* Uzupełnij wynik poprzedniego zapytania o listę nazwisk pracowników na znalezionych etatach 
SELECT
    POSITION,
    GROUP_CONCAT(
        LASTNAME
        SEPARATOR ", "
    ) AS EMPLOYEES
FROM USERS
GROUP BY POSITION
ORDER BY COUNT(*) DESC
LIMIT 1;



-- 11. Znajdź parę: pracownik – szef, dla której różnica między płacą pracownika a płacą jego szefa jest najniższa.
SELECT
    BOSS.LASTNAME AS BOSS,
    EMPLOYEE.LASTNAME AS EMPLOYEE,
    MIN(
        ABS(BOSS.SALARY_BASE - EMPLOYEE.SALARY_BASE)
    ) AS PAY_GAP
FROM USERS BOSS
INNER JOIN USERS EMPLOYEE
WHERE BOSS.ID_USER = EMPLOYEE.ID_BOSS;