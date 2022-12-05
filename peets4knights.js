const pgp = require('pg-promise')();
const db = pgp({
  host: process.env.DB_SERVER,
  port: process.env.DB_PORT,
  database: process.env.DB_USER,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD
});

const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const router = express.Router();
router.use(express.json());

router.get("/", readHelloMessage);
router.get("/itemInfo", readitemInfo);
router.get("/itemInfo1", readitemInfo1);
router.get("/loginInfo", readloginInfo);
router.get("/pastOrder", readpastOrder);
router.get("/orderItems", readorderItems);
router.post("/pastOrder", createpastOrder);
router.post("/orderItems", createorderItems);

app.use(router);
app.use(errorHandler);
app.listen(port, () => console.log(`Listening on port ${port}`));


function errorHandler(err, req, res) {
  if (app.get('env') === "development") {
    console.log(err);
  }
  res.sendStatus(err.status || 500);
}

function returnDataOr404(res, data) {
  if (data == null) {
    res.sendStatus(404);
  } else {
    res.send(data);
  }
}

function readHelloMessage(req, res) {
  res.send('Peets4Knights CS 262 service!');
}

function readitemInfo(req, res, next) {
  db.many("SELECT * FROM itemInfo WHERE itemtype = 'coffee'")
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      next(err);
    })
}

function readitemInfo1(req, res, next) {
  db.many("SELECT * FROM itemInfo WHERE itemtype = 'food'")
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      next(err);
    })
}

function readloginInfo(req, res, next) {
  db.many("SELECT * FROM loginInfo")
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      next(err);
    })
}

function readpastOrder(req, res, next) {
  db.many("SELECT * FROM pastOrder WHERE ID = ${body.orderID}")
    .then(data => {
      returnDataOr404(res, data);
    })
    .catch(err => {
      next(err);
    })
}

function readorderItems(req, res, next) {
  db.many("SELECT * FROM orderItems WHERE ID = ${body.itemID}")
    .then(data => {
      returnDataOr404(res, data);
    })
    .catch(err => {
      next(err);
    })
}

function createpastOrder(req, res, next) {
  db.one('INSERT INTO pastOrder VALUES (${ID}, ${orderTime}, ${orderCompleted}, ${totalCost}) RETURNING ID', req.body)
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      next(err);
    });
}


function createorderItems(req, res, next) {
  db.one('INSERT INTO pastItems VALUES (DEFAULT, ${orderItemName}, ${orderItemCost}, ${orderItemURI}, ${orderItemSize}) RETURNING id', req.body)
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      next(err);
    });
}