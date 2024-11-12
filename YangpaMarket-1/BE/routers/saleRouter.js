const express = require('express');
const { Sale } = require('../models/index');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const secret = process.env.JWT_SECRET;

const upload = require('./uploadImage');
router.post('/', upload.single('photo'));

router.post('/', async (req, res) => {
  const newPost = req.body;
  newPost.userID = req.userID;
  newPost.photo = req.filename;
  console.log(newPost);
  try {
    const result = await Sale.create(newPost);
    console.log(result);
    result.price = parseInt(result.price);
    res.json({ success: true, documents: [result], message: 'post 등록 성공' });
  } catch (error) {
    res.json({
      success: false,
      documents: [],
      message: `post 등록 실패 ${error}`,
    });
  }
});

router.get('/', async (req, res) => {
  const result = await Sale.findAll();
  res.json({ success: true, documents: result, message: 'sales 조회성공' });
});

router.get('/:id', async (req, res) => {
  const id = req.params.id;
  const options = {
    where: {
      id: id,
    },
  };
  const result = await Sale.findAll(options);
  res.json({ success: true, documents: result, message: 'sale 조회성공' });
});

module.exports = router;
