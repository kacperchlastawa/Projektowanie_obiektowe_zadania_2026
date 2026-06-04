import { Builder, By, until } from 'selenium-webdriver';
import assert from 'assert';

(async function testCartTabs() {
  let driver = await new Builder().forBrowser('chrome').build();
  try {
    console.log("Otwieranie aplikacji w pierwszej karcie...");
    await driver.get('http://localhost:5173/');

    // Pobierz uchwyt pierwszej karty
    let originalWindow = await driver.getWindowHandle();

    // Otwórz nową kartę i przejdź do koszyka
    await driver.switchTo().newWindow('tab');
    await driver.get('http://localhost:5173/koszyk');
    
    // Upewnij się, że koszyk jest na początku pusty w nowej karcie
    let bodyTextTab2 = await driver.findElement(By.css('body')).getText();
    assert.match(bodyTextTab2, /Koszyk jest pusty/);
    console.log("Karta 2: Koszyk jest poprawnie pusty na start.");

    // Pobierz uchwyty wszystkich kart
    let windows = await driver.getAllWindowHandles();
    let secondWindow = windows.find(handle => handle !== originalWindow);

    // Wróć do pierwszej karty
    console.log("Powrót do Karty 1 i dodanie produktu do koszyka...");
    await driver.switchTo().window(originalWindow);

    // Znajdź przycisk 'Dodaj do koszyka' (dla pierwszego produktu) i kliknij
    let addToCartBtn = await driver.findElement(By.xpath("//button[contains(text(), 'Dodaj do koszyka')]"));
    await addToCartBtn.click();
    console.log("Dodano produkt do koszyka w Karcie 1.");

    // Przełącz na drugą kartę i sprawdź czy produkt się pojawił automatycznie
    console.log("Przełączanie na Kartę 2 w celu sprawdzenia synchronizacji...");
    await driver.switchTo().window(secondWindow);
    
    // Dajmy Reactowi moment na odebranie zdarzenia storage i przerysowanie
    await driver.sleep(1000);

    bodyTextTab2 = await driver.findElement(By.css('body')).getText();
    
    if (bodyTextTab2.includes("Koszyk jest pusty")) {
        throw new Error("Błąd synchronizacji: Koszyk w Karcie 2 wciąż jest pusty mimo dodania w Karcie 1.");
    }
    
    assert.match(bodyTextTab2, /szt\./); // Jeżeli koszyk ma produkt, będzie "1 szt."
    console.log("✅ SUKCES! Synchronizacja stanu koszyka między kartami działa bez odświeżania strony.");

  } catch (err) {
    console.error("❌ Błąd podczas testowania:", err);
  } finally {
    await driver.sleep(2000); // pauza by móc zobaczyć efekt
    await driver.quit();
  }
})();
