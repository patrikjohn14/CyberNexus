const { Pool } = require('pg');
require('dotenv').config();

const password = process.env.DB_PASSWORD;
const pool = new Pool({
  host: process.env.DB_HOST || '127.0.0.1',
  user: process.env.DB_USER || 'root',
  password: password === '' ? null : password,
  database: process.env.DB_NAME || 'mydb',
  port: process.env.DB_PORT ? parseInt(process.env.DB_PORT) : 5432,
  max: 10,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});

(async () => {
  try {
    const client = await pool.connect();
    console.log('✅ Connection Success with Database');
    client.release();
  } catch (err) {
    console.error('❌ Connection failed with Database:', err.message);
  }
})();

module.exports = pool;