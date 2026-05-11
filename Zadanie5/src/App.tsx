
import Produkty from './components/Produkty';
import Platnosci from './components/Platnosci';
import './App.css';

function App() {
  return (
    <div className="App" style={{ padding: '20px', fontFamily: 'sans-serif' }}>
      <h1>Aplikacja Sklepowa (Zadanie 5)</h1>
      <Produkty />
      <hr style={{ margin: '30px 0' }} />
      <Platnosci />
    </div>
  );
}

export default App;
