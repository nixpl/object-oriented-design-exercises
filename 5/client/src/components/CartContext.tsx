import { createContext, useState, useEffect, ReactNode, useContext, useMemo } from 'react';

interface Product {
  id: number;
  name: string;
  price: number;
}

interface CartContextType {
  cartItems: Product[];
  addToCart: (product: Product) => void;
  removeFromCart: (index: number) => void;
  clearCart: () => void;
  totalAmount: number;
}

export const CartContext = createContext<CartContextType | undefined>(undefined);

export const CartProvider = ({ children }: { children: ReactNode }) => {
  const [cartItems, setCartItems] = useState<Product[]>(() => {
    const saved = globalThis.localStorage.getItem('cartItems');
    return saved ? JSON.parse(saved) : [];
  });

  useEffect(() => {
    const sanitizedCartItems = cartItems.map(item => ({
      id: Number(item.id),
      name: String(item.name).replace(/[<>&"']/g, ""),
      price: Number(item.price)
    }));
    globalThis.localStorage.setItem('cartItems', JSON.stringify(sanitizedCartItems));
  }, [cartItems]);

  useEffect(() => {
    const handleStorageChange = (e: StorageEvent) => {
      if (e.key === 'cartItems' && e.newValue) {
        setCartItems(JSON.parse(e.newValue));
      } else if (e.key === 'cartItems' && !e.newValue) {
        setCartItems([]);
      }
    };

    globalThis.addEventListener('storage', handleStorageChange);
    return () => globalThis.removeEventListener('storage', handleStorageChange);
  }, []);

  const addToCart = (product: Product) => {
    setCartItems(prev => [...prev, product]);
  };

  const removeFromCart = (index: number) => {
    setCartItems(prev => prev.filter((_, i) => i !== index));
  };

  const clearCart = () => {
    setCartItems([]);
  };

  const totalAmount = cartItems.reduce((sum, item) => sum + item.price, 0);

  const contextValue = useMemo(() => ({
    cartItems,
    addToCart,
    removeFromCart,
    clearCart,
    totalAmount
  }), [cartItems, totalAmount]);

  return (
    <CartContext.Provider value={contextValue}>
      {children}
    </CartContext.Provider>
  );
};

export const useCart = () => {
  const context = useContext(CartContext);
  if (!context) {
    throw new Error("useCart must be used within a CartProvider");
  }
  return context;
};