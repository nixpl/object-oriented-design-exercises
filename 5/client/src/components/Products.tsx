import { useState, useEffect } from 'react';

export const Products = () => {
    const [products, setProducts] = useState<any[]>([]);

    useEffect(() => {
        fetch('http://localhost:3001/products')
            .then(res => res.json())
            .then(data => setProducts(data))
            .catch(err => console.error(err));
    }, []);

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
