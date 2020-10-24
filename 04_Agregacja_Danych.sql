-- Zadania domowe:
-- (W tabelkach znajdują się przykładowe dane pokazujące efekt - ilustracja rozwiązania, nie rozwiązanie :) )

--     Korzystając z wyrażenia CASE zmień adresy zespołów tak by wyświetlać stan USA zamiast miasta,
SELECT
	NAME,
	CASE
		WHEN ADDRESS = "NEW YORK CITY" THEN "NEW YORK"
		WHEN ADDRESS = "HOUSTON" THEN "TEXAS"
		WHEN
			ADDRESS = "SAN DIEGO"
			OR
			ADDRESS = "LOS ANGELES" THEN "CALIFORNIA"
	END AS STATE
FROM TEAMS;



--     Dla każdego pracownika wyświetl informację o tym, czy jego pensja jest mniejsza niż, równa lub większa niż 480 np. wzoru:
--     ________________________________
--     | name | salary_base | limit
--     ---------- ------------------ ------------------------  
--     | metei |               450 | less than 480  
--     | aimet |               480 | equal 480        
--     | maya |               500 | more than 480
--     ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
SELECT
  LASTNAME AS NAME,
  SALARY_BASE,
  CASE
    WHEN SALARY_BASE > 480 THEN "MORE THAN 480"
    WHEN SALARY_BASE = 480 THEN "EQUAL 480"
    WHEN SALARY_BASE < 480 THEN "LESS THAN 480"
  END AS "LIMIT"
FROM USERS;



--     Oblicz średnią pensję na stanowiskach w tej firmie. Wyniki uporządkuj wg malejącej średniej pensji.
SELECT
  POSITION,
  AVG(SALARY_BASE) AS AVERAGE_SALARY
FROM USERS
GROUP BY POSITION
ORDER BY AVERAGE_SALARY DESC;




--     Wyświetl najniższą i najwyższą pensję w firmie. Wyświetl informację o różnicy dzielącej najlepiej i najgorzej zarabiających pracowników.
SELECT
  MAX(SALARY_BASE) AS MAXIMUM_SALARY,
  MIN(SALARY_BASE) AS MINIMUM_SALARY,
  MAX(SALARY_BASE) - MIN(SALARY_BASE) AS "Difference between max and min salary"
FROM USERS;



--     W ramach każdego zespołu dla każdego stanowiska występującego w zespole oblicz najwyższą wypłatę całkowitą.
SELECT
  ID_TEAM,
  POSITION,
  MAX(SALARY_BASE * 12 + IFNULL(SALARY_ADD, 0) * 12) AS "Maximum yearly wage"
FROM USERS
GROUP BY ID_TEAM, POSITION
ORDER BY ID_TEAM;



--     Wyświetl liczbę zatrudnionych na stanowisku SENIOR
SELECT COUNT(*)
FROM USERS
WHERE POSITION = "SENIOR";



--     Znajdź sumaryczne miesięczne płace dla każdego zespołu. Nie zapomnij o płacach dodatkowych.
SELECT
  ID_TEAM,
  SUM(SALARY_BASE + IFNULL(SALARY_ADD, 0))
FROM USERS
GROUP BY ID_TEAM;



--     Zmodyfikuj zapytanie z zadania poprzedniego w taki sposób, aby jego wynikiem była sumaryczna miesięczna płaca w zespole, który wypłaca swoim pracownikom najwięcej pieniędzy.
SELECT
  ID_TEAM,
  SUM(SALARY_BASE + IFNULL(SALARY_ADD, 0)) AS MONTHLY_HR
FROM USERS
GROUP BY ID_TEAM
ORDER BY MONTHLY_HR DESC
LIMIT 1;



--     Dla każdego pracownika, który jest szefem, wyświetl pensję najgorzej zarabiającego podwładnego. Wyniki uporządkuj wg malejącej pensji.
SELECT
  B.ID_BOSS AS BOSS,
  MIN(E.SALARY_BASE) AS MINIMAL_SALARY
FROM USERS B
INNER JOIN USERS E
ON B.ID_USER = E.ID_BOSS
WHERE B.ID_BOSS IS NOT NULL
GROUP BY BOSS
ORDER BY E.SALARY_BASE DESC;



--     Wyświetl numery zespołów wraz z liczbą pracowników w każdym zespole. Wyniki uporządkuj wg malejącej liczby pracowników
SELECT
  ID_TEAM,
  COUNT(*)
FROM USERS
GROUP BY ID_TEAM
ORDER BY COUNT(*) DESC;



--     Zmodyfikuj zapytanie z zadania poprzedniego, aby wyświetlić numery tylko tych zespołów, które zatrudniają więcej niż 3 pracowników.
SELECT
  ID_TEAM,
  COUNT(*) AS EMPLOYEES
FROM USERS
GROUP BY ID_TEAM
HAVING COUNT(*) > 3
ORDER BY EMPLOYEES DESC;



--     Sprawdź, czy id pracowników są unikalne. Wyświetl zdublowane wartości identyfikatorów.
--      (nie wybrano żadnych wierszy)
SELECT
  ID_USER
FROM USERS
GROUP BY ID_USER
HAVING COUNT(*) > 1;



--     Wyświetl średnie pensje wypłacane w ramach poszczególnych stanowisk i liczbę zatrudnionych na danym stanowisku. Pomiń pracowników zatrudnionych w 2020 roku.
--       YEAR  | EMPLOYEES
--     -----------  -------------------
--        2012   |                     2 
--        2013   |                     2 
--        2014   |                     3 
--        2016   |                     5 
--        2018   |                     1 
SELECT
  POSITION,
  AVG(SALARY_BASE) AS AVERAGE_SALARY
FROM USERS
WHERE YEAR(HIRED_AT) != 2020
GROUP BY POSITION
ORDER BY AVERAGE_SALARY DESC;



--     Zbuduj zapytanie, które wyliczy, ilu pracowników w swoim nazwisku posiada chociaż jedną literę „a” lub „A”.
SELECT
  COUNT(*)
FROM USERS
WHERE LASTNAME LIKE "%A%"
  OR LASTNAME LIKE "%a%";



--     Zbuduj zapytanie, które wyświetli średnie i maksymalne pensje na stanowiskach REGULAR i SENIOR w poszczególnych zespołach
--     (weź pod uwagę zarówno płace podstawowe jak i dodatkowe). Dokonaj zaokrąglenia pensji do wartości całkowitych.
--     Wynik zapytania posortuj wg id zespołów i nazw stanowisk.
SELECT
  U.ID_TEAM,
  U.POSITION,
    ROUND(AVG(U.SALARY_BASE + IFNULL(U.SALARY_ADD, 0))) AS SALARY_AVERAGE,
    P.SALARY_MAX
FROM USERS U
INNER JOIN POSITIONS P
ON U.POSITION = P.NAME
WHERE U.POSITION IN ("REGULAR", "SENIOR")
GROUP BY U.ID_TEAM, U.POSITION
ORDER BY U.ID_TEAM, U.POSITION;



--     Zbuduj zapytanie, które wyświetli, ilu pracowników zostało zatrudnionych w poszczególnych latach. Wynik posortuj rosnąco ze względu na rok zatrudnienia.
SELECT
  YEAR(HIRED_AT) AS YEAR_OF_HIRING,
  COUNT(*) AS NUMBER_OF_EMPLOYEES
FROM USERS
GROUP BY YEAR_OF_HIRING
ORDER BY YEAR_OF_HIRING;



--     Zbuduj zapytanie, które policzy liczbę liter w nazwiskach pracowników i wyświetli liczbę nazwisk z daną liczbą liter. Wynik zapytania posortuj rosnąco wg liczby liter w nazwiskach.
--     ile liter | w ilu nazwiskach?
--     --------- ---------------------------
--             5 |                           4
--             7 |                           2
--             8 |                           1
--             9 |                           4
SELECT
  LENGTH(LASTNAME) AS LENGTH_OF_LASTNAME,
    COUNT(*)
FROM USERS
GROUP BY LENGTH_OF_LASTNAME
ORDER BY LENGTH_OF_LASTNAME;



--     Zmień zapytanie z zadania 14 w taki sposób, aby oprócz kolumny, pokazującej ilu pracowników w swoim nazwisku posiada chociaż jedną literę „a” lub „A”, pojawiła się kolumna pokazująca liczbę pracowników z chociaż jedną literą „e” lub „E” w nazwisku.
--       z litera A |    z litera E
--     --------------  ---------------
--                   9 |               11
SELECT
  SUM(
    IF(LASTNAME LIKE "%A%"
    OR LASTNAME LIKE "%a%",
    1, 0)
  )AS "Z literą A",
  SUM(
    IF(LASTNAME LIKE "%E%"
    OR LASTNAME LIKE "%e%",
    1, 0)
  )AS "Z literą E"
FROM USERS;



--     Dla każdego zespołu wyświetl jego id, sumę płac pracowników w nim zatrudnionych oraz listę pracowników w formie: nazwisko:podstawowa płaca pracownika. Dane pracowników na liście mają zostać oddzielone średnikami. Wynik posortuj wg identyfikatorów zespołów.
--     np.
--     ID_TEAM |   SUMA  |  PRACOWNICY
--     -------------- ------------- ----------------------------------------------------------
--     1               |  2140,0  |  Smith:410; Hans:1730
--     2               |  2469,0  |  Yose:960; Jerry:439; Kowalsky:480; Dart:590;
--     3               |  2008,0  |  White:250; Hapke:480; Smith1070; Zac:208
--     4               |  1350,0  |  Black:1350;
SELECT
  ID_TEAM,
  SUM(SALARY_BASE + IFNULL(SALARY_ADD, 0)) AS TOTAL_SALARIES,
  GROUP_CONCAT(
    CONCAT_WS(":", LASTNAME, SALARY_BASE)
    SEPARATOR "; "
  ) AS EMPLOYEES
FROM USERS
GROUP BY ID_TEAM;