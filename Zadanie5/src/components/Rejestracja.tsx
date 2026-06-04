import React, { useState } from 'react';

const Rejestracja = () => {
  const [formData, setFormData] = useState({
    username: '',
    email: '',
    password: ''
  });
  const [errors, setErrors] = useState<string[]>([]);
  const [success, setSuccess] = useState(false);

  const validateEmail = (email: string) => {
    return /\S+@\S+\.\S+/.test(email);
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    const newErrors: string[] = [];

    if (!formData.username) newErrors.push('Nazwa użytkownika jest wymagana');
    if (!formData.email) newErrors.push('Email jest wymagany');
    else if (!validateEmail(formData.email)) newErrors.push('Niepoprawny format adresu e-mail');
    if (!formData.password) newErrors.push('Hasło jest wymagane');

    if (newErrors.length > 0) {
      setErrors(newErrors);
      setSuccess(false);
    } else {
      setErrors([]);
      setSuccess(true);
      // Tutaj w przyszłości można wysłać dane do API
    }
  };

  return (
    <div style={{ maxWidth: '400px', margin: '0 auto', padding: '20px', border: '1px solid #ccc', borderRadius: '5px' }}>
      <h2>Rejestracja</h2>
      {success && (
        <div id="success-message" style={{ color: 'green', marginBottom: '10px' }}>
          Rejestracja zakończona sukcesem!
          {/* PODATNOŚĆ XSS - renderowanie nazwy użytkownika jako niesprawdzonego HTML */}
          <div id="welcome-message" dangerouslySetInnerHTML={{ __html: `Witaj, ${formData.username}!` }} />
        </div>
      )}
      {errors.length > 0 && (
        <div id="error-messages" style={{ color: 'red', marginBottom: '10px' }}>
          <ul>
            {errors.map((err, index) => <li key={index}>{err}</li>)}
          </ul>
        </div>
      )}
      <form onSubmit={handleSubmit}>
        <div style={{ marginBottom: '10px' }}>
          <label htmlFor="username" style={{ display: 'block', marginBottom: '5px' }}>Nazwa użytkownika:</label>
          <input
            type="text"
            id="username"
            name="username"
            value={formData.username}
            onChange={(e) => setFormData({ ...formData, username: e.target.value })}
            style={{ width: '100%', padding: '8px', boxSizing: 'border-box' }}
          />
        </div>
        <div style={{ marginBottom: '10px' }}>
          <label htmlFor="email" style={{ display: 'block', marginBottom: '5px' }}>E-mail:</label>
          <input
            type="text"
            id="email"
            name="email"
            value={formData.email}
            onChange={(e) => setFormData({ ...formData, email: e.target.value })}
            style={{ width: '100%', padding: '8px', boxSizing: 'border-box' }}
          />
        </div>
        <div style={{ marginBottom: '10px' }}>
          <label htmlFor="password" style={{ display: 'block', marginBottom: '5px' }}>Hasło:</label>
          <input
            type="password"
            id="password"
            name="password"
            value={formData.password}
            onChange={(e) => setFormData({ ...formData, password: e.target.value })}
            style={{ width: '100%', padding: '8px', boxSizing: 'border-box' }}
          />
        </div>
        <button type="submit" id="submit-btn" style={{ width: '100%', padding: '10px', backgroundColor: '#007bff', color: 'white', border: 'none', borderRadius: '3px', cursor: 'pointer' }}>
          Zarejestruj się
        </button>
      </form>
    </div>
  );
};

export default Rejestracja;
