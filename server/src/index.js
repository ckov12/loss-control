const express = require('express');
const { Pool } = require('pg');

const app = express();
const port = process.env.PORT || 3000;  

// PostgreSQL connection pool setup
const pool = new Pool({
  user: 'your_db_user',  // replace with your database user
  host: 'localhost',      // replace with your database host
  database: 'your_db_name', // replace with your database name
  password: 'your_db_password', // replace with your database password
  port: 5432,             // replace with your database port
});

// Sample route
app.get('/', (req, res) => {
  res.send('Hello, Express!');
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something broke!');
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
