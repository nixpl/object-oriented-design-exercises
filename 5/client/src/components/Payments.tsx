import { useState } from 'react';

export const Payments = () => {
    const [status, setStatus] = useState('');

    const handlePayment = () => {
        fetch('http://localhost:3001/payments', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ amount: 100 })
        })
        .then(res => res.json())
        .then(data => setStatus(data.message))
        .catch(err => console.error(err));
    };

    return (
        <div>
            <h2>Płatności</h2>
            <button onClick={handlePayment}>Zapłać 100 PLN</button>
            {status && <p style={{color: 'green'}}>{status}</p>}
        </div>
    );
};
