import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import Produkty from './components/Produkty';
import Platnosci from './components/Platnosci';
import Koszyk from './components/Koszyk';
import Rejestracja from './components/Rejestracja';
import { CartProvider } from './context/CartContext';
import './App.css';

function App() {
  return (
    <CartProvider>
      <Router>
        <div className="App" style={{ padding: '20px', fontFamily: 'sans-serif' }}>
          <h1>Aplikacja Sklepowa</h1>
          
          {/* Nawigacja */}
          <nav style={{ marginBottom: '20px', padding: '10px', backgroundColor: '#f0f0f0', borderRadius: '5px' }}>
            <ul style={{ listStyleType: 'none', padding: 0, display: 'flex', gap: '20px', margin: 0 }}>
              <li><Link to="/">Produkty</Link></li>
              <li><Link to="/koszyk">Koszyk</Link></li>
              <li><Link to="/platnosci">Płatności</Link></li>
              <li><Link to="/rejestracja">Rejestracja</Link></li>
            </ul>
          </nav>

          {/* Konfiguracja widoków */}
          <Routes>
            <Route path="/" element={<Produkty />} />
            <Route path="/koszyk" element={<Koszyk />} />
            <Route path="/platnosci" element={<Platnosci />} />
            <Route path="/rejestracja" element={<Rejestracja />} />
          </Routes>
        </div>
      </Router>
    </CartProvider>
  );
}

export default App;
