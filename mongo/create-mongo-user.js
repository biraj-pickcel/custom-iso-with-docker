db = new Mongo().getDB(process.env.MONGO_DB);
db.createUser({
  user: process.env.MONGO_USERNAME,
  pwd: process.env.MONGO_PASSWORD,
  roles: [
    {
      role: "dbOwner",
      db: process.env.MONGO_DB,
    },
  ],
});
