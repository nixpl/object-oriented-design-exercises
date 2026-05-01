import { useState } from 'react';
import axios from 'axios';
import { useCart } from './CartContext';

export const Payments = () => {
    const [status, setStatus] = useState('');
    const { totalAmount, clearCart } = useCart();

    const handlePayment = () => {
        if (totalAmount === 0) return;

        axios.post('http://localhost:3001/payments', { amount: totalAmount })
        .then(res => {
            setStatus(res.data.message);
            clearCart();
        })
        .catch(err => console.error(err));
    };

    return (
        <div>
            <h2>Płatności</h2>
            <p style={{ fontSize: '1.2em' }}>Do zapłaty: <strong>{totalAmount} PLN</strong></p>
            <button onClick={handlePayment} disabled={totalAmount === 0} style={{ padding: '12px 24px', cursor: totalAmount === 0 ? 'not-allowed' : 'pointer', backgroundColor: totalAmount === 0 ? '#ccc' : '#28A745', color: 'white', border: 'none', borderRadius: '4px', fontSize: '1.1em', fontWeight: 'bold' }}>
                Zapłać
            </button>
            {status && <p style={{color: '#28A745', marginTop: '15px', fontWeight: 'bold', fontSize: '1.1em'}}>{status}</p>}
        </div>
    );
};
