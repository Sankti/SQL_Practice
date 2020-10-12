-- 1. Wyświetl całość informacji z relacji TEAMS.
SELECT * FROM TEAMS;

-- 2. Wyświetl całość informacji z relacji użytkownicy.
SELECT * FROM TEAMS;

-- 3. Wyświetl nazwiska i roczne dochody pracowników.
SELECT
	LASTNAME,
	SALARY_BASE * 12
FROM USERS;

-- 4. Wyświetl nazwy etatów i sumaryczne miesięczne dochody pracowników.
SELECT
	POSITION,
    SALARY_BASE + IFNULL(SALARY_ADD, 0) AS "SUMMARIZED"
FROM USERS;

-- 5. Wyświetl całość informacji o zespołach sortując wynik według nazw zespołów
SELECT * FROM TEAMS
ORDER BY NAME;

-- 6. Wyświetl listę stanowisk (bez duplikatów) na których zatrudnieni są pracownicy.
SELECT
	DISTINCT POSITION
FROM USERS;

-- 7. Wyświetl wszystkie informacje o juniorach pracujących w firmie.
SELECT * FROM USERS
WHERE POSITION = 'JUNIOR';

-- 8. Posortuj dane pracowników po dwóch kolumnach, najpierw alfabetycznie wg nazwisk i malejąco wg pensji.
SELECT * FROM USERS
ORDER BY LASTNAME ASC, SALARY_BASE DESC;

-- 9. Sprawdź jak działają metody UPPER/LOWER/REPLACE dla MySQL. Wyświetl nazwy stanowisk małymi literami w kolejności alfabetycznej.
SELECT LOWER(NAME) FROM POSITIONS
ORDER BY NAME ASC;

-- 10. Znajdź wszystkich pracowników, których bonus roczny będzie większy niż dwukrotność pensji miesięcznej
SELECT 
	LASTNAME,
	SALARY_ADD * 12 AS 'ANNUAL BONUS',
    SALARY_BASE * 2 AS 'DOUBLE SALARY'
FROM USERS
WHERE SALARY_ADD * 12 > SALARY_BASE * 2;

-- 11. Wyszukaj wszystkich pracowników, których id jest większe niż 150
SELECT * FROM USERS
WHERE ID_USER > 150;

-- ZADANIA DODATKOWE
-- 12. Sprawdź w jakich nazwiskach przedostatnia litera to litera E
SELECT * FROM USERS
WHERE LASTNAME LIKE "%E_";

-- 13 Możemy policzyć wystąpienia rekordów za pomocą polecenia COUNT().  Liczbę wszystkich stanowisk oraz stanowiska bez powtórzeń policzymy za pomocą:
SELECT COUNT(position) FROM USERS;
SELECT COUNT(DISTINCT position) FROM USERS;

-- Sprawdź w ilu nazwiskach ostatnia litera to N
SELECT COUNT(LASTNAME) FROM USERS
WHERE LASTNAME LIKE "%N";

-- 14. Znajdź pracowników, których nazwisko zawiera w środku literę r (nie na końcu, nie na początku).
SELECT * FROM USERS
WHERE LASTNAME LIKE "%R%";

-- 15. Znajdź pracowników o pensji wyższej lub równej 650 a niższej niż 1100.
SELECT * FROM USERS
WHERE SALARY_BASE BETWEEN 650 AND 1100;