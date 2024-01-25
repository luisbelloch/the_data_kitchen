const { solutions, solved, errors } = require("./data");

const express = require("express");
const app = express();
const server = require("http").Server(app);

app.use(require("morgan")("tiny"));
app.use(require("body-parser").text({ type: "*/*" }));
app.use(express.static("docs"));

app.get("/api/solved", (_, res) => res.send(solved));

app.post("/api/:team/:exercise", (req, res) => {
  const { team, exercise } = req.params || {};
  if (!team || !exercise || !solutions[exercise]) {
    res.status(400).type("text/plain").send(errors.malformed);
    return;
  }

  if (solutions[exercise] !== req.body) {
    res.status(422).type("text/plain").send(errors.incorrect);
    return;
  }

  solved[exercise].push(team);
  res.send(errors.ok);
});

const port = process.env.PORT || 3000;
server.listen(port, () => console.log(`Listening on port ${port}`));
