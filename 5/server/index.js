import express from 'express';

const app = express();
app.use(express.json());

app.use((req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Content-Type");
    next();
});

const products = [
    { id: 1, name: "Smartwatch", price: 600 },
    { id: 2, name: "Sluchawki Bluetooth", price: 250 },
    { id: 3, name: "Powerbank 20000mAh", price: 120 }
];

app.get('/products', (req, res) => {
    res.json(products);
});

app.post('/payments', (req, res) => {
    console.log("Platnosc dotarla:", req.body);
    res.json({ status: "success", message: "Platnosc przebiegla pomyslnie" });
});

app.listen(3001, '0.0.0.0', () => {
    console.log("Serwer dziala na http://0.0.0.0:3001");
});
