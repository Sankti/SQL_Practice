-- 1. Wybierz dane o pracownikach zespołów 30 i 40 w kolejności malejących zarobków.

SELECT *
FROM COMPANY_DB.USERS
WHERE ID_TEAM = 30 OR ID_TEAM = 40
ORDER BY SALARY_BASE DESC;

-- 2. Wybierz dane o pracownikach których płace podstawowe mieszczą się w przedziale 300 do 800

SELECT * FROM COMPANY_DB.USERS
WHERE SALARY_BASE BETWEEN 300 AND 800;

-- 3. Wyświetl dane (nazwisko, id szefa i podstawową wypłatę) o tych pracownikach, którzy zarabiają powyżej 1000 i posiadają szefa

SELECT
    LASTNAME,
    ID_BOSS,
    SALARY_BASE
FROM COMPANY_DB.USERS
WHERE
    SALARY_BASE > 1000
    AND ID_BOSS IS NOT NULL;

-- 4. Wyświetl nazwiska i id zespołów użytkowników zatrudnionych w zespole nr 20, których nazwisko zaczyna się na "K" lub kończy na "ES" lub "NS".

SELECT
    LASTNAME,
    ID_TEAM
FROM COMPANY_DB.USERS
WHERE ID_TEAM = 20
    AND (LASTNAME LIKE "K%"
    OR LASTNAME LIKE "%ES" OR LASTNAME LIKE "%NS");

-- 5. Wyświetl nazwisko, stanowisko i stawkę godz. tych pracowników, którzy nie są ani regularami, ani juniorami ani stażystami i którzy nie zarabiają w przedziale od 400 do 800. Wyniki uszereguj według stawek godzinowych pracowników (przyjmij 20-dniowy miesiąc pracy i 8- godzinny dzień pracy).
--Oczekiwany wynik:
--LASTNAME	POSITION	HOURLY
--MEVANS	SENIOR	5.187500
--BROWN	SENIOR	6.000000
--SMOOTH	SENIOR	6.687500
--WILLIAMS	SENIOR	8.437500
--THOMAS	LEADER	10.812500

SELECT
    LASTNAME,
    POSITION,
    SALARY_BASE * 12 / (12 * 20 * 8) AS "HOURLY RATE"
FROM COMPANY_DB.USERS
WHERE
    POSITION NOT IN ("REGULAR", "JUNIOR", "INTERN")
    AND SALARY_BASE NOT BETWEEN 400 AND 800
ORDER BY SALARY_BASE * 12 / (20 * 8) ASC;

-- 6. Wyświetl poniższe informacje o użytkownikach, dla których suma płacy podstawowej i bonusu jest wyższa niż 1000. Wyniki uporządkuj według nazw stanowisk odwrotnie alfabetycznie. Jeżeli dwóch pracowników ma to samo stanowisko, to posortuj ich według nazwisk.
--Oczekiwany wynik:
--LASTNAME	POSITION	salary_base	salary_add
--SMOOTH	SENIOR	1070.00	null
--WILLIAMS	SENIOR	1350.00	210.00
--THOMAS	LEADER	1730.00	420.50

SELECT
    LASTNAME,
    POSITION,
    SALARY_BASE,
    SALARY_ADD
FROM COMPANY_DB.USERS
WHERE SALARY_BASE + IFNULL(SALARY_ADD, 0) > 1000
ORDER BY POSITION DESC, LASTNAME ASC;

-- 7. Wyświetl poniższe informacje o seniorach, wyniki uporządkuj według malejących płac:
--SENIORS
--WILLIAMS WORKS FROM 2003-05-01 AND EARNS 1560.00
--SMOOTH WORKS FROM 2007-09-01 AND EARNS 1070.00
--BROWN WORKS FROM 2008-07-01 AND EARNS 960.00
--MEVANS WORKS FROM 2005-09-15 AND EARNS 935.00

SELECT
    CONCAT(
        LASTNAME,
        " WORKS FROM ",
        HIRED_AT,
        " AND EARNS ",
        SALARY_BASE + IFNULL(SALARY_ADD, 0))
    AS "SENIORS"
FROM COMPANY_DB.USERS
WHERE POSITION = "SENIOR"
ORDER BY SALARY_BASE DESC;



-- ZADANIA Z ZAJĘĆ
--     Zmodyfikuj to zapytanie tak by znaleźć pracowników, których nazwisko zawiera dwie litery L w środku obok siebie np. Belly, Geller, etc.
SELECT * FROM USERS WHERE LASTNAME LIKE "%LL%";

--     Znajdź pracowników o imieniu JAMES lub o nazwisku EVANS
SELECT * FROM USERS WHERE FIRSTNAME = "JAMES" OR LASTNAME = "EVANS";

--     Znajdź pracowników, których pensja jest wyższa niż 650 i imię to Barbara lub nazwisko zawiera literę R
SELECT * FROM USERS WHERE SALARY_BASE > 650 AND (FIRSTNAME = "BARBARA" OR LASTNAME LIKE "%R%");

--     Sprawdź ile id szefów pojawia się w tabeli pracowników. Wyświetl tylko unikalne wartości. 
SELECT DISTINCT ID_BOSS FROM USERS
WHERE ID_BOSS IS NOT NULL;
--         Policz ile takich wartości się pojawia
--         (sprawdź funkcję COUNT() )
SELECT COUNT(DISTINCT ID_BOSS) FROM USERS
WHERE ID_BOSS IS NOT NULL;