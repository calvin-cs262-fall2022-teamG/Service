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
router.get("/itemInfo/:id", readitemInfo);
router.get("/loginInfo/", readloginInfo);
router.get("/pastOrder/:id", readpastOrder);
router.get("/orderItems/:id", readorderItems);
router.post("/pastOrder/:id", createpastOrder);
router.post("/orderItems/:id", createorderItems);

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
  db.many("SELECT itemname, uri, smcost, mdcost, lgcost, itemtype FROM itemInfo WHERE iteminfo.id =${id}")
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
  db.many("SELECT ordertime, ordercompleted, totalcost FROM pastOrder WHERE pastorder.id = ${id}")
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      next(err);
    })
}

function readorderItems(req, res, next) {
  db.many("SELECT orderitemname, orderitemcost, orderitemuri, orderitemsize FROM orderItems WHERE orderitems.orderid = ${id}")
    .then(data => {
      res.send(data);
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