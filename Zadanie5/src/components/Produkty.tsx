import { useEffect, useState } from 'react';

interface Product {
  id: number;
  name: string;
  price: number;
}

const Produkty: React.FC = () => {
  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading] = useState<boolean>(true);

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
          <li key={p.id}>{p.name} - {p.price} PLN</li>
        ))}
      </ul>
    </div>
  );
};

export default Produkty;
