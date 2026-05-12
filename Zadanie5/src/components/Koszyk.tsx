import { useCart } from '../context/CartContext';

const Koszyk: React.FC = () => {
  const { cartItems, cartTotal } = useCart();

  return (
    <div>
      <h2>Twój Koszyk</h2>
      {cartItems.length === 0 ? (
        <p>Koszyk jest pusty.</p>
      ) : (
        <div>
          <ul>
            {cartItems.map(item => (
              <li key={item.id}>
                {item.name} - {item.quantity} szt. - {(item.price * item.quantity).toFixed(2)} PLN
              </li>
            ))}
          </ul>
          <h3>Suma: {cartTotal.toFixed(2)} PLN</h3>
        </div>
      )}
    </div>
  );
};

export default Koszyk;
