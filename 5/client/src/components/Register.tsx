import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate, Link } from 'react-router-dom';

const Register: React.FC = () => {
    const [username, setUsername] = useState('');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [errorMsg, setErrorMsg] = useState('');
    const navigate = useNavigate();

    const handleRegister = async (e: React.FormEvent) => {
        e.preventDefault();
        setErrorMsg('');
        
        if (!email.includes('@')) {
            setErrorMsg('Niepoprawny format adresu e-mail');
            return;
        }

        try {
            await axios.post('http://localhost:3001/api/register', { username, email, password });
            alert('Rejestracja udana!');
            navigate('/login');
        } catch (error: any) {
            setErrorMsg(error.response?.data?.message || 'Błąd rejestracji');
        }
    };

    return (
        <div style={{ padding: '20px' }}>
            <h2>Rejestracja</h2>
            {errorMsg && <div id="error-message" style={{ color: 'red' }}>{errorMsg}</div>}
            
            <form onSubmit={handleRegister} style={{ display: 'flex', flexDirection: 'column', width: '300px', gap: '10px' }}>
                <input id="reg-username" type="text" placeholder="Nazwa użytkownika" value={username} onChange={e => setUsername(e.target.value)} required />
                <input id="reg-email" type="email" placeholder="Adres e-mail" value={email} onChange={e => setEmail(e.target.value)} required />
                <input id="reg-password" type="password" placeholder="Hasło" value={password} onChange={e => setPassword(e.target.value)} required />
                <button id="reg-submit" type="submit">Zarejestruj się</button>
            </form>
            <p>Masz już konto? <Link to="/login">Zaloguj się</Link></p>
        </div>
    );
};

export default Register;
