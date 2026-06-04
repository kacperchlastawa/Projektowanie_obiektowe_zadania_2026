import { Builder, By, until } from 'selenium-webdriver';
import assert from 'assert';

(async function testRejestracja() {
  let driver = await new Builder().forBrowser('chrome').build();
  try {
    console.log("Otwieranie strony rejestracji...");
    await driver.get('http://localhost:5173/rejestracja');

    // Test 1: Puste pola
    console.log("Test 1: Próba rejestracji z pustymi polami...");
    let submitBtn = await driver.findElement(By.id('submit-btn'));
    await submitBtn.click();

    let errorMessages = await driver.findElement(By.id('error-messages'));
    await driver.wait(until.elementIsVisible(errorMessages), 2000);
    let errorsText = await errorMessages.getText();
    
    assert.match(errorsText, /Nazwa użytkownika jest wymagana/);
    assert.match(errorsText, /Email jest wymagany/);
    assert.match(errorsText, /Hasło jest wymagane/);
    console.log("✅ Test 1 zakończony sukcesem: Walidacja pustych pól działa poprawnie.");

    // Test 2: Niepoprawny format adresu e-mail
    console.log("Test 2: Próba rejestracji z niepoprawnym adresem e-mail...");
    let usernameInput = await driver.findElement(By.id('username'));
    let emailInput = await driver.findElement(By.id('email'));
    let passwordInput = await driver.findElement(By.id('password'));

    await usernameInput.sendKeys('testuser');
    await emailInput.sendKeys('niepoprawnyemail');
    await passwordInput.sendKeys('haslo123');
    
    await submitBtn.click();

    await driver.wait(until.elementLocated(By.id('error-messages')), 2000);
    errorMessages = await driver.findElement(By.id('error-messages'));
    errorsText = await errorMessages.getText();

    assert.match(errorsText, /Niepoprawny format adresu e-mail/);
    console.log("✅ Test 2 zakończony sukcesem: Walidacja niepoprawnego formatu e-mail działa poprawnie.");

    // Test 3: Poprawne dane
    console.log("Test 3: Próba rejestracji z poprawnymi danymi...");
    await emailInput.clear();
    await emailInput.sendKeys('test@example.com');
    await submitBtn.click();

    let successMessage = await driver.wait(until.elementLocated(By.id('success-message')), 2000);
    let successText = await successMessage.getText();
    assert.match(successText, /Rejestracja zakończona sukcesem/);
    console.log("✅ Test 3 zakończony sukcesem: Rejestracja z poprawnymi danymi działa.");

  } catch (err) {
    console.error("❌ Testy zakończone błędem:", err);
  } finally {
    await driver.quit();
  }
})();
