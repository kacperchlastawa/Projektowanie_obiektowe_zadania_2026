const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

app.get('/api/products', (req, res) => {
  res.json([
    { id: 1, name: 'Laptop', price: 4999.99 },
    { id: 2, name: 'Mysz bezprzewodowa', price: 199.99 },
    { id: 3, name: 'Klawiatura mechaniczna', price: 349.99 }
  ]);
});

app.post('/api/payments', (req, res) => {
  console.log('Otrzymano płatność:', req.body);
  res.json({ status: 'success', message: 'Płatność została przetworzona' });
});

const PORT = 8080;
app.listen(PORT, () => {
  console.log(`Mock serwer (Zadanie 5) działa na porcie ${PORT}`);
});
