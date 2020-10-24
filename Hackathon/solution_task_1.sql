-- 1. Odpowiednim poleceniem wyświetl informacje o tabelach
SELECT
    COUNT(BABY_NAME) AS "Number of baby names",
    SUM(FREQUENCY) AS "Number of babies"
FROM BABY_NAME_DATA;

SELECT
    COUNT(DOG_NAME) AS "Number of dog names",
    SUM(FREQUENCY) AS "Number of dogs"
FROM DOG_NAME_DATA;



-- 2. Wyświetl tabele i wstępnie przejrzyj otrzymane dane.
SELECT * FROM BABY_NAME_DATA;
SELECT * FROM DOG_NAME_DATA;



-- 3. Ile rekordów jest w każdej z tych baz?
SELECT
    COUNT(BABY_NAME) AS "Number of baby names"
FROM BABY_NAME_DATA;
-- Liczba imion dzieci: 200

SELECT
    COUNT(DOG_NAME) AS "Number of dog names"
FROM DOG_NAME_DATA;
-- Liczba imion psów: 11044



-- Ile psów nosi imię zawierające imię Max / Jess?
SELECT
	DOG_NAME,
    FREQUENCY
FROM DOG_NAME_DATA
WHERE DOG_NAME IN ("MAX", "JESS")
GROUP BY DOG_NAME
ORDER BY DOG_NAME;
-- Max: 507, Jess: 91



-- Czy te wariacje będą dla nas się liczyć?
-- Odp: Jeśli tak, należy przerobić zapytanie:
SELECT
    SUM(FREQUENCY) AS "Number of dogs named Max or similar"
FROM DOG_NAME_DATA
WHERE DOG_NAME LIKE "%MAX%";
-- Max: 638

SELECT
    SUM(FREQUENCY) AS "Number of dogs named Jess or similar"
FROM DOG_NAME_DATA
WHERE DOG_NAME LIKE "%JESS%";
-- Jess: 302



-- Ile dzieci nosi powyższe imiona i ich wariacje?
SELECT
    SUM(FREQUENCY) AS "Number of babies named Max or similar"
FROM BABY_NAME_DATA
WHERE BABY_NAME LIKE "%MAX%";
-- Max: 97

SELECT
    SUM(FREQUENCY) AS "Number of babies named Jess or similar"
FROM BABY_NAME_DATA
WHERE BABY_NAME LIKE "%JESS%";
-- Jess: 0



-- Czy te liczby da się w prosty sposób porównać? Dlaczego tak / dlaczego nie?
-- Odp: Nie, ze względu na różnicę w wielkości zbiorów (8321 dzieci vs 57592 psów (frequency)).



-- Zbadaj proporcje częstotliwości występowania przez wyliczenie udziału procentowego imienia w całym zbiorze danych.
SELECT
    @MAX_FREQUENCY := SUM(FREQUENCY) AS MAX_FREQUENCY
FROM DOG_NAME_DATA
WHERE DOG_NAME LIKE "%MAX%";

SELECT
	ROUND(@MAX_FREQUENCY) AS "Number of dogs named Max or similar",
    SUM(FREQUENCY) AS "Total number of dogs",
    ROUND(@MAX_FREQUENCY / SUM(FREQUENCY) * 100, 8) AS "Percentage of dogs named Max or similar"
FROM DOG_NAME_DATA;
-- Procent psów nazwanych Max i podobnie: 1.10779270

SELECT
    @JESS_FREQUENCY := SUM(FREQUENCY) AS JESS_FREQUENCY
FROM DOG_NAME_DATA
WHERE DOG_NAME LIKE "%JESS%";

SELECT
	ROUND(@JESS_FREQUENCY) AS "Number of dogs named Jess or similar",
    SUM(FREQUENCY) AS "Total number of dogs",
    ROUND(@JESS_FREQUENCY / SUM(FREQUENCY) * 100, 8) AS "Percentage of dogs named Jess or similar"
FROM DOG_NAME_DATA;
-- Procent psów nazwanych Jess i podobnie: 0.52437830

SELECT
    @MAX_FREQUENCY := SUM(FREQUENCY) AS MAX_FREQUENCY
FROM BABY_NAME_DATA
WHERE BABY_NAME LIKE "%MAX%";

SELECT
	ROUND(@MAX_FREQUENCY) AS "Number of babies named Max or similar",
    SUM(FREQUENCY) AS "Total number of babies",
    ROUND(@MAX_FREQUENCY / SUM(FREQUENCY) * 100, 8) AS "Percentage of babies named Max or similar"
FROM BABY_NAME_DATA;
-- Procent psów nazwanych Max i podobnie: 1.16572520

SELECT
    @JESS_FREQUENCY := SUM(FREQUENCY) AS JESS_FREQUENCY
FROM BABY_NAME_DATA
WHERE BABY_NAME LIKE "%JESS%";

SELECT
	ROUND(@JESS_FREQUENCY) AS "Number of babies named Jess or similar",
    SUM(FREQUENCY) AS "Total number of babies",
    ROUND(@JESS_FREQUENCY / SUM(FREQUENCY) * 100, 8) AS "Percentage of babies named Jess or similar"
FROM BABY_NAME_DATA;
-- Procent dzieci nazwanych Jess i podobnie: 0