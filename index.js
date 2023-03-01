import http from "node:http";

const server = http.createServer((req, res) => {
  res.setHeader("Content-Type", "application/json");

  if (req.url === "/" && req.method === "GET") {
    res.write(JSON.stringify({ data: "hey there" }) + "\n");
  } else {
    res.statusCode = 404;
    res.write(JSON.stringify({ error: `cannot ${req.method} ${req.url}` }) + "\n");
  }

  res.end();
});

const PORT = 3000;
server.listen(PORT, () => console.log(`server running on port ${PORT}...`));
