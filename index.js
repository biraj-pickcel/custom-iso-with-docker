import express from "express";

const app = express();

app.get("/", (req, res) => {
  res.json({ data: "hello from Express" });
});

app.use((req, res, next) => {
  res.status(404).json({ error: `cannot ${req.method} ${req.url}` });
});

const PORT = 3000;
app.listen(PORT, () => console.log(`server running on port ${PORT}...`));
