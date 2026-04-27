# Zadanie 1 - Paradygmaty

## Sortowanie bąbelkowe

| Ocena | Opis | Commit |
|-------|------|--------|
| ✅ 3.0 | Procedura do generowania 50 losowych liczb od 0 do 100 | [Link do commita 1 (3.0)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/37622463ab292535c29d2da251791f1cd81c9f93) |
| ✅ 3.5 | Procedura do sortowania liczb | [Link do commita 2 (3.5)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/321aa322522ce7302a0ab4c449af70fa65666d31) |
| ✅ 4.0 | Dodanie parametrów do procedury losującej określającymi zakres losowania: od, do, ile | [Link do commita 3 (4.0)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/f41754581d1bd4552e7d64fae944a822d587c0ca) |
| ✅ 4.5 | Testy jednostkowe testujące procedury | [Link do commita 4 (4.5)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/65341ac9a2348a06abc0b4b0ceda1a96d9ec785d) |
| ✅ 5.0 | Skrypt w bashu do uruchamiania aplikacji w Pascalu via Docker | [Link do commita 5 (5.0)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/e6b7f5ff3c553c01d425b30d56e778de753e6b5c) |

---

# Zadanie 2 - Wzorce architektury

## Symfony (PHP)

Aplikacja webowa na bazie frameworka Symfony na obrazie `kprzystalski/projobj-php:latest`. Baza danych: SQLite.

| Ocena | Opis | Commit |
|-------|------|--------|
| ✅ 3.0 | Jeden model z kontrolerem z produktami, zgodnie z CRUD (JSON) | [Link do commita 1 (3.0)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/221119f9c3472f9f54d94c34932c09fc3076d790) |
| ✅ 3.5 | Skrypty do testów endpointów via curl (JSON) | [Link do commita 2 (3.5)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/03cd5c60cd855340dd6d83db6df780a8771b414e) |
| ✅ 4.0 | Dwa dodatkowe kontrolery wraz z modelami (JSON) | [Link do commita 3 (4.0)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/fb3d534b7ab6c275e3f4857e13730d2350b4dc2f) |
| ✅ 4.5 | Widoki do wszystkich kontrolerów | [Link do commita 4 (4.5)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/3c75768258ffba47fe23b64b3d1fb1e6bfb6e07d) |
| ✅ 5.0 | Panel administracyjny | [Link do commita 5 (5.0)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/a47d582120b72878df99b42c166c9f18f95f5f0e) |

----------------
Zadanie 4 Wzorce strukturalne

Echo (Go)
Należy stworzyć aplikację w Go na frameworku echo. Aplikacja ma mieć
jeden endpoint, minimum jedną funkcję proxy, która pobiera dane np. o
pogodzie, giełdzie, etc. (do wyboru) z zewnętrznego API. Zapytania do
endpointu można wysyłać w jako GET lub POST.

✅3.0 Należy stworzyć aplikację we frameworki echo w j. Go, która będzie
miała kontroler Pogody, która pozwala na pobieranie danych o pogodzie
(lub akcjach giełdowych)
3.5 Należy stworzyć model Pogoda (lub Giełda) wykorzystując gorm, a
dane załadować z listy przy uruchomieniu
4.0 Należy stworzyć klasę proxy, która pobierze dane z serwisu
zewnętrznego podczas zapytania do naszego kontrolera
4.5 Należy zapisać pobrane dane z zewnątrz do bazy danych
5.0 Należy rozszerzyć endpoint na więcej niż jedną lokalizację
(Pogoda), lub akcje (Giełda) zwracając JSONa
