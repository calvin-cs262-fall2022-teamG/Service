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
router.get("/orderFull", readorderFull);
router.get("/orderedItem", readorderedItem);
router.post("/orderFull", createorderFull);
router.post("/orderedItem", createorderedItem);
router.delete('/orderFull/:orderID', deleteorderFull);
router.delete('/orderedItem/:groupID', deleteorderedItem);

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
  db.many("SELECT * FROM itemInfo")
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      next(err);
    })
}

function readorderFull(req, res, next) {
  db.oneOrNone('SELECT * FROM orderFull', req.params)
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      next(err);
    });
}

function readorderedItem(req, res, next) {
  db.oneOrNone('SELECT * FROM orderedItem', req.params)
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      next(err);
    });
}

function createorderFull(req, res, next) {
  db.one('INSERT INTO orderFull(orderID, userName, orderTime, completedTime, totalCost) VALUES (${orderID}, ${userName}, ${orderTime}, ${completedTime}, ${totalCost}) RETURNING id', req.body)
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      next(err);
    });
}

function createorderedItem(req, res, next) {
  db.one('INSERT INTO orderedItem(groupID, itemOrdered, tea, ice, milk, shots, decaf, syrup, syrupAmount, topping, toppingAmount, sweetener, sweetenerAmount, itemCost) VALUES (${groupID}, ${itemOrdered}, ${tea}, ${ice}, ${milk}, ${shots}, ${decaf}, ${syrup}, ${syrupAmount}, ${topping}, ${toppingAmount}, ${sweetener}, ${sweetenerAmount}, ${itemCost}) RETURNING id', req.body)
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      next(err);
    });
}

function deleteorderFull(req, res, next) {
  db.oneOrNone('DELETE FROM orderFull WHERE orderID=${orderID} RETURNING id', req.params)
    .then(data => {
      returnDataOr404(res, data);
    })
    .catch(err => {
      next(err);
    });
}

function deleteorderedItem(req, res, next) {
  db.oneOrNone('DELETE FROM orderFull WHERE groupID=${groupID} RETURNING id', req.params)
    .then(data => {
      returnDataOr404(res, data);
    })
    .catch(err => {
      next(err);
    });
}


