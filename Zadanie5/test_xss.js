import { Builder, By, until } from 'selenium-webdriver';
import assert from 'assert';

(async function testXSS() {
  let driver = await new Builder().forBrowser('chrome').build();
  try {
    console.log("Otwieranie strony rejestracji do testu XSS...");
    await driver.get('http://localhost:5173/rejestracja');

    // Przygotowanie payloadu XSS
    // Używamy tagu <img> z błędnym źródłem i atrybutem onerror, który wywołuje alert
    // Ponieważ React sanitizuje zwykłe <script>, sztuczka z onerror jest często skuteczna w podatnych polach
    const xssPayload = "<img src='x' onerror='document.body.style.backgroundColor=\"red\"; alert(\"XSS Attack Successful!\"); document.body.setAttribute(\"data-xss-success\", \"true\");' />";

    console.log("Test 1: Wstrzykiwanie złośliwego kodu XSS do pola nazwy użytkownika...");
    let usernameInput = await driver.findElement(By.id('username'));
    let emailInput = await driver.findElement(By.id('email'));
    let passwordInput = await driver.findElement(By.id('password'));

    await usernameInput.sendKeys(xssPayload);
    await emailInput.sendKeys('test-xss@example.com');
    await passwordInput.sendKeys('haslo123');
    
    let submitBtn = await driver.findElement(By.id('submit-btn'));
    await submitBtn.click();

    // Czekamy na pojawienie się komunikatu o sukcesie
    await driver.wait(until.elementLocated(By.id('success-message')), 2000);

    // Sprawdzenie czy atak XSS się powiódł
    // Kod XSS zmienia kolor tła na czerwony i ustawia atrybut na body
    try {
      // Oczekujemy, że alert się pojawi (w Selenium czasami trzeba obsłużyć alert, czasami działa jako wstrzyknięty DOM - onerror na img odpala kod synchronicznie w widoku)
      await driver.wait(until.alertIsPresent(), 2000);
      let alert = await driver.switchTo().alert();
      console.log("⚠️ Złapano Alert XSS z tekstem:", await alert.getText());
      await alert.accept();
    } catch (e) {
        // Jeśli alertu nie było, sprawdzamy modyfikację DOM jako dowód wstrzyknięcia
    }

    // Sprawdzamy skutki wstrzykniętego kodu JS w dom
    let bodyElement = await driver.findElement(By.css('body'));
    let isXssSuccess = await bodyElement.getAttribute('data-xss-success');
    let bgColor = await bodyElement.getCssValue('background-color');

    if (isXssSuccess === 'true' || bgColor === 'rgba(255, 0, 0, 1)') {
        console.log("🚨 PODATNOŚĆ ZNALEZIONA! Skrypt XSS został pomyślnie wstrzyknięty i wykonany na stronie.");
    } else {
        console.log("✅ Bezpiecznie: Kod XSS nie został wywołany.");
    }

  } catch (err) {
    console.error("❌ Błąd podczas testowania:", err);
  } finally {
    // Odczekajmy sekundę by było widać efekt (czerwone tło itp) jeśli ktoś ogląda
    await driver.sleep(2000);
    await driver.quit();
  }
})();
