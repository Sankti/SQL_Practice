SELECT
	ROUND(SALARY_BASE / 40) AS DAILY_WAGE,
    COUNT(*) AS USER_COUNT
FROM USERS
WHERE SALARY_BASE BETWEEN 400 AND 900
GROUP BY DAILY_WAGE
ORDER BY USER_COUNT DESC, DAILY_WAGE DESC;

SELECT
	POSITION,
  COUNT(*) AS USER_COUNT
FROM USERS
WHERE SALARY_ADD IS NOT NULL
GROUP BY POSITION
HAVING USER_COUNT > 1;

-- Zadania domowe:
-- (W tabelkach znajdują się przykładowe dane pokazujące efekt - ilustracja rozwiązania, nie rozwiązanie :) )

--     Korzystając z wyrażenia CASE zmień adresy zespołów tak by wyświetlać stan USA zamiast miasta,
--     Dla każdego pracownika wyświetl informację o tym, czy jego pensja jest mniejsza niż, równa lub większa niż 480 np. wzoru:

--     ________________________________
--     | name | salary_base | limit
--     ---------- ------------------ ------------------------  
--     | metei |               450 | less than 480  
--     | aimet |               480 | equal 480        
--     | maya |               500 | more than 480
--     ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
--     Oblicz średnią pensję na stanowiskach w tej firmie. Wyniki uporządkuj wg malejącej średniej pensji.
--     Wyświetl najniższą i najwyższą pensję w firmie. Wyświetl informację o różnicy dzielącej najlepiej i najgorzej zarabiających pracowników.
--     W ramach każdego zespołu dla każdego stanowiska występującego w zespole oblicz najwyższą wypłatę całkowitą.
--     Wyświetl liczbę zatrudnionych na stanowisku SENIOR
--     Znajdź sumaryczne miesięczne płace dla każdego zespołu. Nie zapomnij o płacach dodatkowych.
--     Zmodyfikuj zapytanie z zadania poprzedniego w taki sposób, aby jego wynikiem była sumaryczna miesięczna płaca w zespole, który wypłaca swoim pracownikom najwięcej pieniędzy.
--     Dla każdego pracownika, który jest szefem, wyświetl pensję najgorzej zarabiającego podwładnego. Wyniki uporządkuj wg malejącej pensji.
--     Wyświetl numery zespołów wraz z liczbą pracowników w każdym zespole. Wyniki uporządkuj wg malejącej liczby pracowników
--     Zmodyfikuj zapytanie z zadania poprzedniego, aby wyświetlić numery tylko tych zespołów, które zatrudniają więcej niż 3 pracowników.
--     Sprawdź, czy id pracowników są unikalne. Wyświetl zdublowane wartości identyfikatorów.
--      (nie wybrano żadnych wierszy)

--     Wyświetl średnie pensje wypłacane w ramach poszczególnych stanowisk i liczbę zatrudnionych na danym stanowisku. Pomiń pracowników zatrudnionych w 2020 roku.

--       YEAR  | EMPLOYEES
--     -----------  -------------------
--        2012   |                     2 
--        2013   |                     2 
--        2014   |                     3 
--        2016   |                     5 
--        2018   |                     1 

--     Zbuduj zapytanie, które wyliczy, ilu pracowników w swoim nazwisku posiada chociaż jedną literę „a” lub „A”.


--     Zbuduj zapytanie, które wyświetli średnie i maksymalne pensje na stanowiskach REGULAR i SENIOR w poszczególnych zespołach
--     (weź pod uwagę zarówno płace podstawowe jak i dodatkowe). Dokonaj zaokrąglenia pensji do wartości całkowitych.
--     Wynik zapytania posortuj wg id zespołów i nazw stanowisk.
--     Zbuduj zapytanie, które wyświetli, ilu pracowników zostało zatrudnionych w poszczególnych latach. Wynik posortuj rosnąco ze względu na rok zatrudnienia.
--     Zbuduj zapytanie, które policzy liczbę liter w nazwiskach pracowników i wyświetli liczbę nazwisk z daną liczbą liter. Wynik zapytania posortuj rosnąco wg liczby liter w nazwiskach.

--     ile liter | w ilu nazwiskach?
--     --------- ---------------------------
--             5 |                           4
--             7 |                           2
--             8 |                           1
--             9 |                           4

--     Zmień zapytanie z zadania 14 w taki sposób, aby oprócz kolumny, pokazującej ilu pracowników w swoim nazwisku posiada chociaż jedną literę „a” lub „A”, pojawiła się kolumna pokazująca liczbę pracowników z chociaż jedną literą „e” lub „E” w nazwisku.

--       z litera A |    z litera E
--     --------------  ---------------
--                   9 |               11

--     Dla każdego zespołu wyświetl jego id, sumę płac pracowników w nim zatrudnionych oraz listę pracowników w formie: nazwisko:podstawowa płaca pracownika. Dane pracowników na liście mają zostać oddzielone średnikami. Wynik posortuj wg identyfikatorów zespołów.
--     np.

--     ID_TEAM |   SUMA  |  PRACOWNICY
--     -------------- ------------- ----------------------------------------------------------
--     1               |  2140,0  |  Smith:410; Hans:1730
--     2               |  2469,0  |  Yose:960; Jerry:439; Kowalsky:480; Dart:590;
--     3               |  2008,0  |  White:250; Hapke:480; Smith1070; Zac:208
--     4               |  1350,0  |  Black:1350;