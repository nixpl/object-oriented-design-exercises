import { useState, useEffect } from 'react';
import axios from 'axios';
import { useCart } from './CartContext';

export const Products = () => {
    const [products, setProducts] = useState<any[]>([]);
    const { addToCart } = useCart();

    useEffect(() => {
        axios.get('https://app-server-michalkobylski-bag5bdezbggxcsac.swedencentral-01.azurewebsites.net/products')
            .then(res => setProducts(res.data))
            .catch(err => console.error(err));
    }, []);

    return (
        <div style={{ maxWidth: '600px' }}>
            <h2>Lista Produktów</h2>
            <ul style={{ listStyleType: 'none', padding: 0 }}>
                {products.map(p => (
                    <li key={p.id} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderBottom: '1px solid #eee', padding: '15px 0' }}>
                        <span style={{ fontSize: '1.1em' }}>{p.name} - <strong>{p.price} PLN</strong></span>
                        <button onClick={() => addToCart(p)} style={{ padding: '8px 12px', cursor: 'pointer', backgroundColor: '#007BFF', color: 'white', border: 'none', borderRadius: '4px', fontWeight: 'bold' }}>
                            Dodaj do koszyka
                        </button>
                    </li>
                ))}
            </ul>
        </div>
    );
};
