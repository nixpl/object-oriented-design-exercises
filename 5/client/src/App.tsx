import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import { Products } from './components/Products';
import { Payments } from './components/Payments';
import { Cart } from './components/Cart';

function App() {
  return (
    <Router>
      <div style={{ fontFamily: 'system-ui, sans-serif', padding: '20px' }}>
        <h1>Sklep internetowy React</h1>
        <nav style={{ marginBottom: '20px' }}>
          <Link to="/" style={{ marginRight: '15px', textDecoration: 'none', color: 'blue' }}>Produkty</Link>
          <Link to="/cart" style={{ marginRight: '15px', textDecoration: 'none', color: 'blue' }}>Koszyk</Link>
          <Link to="/payments" style={{ textDecoration: 'none', color: 'blue' }}>Płatności</Link>
        </nav>
        <hr />
        <Routes>
          <Route path="/" element={<Products />} />
          <Route path="/cart" element={<Cart />} />
          <Route path="/payments" element={<Payments />} />
        </Routes>
      </div>
    </Router>
  )
}

export default App;
