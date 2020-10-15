-- ZADANIA Z ZAJĘĆ
-- 1. Wyświetl informacje o datach zatrudnienia czlonkow zespolu 20. Wyswietl w kolejnosci wg. daty.
SELECT
	LASTNAME,
	HIRED_AT
FROM USERS
WHERE ID_TEAM = 20
ORDER BY HIRED_AT;

-- 2. Wyswietl tylko uzytkownikow zatrudniochy po 2017 roku.
SELECT
	LASTNAME,
  HIRED_AT
FROM USERS
WHERE YEAR(HIRED_AT) >= 2017;

-- 3. Policz jaki staz pracy bedzie mial kazdy pracownik 1 stycznia 2025 (sprawdz funkcje ROUND())
SELECT
	LASTNAME,
  POSITION,
	ROUND(DATEDIFF('2025-01-01', HIRED_AT)/365, 2) AS "YEARS OF SERVICE ON 2025-01-01"
FROM USERS;

-- 4. Sprawdz jaki staz pracy mial kazdy pracownik 1 stycznia 2017
SELECT
	LASTNAME,
	POSITION,
	HIRED_AT,
	TIMESTAMPDIFF(YEAR, HIRED_AT, '2017-01-01') AS "YEARS OF SERVICE ON 2017-01-01"
FROM USERS
WHERE YEAR(HIRED_AT) < 2017;

-- Wyświetl imię, nazwisko i sam rok zatrudnienia pracownika.
SELECT
	FIRSTNAME,
	LASTNAME,
    YEAR(HIRED_AT) AS "YEAR OF HIRING"
FROM USERS;

-- Wyświetl informacje o datach zatrudnienia pracowników zatrudnionych od roku 2012 do 2018, którzy dołączyli w pierwszej połowie miesiąca (tj. do 15 dnia miesiąca).
SELECT
	FIRSTNAME,
	LASTNAME,
    HIRED_AT
FROM USERS
WHERE
	YEAR(HIRED_AT) BETWEEN 2012 AND 2018
	AND DAY(HIRED_AT) >= 15;