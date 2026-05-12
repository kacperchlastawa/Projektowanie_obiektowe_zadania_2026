import { useEffect, useState } from 'react';
import { useCart } from '../context/CartContext';
import type { Product } from '../context/CartContext';

const Produkty: React.FC = () => {
  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading] = useState<boolean>(true);

  const { addToCart } = useCart();

  useEffect(() => {
    fetch('http://localhost:8080/api/products')
      .then(res => {
        if (!res.ok) throw new Error('Błąd serwera');
        return res.json();
      })
      .then(data => {
        setProducts(data);
        setLoading(false);
      })
      .catch(err => {
        console.error('Błąd pobierania produktów:', err);
        setProducts([
          { id: 1, name: 'Przykładowy Produkt 1', price: 49.99 },
          { id: 2, name: 'Przykładowy Produkt 2', price: 99.99 }
        ]);
        setLoading(false);
      });
  }, []);

  if (loading) return <p>Ładowanie produktów...</p>;

  return (
    <div>
      <h2>Lista Produktów</h2>
      <ul>
        {products.map(p => (
          <li key={p.id} style={{ marginBottom: '10px' }}>
            {p.name} - {p.price.toFixed(2)} PLN{' '}
            <button onClick={() => addToCart(p)}>Dodaj do koszyka</button>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default Produkty;
