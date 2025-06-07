const express = require('express');
const app = express();
const router = express.Router();
const authController = require('../controllers/auth/authController');

router.post('/login',authController.login);

module.exports = router;