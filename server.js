const express = require('express');
const cors = require('cors');
const rateLimit = require('express-rate-limit');
const helmet = require('helmet');
const hpp = require('hpp');
const apiRoutes = require('./routes/apiRoutes');
require('dotenv').config(); 
require('./config/database');

const app = express();

app.use(helmet());
app.use(hpp());

app.use(cors({
  origin: process.env.ALLOWED_ORIGINS?.split(',') || true,
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 100,
  message: 'Too many requests from this IP, please try again later'
});

app.use(limiter);
app.use(express.json({ limit: '10kb' }));

app.use('/api', apiRoutes);

const PORT = process.env.PORT || 4000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`✅ Server running on port ${PORT}`);
});