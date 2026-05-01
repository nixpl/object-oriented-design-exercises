**Zadanie 1** Paradygmaty
Sortowanie bąbelkowe

Proszę napisać program w Pascalu, który zawiera dwie procedury, jedna generuje listę 50 losowych liczb od 0 do 100. Druga procedura sortuje liczbę za pomocą sortowania bąbelkowego.

✅ 3.0 Procedura do generowania 50 losowych liczb od 0 do 100 [Link do commita 1](https://github.com/nixpl/object-oriented-design-exercises/commit/4f5a56e)

✅ 3.5 Procedura do sortowania liczb [Link do commita 2](https://github.com/nixpl/object-oriented-design-exercises/commit/fe4c8ec)

✅ 4.0 Dodanie parametrów do procedury losującej określającymi zakres losowania: od, do, ile [Link do commita 3](https://github.com/nixpl/object-oriented-design-exercises/commit/ef628a4)

✅ 4.5 5 testów jednostkowych testujące procedury [Link do commita 4](https://github.com/nixpl/object-oriented-design-exercises/commit/3a36e16)

✅ 5.0 Skrypt w bashu do uruchamiania aplikacji w Pascalu via docker [Link do commita 5](https://github.com/nixpl/object-oriented-design-exercises/commit/f8ea414)

Kod: [Link do zadania 1](./1)

---

**Zadanie 2** Wzorce architektury
Symfony (PHP)

Należy stworzyć aplikację webową na bazie frameworka Symfony na obrazie `kprzystalski/projobj-php:latest`. Baza danych dowolna, sugeruję SQLite.

✅ 3.0 Należy stworzyć jeden model z kontrolerem z produktami, zgodnie z CRUD (JSON) [Link do commita 3.0](https://github.com/nixpl/object-oriented-design-exercises/commit/13e1200)

✅ 3.5 Należy stworzyć skrypty do testów endpointów via curl (JSON) [Link do commita 3.5](https://github.com/nixpl/object-oriented-design-exercises/commit/560dcb6)

✅ 4.0 Należy stworzyć dwa dodatkowe kontrolery wraz z modelami (JSON) [Link do commita 4.0](https://github.com/nixpl/object-oriented-design-exercises/commit/b6f8c49)

✅ 4.5 Należy stworzyć widoki do wszystkich kontrolerów [Link do commita 4.5](https://github.com/nixpl/object-oriented-design-exercises/commit/d858c8c)

✅ 5.0 Stworzenie panelu administracyjnego [Link do commita 5.0](https://github.com/nixpl/object-oriented-design-exercises/commit/9952bb3)

Kod: [Link do zadania 2](./2)

---

**Zadanie 3** Wzorce kreacyjne
Spring Boot (Kotlin)

Proszę stworzyć prosty serwis do autoryzacji, który zasymuluje autoryzację użytkownika za pomocą przesłanej nazwy użytkownika oraz hasła. Aplikacja zawiera jeden kontroler, jest napisana w Kotlinie i oparta na Spring Boot. Serwis do autoryzacji jest singletonem.

✅ 3.0 Należy stworzyć jeden kontroler wraz z danymi wyświetlanymi z listy na endpoint'cie w formacie JSON - Kotlin + Spring Boot [Link do commita 3.0](https://github.com/nixpl/object-oriented-design-exercises/commit/ae1fffa)

✅ 3.5 Należy stworzyć klasę do autoryzacji (mock) jako Singleton w formie eager [Link do commita 3.5](https://github.com/nixpl/object-oriented-design-exercises/commit/3d29d45)

✅ 4.0 Należy obsłużyć dane autoryzacji przekazywane przez użytkownika [Link do commita 4.0](https://github.com/nixpl/object-oriented-design-exercises/commit/23266a8)

✅ 4.5 Należy wstrzyknąć singleton do głównej klasy via @Autowired lub kontruktor (constructor injection) [Link do commita 4.5](https://github.com/nixpl/object-oriented-design-exercises/commit/210c3df)

✅ 5.0 Obok wersji Eager do wyboru powinna być wersja Singletona w wersji lazy [Link do commita 5.0](https://github.com/nixpl/object-oriented-design-exercises/commit/5e6abef)

Kod: [Link do zadania 3](./3)

---

**Zadanie 4** Wzorce strukturalne
Echo (Go)

Należy stworzyć aplikację w Go na frameworku echo. Aplikacja ma mieć jeden endpoint, minimum jedną funkcję proxy, która pobiera dane np. o pogodzie z zewnętrznego API.

✅ 3.0 Należy stworzyć aplikację we frameworku echo w j. Go z kontrolerem Pogodyy, która pozwala na pobieranie danych o pogodzie [Link do commita 3.0](https://github.com/nixpl/object-oriented-design-exercises/commit/628198d)

✅ 3.5 Należy stworzyć model Pogoda wykorzystując gorm, a dane załadować z listy przy uruchomieniu [Link do commita 3.5](https://github.com/nixpl/object-oriented-design-exercises/commit/c78d1bf)

✅ 4.0 Należy stworzyć klasę proxy, która pobierze dane z serwisu zewnętrznego podczas zapytania do naszego kontrolera [Link do commita 4.0](https://github.com/nixpl/object-oriented-design-exercises/commit/777db11)

✅ 4.5 Należy zapisać pobrane dane z zewnątrz do bazy danych [Link do commita 4.5](https://github.com/nixpl/object-oriented-design-exercises/commit/183fbe8)

✅ 5.0 Należy rozszerzyć endpoint na więcej niż jedną lokalizację zwracając JSONa [Link do commita 5.0](https://github.com/nixpl/object-oriented-design-exercises/commit/55e68e0)

Kod: [Link do zadania 4](./4)

---

**Zadanie 5** Wzorce behawioralne
React (JavaScript/Typescript)

✅ 3.0 W ramach projektu należy stworzyć komponenty Produkty oraz Płatności; komponent Produkty powinien pobierać listę produktów z aplikacji serwerowej, natomiast komponent Płatności powinien wysyłać dane płatności do aplikacji serwerowej. [Link do commita 3.0](https://github.com/nixpl/object-oriented-design-exercises/commit/63101cf)

✅ 3.5 Należy dodać komponent Koszyk wraz z osobnym widokiem; aplikacja powinna umożliwiać przechodzenie pomiędzy widokami przy użyciu routingu. [Link do commita 3.5](https://github.com/nixpl/object-oriented-design-exercises/commit/286e693)

✅ 4.0 Dane pomiędzy komponentami, takimi jak Produkty, Koszyk i Płatności, powinny być przekazywane z wykorzystaniem React hooks, np. useState, useEffect lub useContext. [Link do commita 4.0](https://github.com/nixpl/object-oriented-design-exercises/commit/49468bd)

✅ 4.5 Należy przygotować konfigurację umożliwiającą uruchomienie aplikacji klienckiej oraz serwerowej w kontenerach Docker za pomocą docker-compose. [Link do commita 4.5](https://github.com/nixpl/object-oriented-design-exercises/commit/0eef36a)

✅ 5.0 Należy wykorzystać bibliotekę axios do komunikacji z serwerem oraz skonfigurować obsługę CORS, aby frontend mógł poprawnie komunikować się z backendem. [Link do commita 5.0](https://github.com/nixpl/object-oriented-design-exercises/commit/83aa343)

Kod: [Link do zadania 5](./5)
