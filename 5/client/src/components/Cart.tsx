import { useCart } from './CartContext';

export const Cart = () => {
  const { cartItems, removeFromCart, totalAmount } = useCart();

  return (
    <div style={{ maxWidth: '600px' }}>
      <h2>Twój Koszyk</h2>
      {cartItems.length === 0 ? (
        <p>Twój koszyk jest pusty.</p>
      ) : (
        <div>
          <ul style={{ listStyleType: 'none', padding: 0 }}>
            {cartItems.map((item, index) => (
              <li key={`cart-item-${item.id}-${index}`} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderBottom: '1px solid #eee', padding: '15px 0' }}>
                <span style={{ fontSize: '1.1em' }}>{item.name} - <strong>{item.price} PLN</strong></span>
                <button onClick={() => removeFromCart(index)} style={{ padding: '8px 12px', cursor: 'pointer', backgroundColor: '#DC3545', color: 'white', border: 'none', borderRadius: '4px' }}>
                  Usuń
                </button>
              </li>
            ))}
          </ul>
          <h3 style={{ textAlign: 'right', marginTop: '20px', fontSize: '1.5em' }}>Suma: {totalAmount} PLN</h3>
        </div>
      )}
    </div>
  );
};
