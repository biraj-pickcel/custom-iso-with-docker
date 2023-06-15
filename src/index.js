import dotenv from "dotenv";
import express from "express";
import mongoose from "mongoose";
import redis from "redis";
import User from "./models/user.js";

dotenv.config();

let redisClient;

const app = express();

app.use(express.json());

app.get("/", (req, res) => {
  res.json({ data: "hello from Express" });
});

app.get("/redis/:key", async (req, res) => {
  try {
    const { key } = req.params;
    const value = await redisClient.get(key);
    res.status(value === null ? 404 : 200).json({ data: { [key]: value } });
  } catch (err) {
    next(err);
  }
});

app.post("/redis", async (req, res, next) => {
  try {
    if (Object.keys(req.body).length === 0) {
      res.status(400).json({ error: "at least one key is required in body" });
      return;
    }

    const setPromises = [];
    for (const key in req.body) {
      setPromises.push(redisClient.set(key, req.body[key]));
    }

    await Promise.all(setPromises);
    res.sendStatus(201);
  } catch (err) {
    next(err);
  }
});

app.get("/users", async (req, res) => {
  try {
    const users = await User.find({}, { __v: 0 });
    console.log(users);
    res.send({ data: users });
  } catch (err) {
    next(err);
  }
});

app.delete("/users/:name", async (req, res, err) => {
  try {
    const { name } = req.params;
    console.log(name);
    console.log(await User.deleteOne({ name }));
    res.sendStatus(200);
  } catch (err) {
    next(err);
  }
});

app.post("/users", async (req, res) => {
  try {
    const { name, age } = req.body;
    await new User({ name, age }).save();
    res.sendStatus(201);
  } catch (err) {
    next(err);
  }
});

app.use((req, res, next) => {
  res.status(404).json({ error: `cannot ${req.method} ${req.url}` });
});

app.use((err, req, res, next) => {
  console.log(err.message);
  res.status(502).json({ error: "internal server error" });
});

try {
  const { MONGO_HOST, MONGO_PORT, MONGO_DB, MONGO_USERNAME, MONGO_PASSWORD } = process.env;
  await mongoose.connect(`mongodb://${MONGO_USERNAME}:${MONGO_PASSWORD}@${MONGO_HOST}:${MONGO_PORT}/${MONGO_DB}`);
  console.log("db connected");

  const { REDIS_HOST, REDIS_PORT } = process.env;
  redisClient = redis.createClient({ url: `redis://${REDIS_HOST}:${REDIS_PORT}` });
  redisClient.on("error", (err) => console.error("Redis Client Error", err));
  await redisClient.connect();
  console.log("redis connected");

  const PORT = process.env.PORT ?? 3000;
  app.listen(PORT, () => console.log(`server running on port ${PORT}...`));
} catch (err) {
  console.error(err.message);
  process.exit(1);
}
