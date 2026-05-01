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

app.listen(3001, '0.0.0.0', () => {
    console.log("Serwer dziala na http://0.0.0.0:3001");
});
