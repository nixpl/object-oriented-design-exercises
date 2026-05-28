import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate, Link } from 'react-router-dom';

const Login: React.FC = () => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [errorMsg, setErrorMsg] = useState('');
    const navigate = useNavigate();

    const handleLogin = async (e: React.FormEvent) => {
        e.preventDefault();
        setErrorMsg('');
        try {
            const res = await axios.post('https://app-server-michalkobylski-bag5bdezbggxcsac.swedencentral-01.azurewebsites.net/api/login', { username, password });
            const sanitizedToken = String(res.data.token).replace(/[<>&"']/g, "");
            globalThis.localStorage.setItem('authToken', sanitizedToken);
            navigate('/'); 
            globalThis.location.reload();
        } catch (error: any) {
            setErrorMsg('Nieprawidłowe dane logowania');
        }
    };

    return (
        <div style={{ padding: '20px' }}>
            <h2>Logowanie</h2>
            {errorMsg && <div id="login-error" style={{ color: 'red' }}>{errorMsg}</div>}
            <form onSubmit={handleLogin} style={{ display: 'flex', flexDirection: 'column', width: '300px', gap: '10px' }}>
                <input id="login-username" type="text" placeholder="Nazwa użytkownika" value={username} onChange={e => setUsername(e.target.value)} required />
                <input id="login-password" type="password" placeholder="Hasło" value={password} onChange={e => setPassword(e.target.value)} required />
                <button id="login-submit" type="submit">Zaloguj</button>
            </form>
            <p>Nie masz konta? <Link to="/register">Zarejestruj się</Link></p>
        </div>
    );
};

export default Login;