const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const path = require('path');
const crypto = require('crypto');
const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));

// MySQL connection
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '12345678',
    database: 'redox'
});

db.connect(err => {
    if (err) throw err;
    console.log('MySQL Connected...');
});

// Middleware for token verification
const verifyToken = (req, res, next) => {
    const token = req.headers['authorization'];
    if (!token) return res.status(403).send('Token is required');
    jwt.verify(token, 'secretkey', (err, decoded) => {
        if (err) return res.status(500).send('Failed to authenticate token');
        req.userId = decoded.id;
        req.userRole = decoded.role;
        next();
    });
};

// Register endpoint
app.post('/register', (req, res) => {
    const { username, password, role } = req.body;
    const hashedPassword = bcrypt.hashSync(password, 8);

    const query = 'INSERT INTO users (username, password, role_id) VALUES (?, ?, ?)';
    db.query(query, [username, hashedPassword, role], (err, result) => {
        if (err) return res.status(500).send('There was a problem registering the user');
        res.status(200).send('User registered successfully');
    });
});

// Login endpoint
app.post('/login', (req, res) => {
    const { username, password } = req.body;
    const query = 'SELECT * FROM users WHERE username = ?';
    db.query(query, [username], (err, results) => {
        if (err) {
            console.error('Database error:', err); // Debugging statement
            return res.status(500).send('Error on the server');
        }
        if (!results.length) {
            return res.status(404).send('No user found');
        }
        
        const user = results[0];
        const hashedPassword = crypto.createHash('sha256').update(password).digest('hex');

        if (hashedPassword !== user.password) {
            console.warn('Password incorrect'); // Debugging statement
            return res.status(401).send('Password is incorrect');
        }
        
        const token = jwt.sign({ id: user.id, role: user.role_id }, 'secretkey');
        res.status(200).send({ auth: true, token });
    });
});

app.get('/level1questions', verifyToken, (req, res) => {
    if (req.userRole !== 3) return res.status(403).json({ error: 'Access denied' });
    
    db.query('SELECT * FROM level1questions', (err, results) => {
        if (err) return res.status(500).json({ error: 'There was a problem finding the questions' });
        res.status(200).json(results);
    });
});

app.post('/level1questions', verifyToken, (req, res) => {
    if (req.userRole !== 3) return res.status(403).send('Access denied');
    
    const {question_text, options} = req.body;
    const query = 'INSERT INTO level1questions (question_text, correctOption, incorrectOption1, incorrectOption2, incorrectOption3) VALUES (?, ?, ?, ?, ?)';
    db.query(query, [question_text, options[0], options[1], options[2], options[3]], (err, result) => {
        if (err) {
            console.error('Query error:', err.sqlMessage); // Improved error logging
            return res.status(500).json({ error: 'There was a problem adding the question', details: err.sqlMessage });
        }
        console.log('Query result:', result); // Debugging statement
        res.status(200).json({ message: 'Question added successfully' });
    });
});

app.put('/level1questions/:id', verifyToken, (req, res) => {
    if (req.userRole !== 3) return res.status(403).json({ error: 'Access denied' });

    const { question_text, options } = req.body;
    const query = 'UPDATE level1questions SET question_text = ?, correctOption = ?, incorrectOption1 = ?, incorrectOption2 = ?, incorrectOption3 = ? WHERE id = ?';
    db.query(query, [question_text, options[0], options[1], options[2], options[3], req.params.id], (err, result) => {
        if (err) return res.status(500).json({ error: 'There was a problem updating the question' });
        res.status(200).json({ message: 'Question updated successfully' });
    });
});

app.delete('/level1questions/:id', verifyToken, (req, res) => {
    if (req.userRole !== 3) return res.status(403).json({ error: 'Access denied' });

    const query = 'DELETE FROM level1questions WHERE id = ?';
    db.query(query, [req.params.id], (err, result) => {
        if (err) return res.status(500).json({ error: 'There was a problem deleting the question' });
        res.status(200).json({ message: 'Question deleted successfully' });
    });
});

// Serve the HTML file
app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Change the port here to 3001 if needed
const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});