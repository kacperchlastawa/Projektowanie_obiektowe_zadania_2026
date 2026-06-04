/* eslint-disable react-refresh/only-export-components */
import { createContext, useState, useContext, useEffect } from 'react';
import type { ReactNode } from 'react';

export interface Product {
  id: number;
  name: string;
  price: number;
}

export interface CartItem extends Product {
  quantity: number;
}

interface CartContextType {
  cartItems: CartItem[];
  addToCart: (product: Product) => void;
  cartTotal: number;
}

export const CartContext = createContext<CartContextType | undefined>(undefined);

export const CartProvider = ({ children }: { children: ReactNode }) => {
  const [cartItems, setCartItems] = useState<CartItem[]>(() => {
    const saved = localStorage.getItem('cartItems');
    if (saved) {
      try {
        return JSON.parse(saved);
      } catch {
        return [];
      }
    }
    return [];
  });

  // Nasłuchiwanie na zmiany w localStorage wywołane w innych kartach
  useEffect(() => {
    const handleStorage = (e: StorageEvent) => {
      if (e.key === 'cartItems' && e.newValue) {
        try {
          setCartItems(JSON.parse(e.newValue));
        } catch {
          // błąd parsowania
        }
      }
    };
    window.addEventListener('storage', handleStorage);
    return () => window.removeEventListener('storage', handleStorage);
  }, []);

  const addToCart = (product: Product) => {
    setCartItems(prevItems => {
      let newItems;
      const existing = prevItems.find(item => item.id === product.id);
      if (existing) {
        newItems = prevItems.map(item =>
          item.id === product.id ? { ...item, quantity: item.quantity + 1 } : item
        );
      } else {
        newItems = [...prevItems, { ...product, quantity: 1 }];
      }
      localStorage.setItem('cartItems', JSON.stringify(newItems));
      return newItems;
    });
  };

  const cartTotal = cartItems.reduce((sum, item) => sum + item.price * item.quantity, 0);

  return (
    <CartContext.Provider value={{ cartItems, addToCart, cartTotal }}>
      {children}
    </CartContext.Provider>
  );
};

export const useCart = () => {
  const context = useContext(CartContext);
  if (!context) {
    throw new Error('useCart must be used within a CartProvider');
  }
  return context;
};
