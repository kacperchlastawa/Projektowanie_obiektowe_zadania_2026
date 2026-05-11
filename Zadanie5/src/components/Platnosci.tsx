import { useState } from 'react';

const Platnosci: React.FC = () => {
  const [amount, setAmount] = useState<number>(0);
  const [status, setStatus] = useState<string>('');

  const handlePayment = () => {
    fetch('http://localhost:8080/api/payments', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ amount, currency: 'PLN' })
    })
      .then(res => {
        if (!res.ok) throw new Error('Błąd serwera');
        return res.json();
      })
      .then(() => setStatus('Płatność wysłana pomyślnie na serwer!'))
      .catch(err => {
        console.error('Błąd wysyłania płatności:', err);
        setStatus('Wysłano płatność (mock, ponieważ serwer obecnie nie obsługuje tego endpointu).');
      });
  };

  return (
    <div>
      <h2>Panel Płatności</h2>
      <div style={{ marginBottom: '10px' }}>
        <input
          type="number"
          value={amount}
          onChange={(e) => setAmount(Number(e.target.value))}
          placeholder="Kwota płatności"
        />
        <span> PLN</span>
      </div>
      <button onClick={handlePayment}>Zrealizuj Płatność</button>
      {status && <p><strong>Status:</strong> {status}</p>}
    </div>
  );
};

export default Platnosci;
