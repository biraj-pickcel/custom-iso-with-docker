import mongoose from "mongoose";

const schema = new mongoose.Schema({
  name: String,
  age: Number,
});

const User = mongoose.model("User", schema);

export default User;
