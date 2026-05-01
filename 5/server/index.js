import express from 'express';
import sqlite3 from 'sqlite3';

const app = express();
app.use(express.json());

app.use((req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Content-Type");
    next();
});

const db = new sqlite3.Database('./database.sqlite');

db.serialize(() => {
    db.run("CREATE TABLE IF NOT EXISTS products (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, price REAL)");
    
    db.get("SELECT COUNT(*) as count FROM products", (err, row) => {
        if (row.count === 0) {
            const stmt = db.prepare("INSERT INTO products (name, price) VALUES (?, ?)");
            stmt.run("Smartwatch", 600);
            stmt.run("Sluchawki Bluetooth", 250);
            stmt.run("Powerbank 20000mAh", 120);
            stmt.finalize();
            console.log("Baza wygenerowana z produktami startowymi.");
        }
    });
});

app.get('/products', (req, res) => {
    db.all("SELECT * FROM products", [], (err, rows) => {
        if (err) {
            res.status(500).json({ error: err.message });
            return;
        }
        res.json(rows);
    });
});

app.post('/payments', (req, res) => {
    console.log("Otrzymano platnosc:", req.body);
    res.json({ status: "success", message: "Platnosc przebiegla pomyslnie" });
});

app.listen(3001, () => {
    console.log('Serwer dziala na porcie 3001');
});
