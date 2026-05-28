import express from 'express';
import cors from 'cors';

const app = express();
app.use(express.json());
app.use(cors());

const products = [
    { id: 1, name: "Smartwatch", price: 600 },
    { id: 2, name: "Sluchawki Bluetooth", price: 250 },
    { id: 3, name: "Powerbank 20000mAh", price: 120 }
];

app.get('/products', (req, res) => {
    res.json(products);
});

app.post('/payments', (req, res) => {
    res.json({ status: "success", message: "Platnosc przebiegla pomyslnie" });
});

const port = process.env.PORT || 80;
app.listen(port, '0.0.0.0', () => {
    console.log(`Server is running on http://0.0.0.0:${port}`);
});

const users = [];

app.post('/api/register', (req, res) => {
    const { username, email, password } = req.body;
    if (users.find(u => u.username === username)) {
        return res.status(400).json({ message: 'Użytkownik już istnieje' });
    }
    users.push({ username, email, password });
    res.status(201).json({ message: 'Zarejestrowano' });
});

app.post('/api/login', (req, res) => {
    const { username, password } = req.body;
    const user = users.find(u => u.username === username && u.password === password);
    if (user) {
        res.json({ message: 'Zalogowano', token: 'fake-jwt-token-123' });
    } else {
        res.status(401).json({ message: 'Błędne dane' });
    }
});
