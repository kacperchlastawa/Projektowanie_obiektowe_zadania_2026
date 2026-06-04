# Zadanie 1 - Paradygmaty

## Sortowanie bąbelkowe

| Ocena | Opis | Commit |
|-------|------|--------|
| ✅ 3.0 | Procedura do generowania 50 losowych liczb od 0 do 100 | [Link do commita 1 (3.0)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/37622463ab292535c29d2da251791f1cd81c9f93) |
| ✅ 3.5 | Procedura do sortowania liczb | [Link do commita 2 (3.5)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/321aa322522ce7302a0ab4c449af70fa65666d31) |
| ✅ 4.0 | Dodanie parametrów do procedury losującej określającymi zakres losowania: od, do, ile | [Link do commita 3 (4.0)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/f41754581d1bd4552e7d64fae944a822d587c0ca) |
| ✅ 4.5 | Testy jednostkowe testujące procedury | [Link do commita 4 (4.5)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/65341ac9a2348a06abc0b4b0ceda1a96d9ec785d) |
| ✅ 5.0 | Skrypt w bashu do uruchamiania aplikacji w Pascalu via Docker | [Link do commita 5 (5.0)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/e6b7f5ff3c553c01d425b30d56e778de753e6b5c) |

film : 

https://github.com/user-attachments/assets/7cfcfd70-dfb0-4037-b672-f26dbb6dc124


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

film: 

https://github.com/user-attachments/assets/1a068998-3000-45df-a9fd-79cb8d69944e


----------------
# Zadanie 3 - Wzorce kreacyjne

## Spring Boot (Kotlin)

Proszę stworzyć prosty serwis do autoryzacji, który zasymuluje autoryzację użytkownika za pomocą przesłanej nazwy użytkownika oraz hasła. Serwis powinien zostać wstrzyknięty do kontrolera (4.5). Aplikacja ma oczywiście zawierać jeden kontroler i powinna zostać napisana w języku Kotlin. Oparta powinna zostać na frameworku Spring Boot. Serwis do autoryzacji powinien być singletonem.

| Ocena | Opis |
|-------|------|
| ✅ 3.0 | Stworzenie jednego kontrolera wraz z danymi wyświetlanymi z listy na endpoint'cie w formacie JSON |
| ✅ 3.5 | Stworzenie klasy do autoryzacji (mock) jako Singleton w formie eager |
| ✅ 4.0 | Obsługa danych autoryzacji przekazywanych przez użytkownika |
| ✅ 4.5 | Wstrzyknięcie singletona do głównej klasy via constructor injection |

Wywołania:

```powershell
PS C:\Users\kchl\Desktop\STUDIA\2 stopień\2 semestr\Projektowanie_obiektowe\Projektowanie_obiektowe_zadania_2026>       
Invoke-RestMethod -Uri "http://localhost:8080/api/users" -Method GET
>>

id username        
-- --------        
 1 admin_test      
 2 user_jankowalski
 3 guest_123       


PS C:\Users\kchl\Desktop\STUDIA\2 stopień\2 semestr\Projektowanie_obiektowe\Projektowanie_obiektowe_zadania_2026> Invoke-RestMethod -Uri "http://localhost:8080/api/users/auth" -Method POST -Headers @{"Content-Type"="application/json"} -Body '{"username":"admin", "password":"secret123"}'
>>
Autoryzacja przebiegła pomyślnie!
PS C:\Users\kchl\Desktop\STUDIA\2 stopień\2 semestr\Projektowanie_obiektowe\Projektowanie_obiektowe_zadania_2026> Invoke-RestMethod -Uri "http://localhost:8080/api/users/auth" -Method POST -Headers @{"Content-Type"="application/json"} -Body '{"username":"admin", "password":"złe_haslo"}'
>>
Błąd autoryzacji. Zły użytkownik lub hasło.
PS C:\Users\kchl\Desktop\STUDIA\2 stopień\2 semestr\Projektowanie_obiektowe\Projektowanie_obiektowe_zadania_2026> 
```

----------------
# Zadanie 4 - Wzorce strukturalne

## Echo (Go)

Aplikacja w Go na frameworku `echo` z minimum jednym endpointem i funkcją proxy pobierającą dane z zewnętrznego API (pogoda, giełda itp.). Zapytania można wysyłać jako GET lub POST.

| Ocena | Opis | Commit |
|-------|------|--------|
| ✅ 3.0 | Aplikacja we frameworku Echo w Go z kontrolerem Pogody, umożliwiającym pobieranie danych o pogodzie lub akcjach giełdowych | [Link do commita 1 (3.0)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/981f29516f684e9b0fcd05de4a8f1cbccb35678b) |
| ✅ 3.5 | Model Pogoda (lub Giełda) z wykorzystaniem `gorm`, dane ładowane z listy przy uruchomieniu | [Link do commita 2 (3.5)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/58f82e311582635b379c853ef4fe9daacd7b5497) |
| ✅ 4.0 | Klasa proxy pobierająca dane z zewnętrznego serwisu podczas zapytania do kontrolera | [Link do commita 3 (4.0)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/f3de77e67379b639c1729a95a5aa4dbe9c214ff4) |
| ✅ 4.5 | Zapis pobranych danych zewnętrznych do bazy danych | [Link do commita 4 (4.5)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/8793fc341aca532132dcca9920cc45784ba03df4) |
| ⬜ 5.0 | Rozszerzenie endpointu na więcej niż jedną lokalizację (Pogoda) lub akcję (Giełda), zwracające JSON | — |

film : 

https://github.com/user-attachments/assets/0859bf7c-f81e-4f52-898b-33f4861cacc7

----------------
# Zadanie 5 - Wzorce behawioralne

## React (JavaScript/TypeScript)

Aplikacja kliencka w React (Vite) oraz mock-serwer w Node.js (Express), uruchamiane w kontenerach Docker przy pomocy `docker-compose`. Aplikacja posiada trzy widoki (Produkty, Koszyk, Płatności) oraz używa globalnego stanu opartego o React Context API.

| Ocena | Opis | Commit |
|-------|------|--------|
| ✅ 3.0 | Stworzenie komponentów Produkty (pobieranie z serwera) i Płatności (wysyłanie do serwera) |[Link do commita 1 (3.0)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/e1b8fe50612d70a620c6a85175612d3f17c6c9d8)|
| ✅ 3.5 | Dodanie komponentu Koszyk z osobnym widokiem; obsługa routingu między widokami | [Link do commita 2 (3.5)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/d5261585a7bf421feb1fa9b61c7e4d1a505e09c7)|
| ✅ 4.0 | Przekazywanie danych (stan koszyka) pomiędzy komponentami z użyciem React hooks (Context API / useState) |[Link do commita 3 (4.0)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/9ec5ce9da9d61d4a840776e2af3effb53567a353)|
| ✅ 4.5 | Konfiguracja umożliwiająca uruchomienie aplikacji klienckiej i serwerowej w kontenerach Docker (docker-compose) |[Link do commita 4 (4.5)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/76796f766062214516cc1a920780d3849d8f52b9)|


film : 


https://github.com/user-attachments/assets/71c470f6-4e93-4299-a865-87e317dd24ba

----------------
# Zadanie 6 - Kontrola jakości kodu

## Projekt JS

Należy sprawdzić kod projektów JS, Kotlin, Go pod kątem jakości. Na ten moment zrealizowano pierwsze punkty dla JS.

| Ocena | Opis | Commit |
|-------|------|--------|
| ✅ 3.0 | Skonfigurowano husky + lint-staged uruchamiające lintowanie przed commitem dla kodu JS | [Link do commita 1 (3.0)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/70fa2e47e5d318898444638d311767918e0f2623) |
| ✅ 3.5 | Wyeliminowano bugi zidentyfikowane przez Sonar/linter w kodzie aplikacji klienckiej | [Link do commita 2 (3.5)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/70fa2e47e5d318898444638d311767918e0f2623) |

----------------
# Zadanie 7 - Wzorce aplikacji webowych

## Swift (Vapor)

Proszę napisać prostą aplikację w Vaporze, wykorzystując Leaf jako silnik szablonów oraz Fluent jako ORM. Należy stworzyć kontrolery wraz z modelami, posiadające relacje i zgodne z CRUD.

| Ocena | Opis | Commit |
|-------|------|--------|
| ✅ 3.0 | Stworzenie kontrolera wraz z modelem Produktów zgodnego z CRUD w ORM Fluent | [Link do commita 1 (3.0)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/29a356504b985b2d8a4cbd4583aa238c7ac2b677) |
| ✅ 3.5 | Stworzenie szablonów w Leaf dla modelu Produktów | [Link do commita 2 (3.5)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/ddc7935fe1dee0494bbf23ed668ebc3d2aabc35d) |
| ✅ 4.0 | Stworzenie drugiego modelu (Kategorii) oraz kontrolera wraz z relacją do Produktów (Jeden-do-Wielu) | [Link do commita 3 (4.0)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/564f66cade5e408615749b100d0a1301647b952c)|
| ✅ 4.5 | Wykorzystanie bazy Redis do buforowania list danych (Cache) dla optymalizacji odczytu | [Link do commita 4 (4.5)](https://github.com/kacperchlastawa/Projektowanie_obiektowe_zadania_2026/tree/cd2121baa752b50704f4b94cc443037e192df428) |

film : 

https://github.com/user-attachments/assets/34e2ec68-f191-4821-af4c-a302458b9501


----------------
# Zadanie 8 - Testy automatyczne i bezpieczeństwo

## Selenium / Webdriver (JavaScript / Node.js)

Zadanie zrealizowano jako rozszerzenie aplikacji z Reactem (Zadanie 5). Dodano nowe komponenty oraz zaimplementowano skrypty testowe oparte na Selenium.

| Ocena | Opis |
|-------|------|
| ✅ 3.0 | Przetestowano formularz rejestracji użytkownika pod kątem walidacji pól obowiązkowych oraz niepoprawnego adresu e-mail (`test_rejestracja.js`) |
| ✅ 3.5 | Przeprowadzono testy bezpieczeństwa XSS; wstrzyknięto złośliwy kod w podatnym komponencie i wywołano alert (`test_xss.js`) |
| ✅ 4.0 | Zmodyfikowano Context API do użycia `localStorage` oraz eventu `storage` i przetestowano w wielu kartach zachowanie koszyka (`test_cart_tabs.js`) |
| ⬜ 4.5 | CSRF i dodanie formularza logowania (Nie zrealizowano) |
| ⬜ 5.0 | Scenariusz End-to-End w Playwright (Nie zrealizowano) |
