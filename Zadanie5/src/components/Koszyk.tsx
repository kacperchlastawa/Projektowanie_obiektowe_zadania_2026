import { useState } from 'react';

const Koszyk = () => {
  const [items] = useState([
    { id: 1, name: 'Przykładowy Produkt 1', price: 49.99, quantity: 1 }
  ]);

  const total = items.reduce((sum, item) => sum + item.price * item.quantity, 0);

  return (
    <div>
      <h2>Twój Koszyk</h2>
      {items.length === 0 ? (
        <p>Koszyk jest pusty.</p>
      ) : (
        <div>
          <ul>
            {items.map(item => (
              <li key={item.id}>
                {item.name} - {item.quantity} szt. - {(item.price * item.quantity).toFixed(2)} PLN
              </li>
            ))}
          </ul>
          <h3>Suma: {total.toFixed(2)} PLN</h3>
        </div>
      )}
    </div>
  );
};

export default Koszyk;
