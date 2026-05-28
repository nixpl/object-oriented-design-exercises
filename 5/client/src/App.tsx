import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import { CartProvider } from './components/CartContext';
import { Products } from './components/Products';
import { Payments } from './components/Payments';
import { Cart } from './components/Cart';
import Login from './components/Login';
import Register from './components/Register';

function App() {
    const token = localStorage.getItem('authToken');

    const handleLogout = () => {
        localStorage.removeItem('authToken');
        globalThis.location.reload();
    };

    return (
        <CartProvider>
            <Router>
                <div style={{ fontFamily: 'system-ui, sans-serif', padding: '20px' }}>
                    <h1>Sklep internetowy React</h1>
                    <nav style={{ marginBottom: '20px' }}>
                        <Link to="/" style={{ marginRight: '15px', textDecoration: 'none', color: 'blue' }}>Produkty</Link>
                        <Link to="/cart" style={{ marginRight: '15px', textDecoration: 'none', color: 'blue' }}>Koszyk</Link>
                        <Link to="/payments" style={{ marginRight: '15px', textDecoration: 'none', color: 'blue' }}>Płatności</Link>
                        {token ? (
                            <button onClick={handleLogout} style={{ border: 'none', background: 'none', color: 'blue', cursor: 'pointer', textDecoration: 'underline', fontSize: '16px', padding: 0 }}>Wyloguj</button>
                        ) : (
                            <>
                                <Link to="/login" style={{ marginRight: '15px', textDecoration: 'none', color: 'blue' }}>Logowanie</Link>
                                <Link to="/register" style={{ textDecoration: 'none', color: 'blue' }}>Rejestracja</Link>
                            </>
                        )}
                    </nav>
                    <hr />
                    <Routes>
                        <Route path="/" element={<Products />} />
                        <Route path="/cart" element={<Cart />} />
                        <Route path="/payments" element={<Payments />} />
                        <Route path="/login" element={<Login />} />
                        <Route path="/register" element={<Register />} />
                    </Routes>
                </div>
            </Router>
        </CartProvider>
    );
}

export default App;
