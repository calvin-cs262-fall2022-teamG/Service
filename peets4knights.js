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