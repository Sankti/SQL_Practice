-- 1. Dla każdego pracownika wygeneruj kod składający się z dwóch pierwszych liter jego etatu i jego numeru id. Wyświetl imię i nazwisko oraz kod pracownika.
SELECT
	FIRSTNAME,
	LASTNAME,
	CONCAT(
		SUBSTR(POSITION, 1, 2),
		ID_USER
	) AS USER_CODE
FROM USERS;

-- 2. Z nazwisk pracowników pozbądź się liter K i L - zamień je na X.
SELECT REPLACE(REPLACE(LASTNAME, 'K', 'X'), 'L', 'X') AS NEW_LASTNAME
FROM USERS;

-- 3. Wyświetl tylko tych pracowników, którzy mają literę L w drugiej połowie nazwiska.
SELECT *
FROM USERS
WHERE INSTR(LASTNAME, 'L') BETWEEN LENGTH(LASTNAME) / 2 AND LENGTH(LASTNAME);

-- 4. Nadaj podwyżki pracownikom - powiększ ich pensje podstawową o 15% i zaokrąglij do liczb całkowitych. Wyświetl: imię, nazwisko, stara podstawa, nowa podstawa wynagrodzenia.
SELECT
	FIRSTNAME,
	LASTNAME,
	SALARY_BASE,
	ROUND(SALARY_BASE * 1.15) AS SALARY_NEW
FROM USERS;

-- 5. Policz jaki staż będzie miał każdy pracownik 1 stycznia 2021 wyświetl w dniach oraz w latach.
SELECT
	LASTNAME,
	HIRED_AT,
	TIMESTAMPDIFF(DAY, HIRED_AT, '2021-01-01') AS "YEARS OF SERVICE ON 2021-01-01 IN DAYS",
	TIMESTAMPDIFF(YEAR, HIRED_AT, '2021-01-01') AS "YEARS OF SERVICE ON 2021-01-01 IN YEARS"
FROM USERS;

-- 6. Wyświetl nazwisko oraz datę zatrudnienia pracownika zespołu 20 w zmienionym formacie: zamiast rok - miesiąc - dzień wyświetl: miesiąc słownie | dzień / rok
SELECT
	LASTNAME,
	CONCAT(
		MONTHNAME(HIRED_AT),
		" | ",
		DAY(HIRED_AT),
		" / ",
		YEAR(HIRED_AT)
	) AS "DATE OF HIRING"
FROM USERS
WHERE ID_TEAM = 20;

-- 7. Sprawdź, jaki mamy dziś dzień tygodnia. Wyświetl nazwę dnia.
SELECT DAYNAME(SYSDATE()) AS "TODAY IS";

-- 8. Korzystając z wyrażenia CASE zmień adresy zespołów tak by wyświetlać stan zamiast miasta,
SELECT
	NAME,
	ADDRESS,
	CASE
		WHEN ADDRESS = "NEW YORK CITY" THEN "NEW YORK"
		WHEN ADDRESS = "HOUSTON" THEN "TEXAS"
		WHEN
			ADDRESS = "SAN DIEGO"
			OR
			ADDRESS = "LOS ANGELES" THEN "CALIFORNIA"
	END AS STATE
FROM TEAMS;

-- 9. Dla każdego pracownika wyświetl informację o tym, czy jego pensja jest mniejsza niż, równa lub większa niż 480
-- name | salary_base | limit
-- smith |               450 | less than 480
SELECT
	LASTNAME AS NAME,
	SALARY_BASE,
	CASE
		WHEN SALARY_BASE > 480 THEN "MORE THAN 480"
		WHEN SALARY_BASE = 480 THEN "EXACTLY 480"
		WHEN SALARY_BASE < 480 THEN "LESS THAN 480"
	END AS "LIMIT"
FROM USERS;

-- * Każdy pracownik odłożył 20% swoich miesięcznych zarobków na 10-letnią lokatę oprocentowaną 10% w skali roku i kapitalizowaną co roku. Wyświetl informację o tym, jaki zysk będzie miał każdy pracownik po zamknięciu lokaty.
SELECT
	LASTNAME,
	SALARY_BASE * 0.2 AS DEPOSIT,
	((((((((((SALARY_BASE * 0.2) * 1.1) * 1.1) * 1.1) * 1.1) * 1.1) * 1.1) * 1.1) * 1.1) * 1.1) - SALARY_BASE * 0.2 AS "INTEREST AFTER 10 YEARS"
FROM USERS;



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

    -- Wyświetl nazwiska i wypłaty pracowników powiększone o 7% i zaokrąglone do liczb całkowitych jako SALARY_BUMP.
SELECT
	LASTNAME,
	ROUND(SALARY_BASE * 1.07, 0) AS SALARY_BUMP
FROM USERS;

-- Pozbądź się liter Y i Z z imion pracowników. Zamień je na znak #.
SELECT
	REPLACE(REPLACE(LASTNAME, 'Y', '#'), 'Z', '#') AS NEW_LASTNAME
FROM USERS;

-- Wyświetl imię, nazwisko i stanowisko pracowników, którzy posiadają literę E w pierwszej połowie swojego stanowiska oraz pracują w firmie od 2015.
SELECT lastname, firstname, position
FROM USERS
WHERE INSTR(position, 'E') BETWEEN 1 AND LENGTH(position) / 2
AND YEAR(HIRED_AT) = 2015;

-- Sprawdź, jaki mamy dziś dzień tygodnia. Wynik powinien wyglądać następująco:
-- TODAY IS
-- ------------
-- Thursday
SELECT DAYNAME(SYSDATE()) AS "TODAY IS";