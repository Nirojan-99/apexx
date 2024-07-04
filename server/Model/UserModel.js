const mongoose = require("mongoose");

const userSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
      trim: true,
    },
    email: {
      type: String,
      required: true,
      unique: true,
      trim: true,
    },
    password: {
      type: String,
      required: true,
      trim: true,
    },
    mobile_number: {
      type: Number,
      required: true,
      unique: true,
    },
    gender: {
      type: String,
      required: true,
    },
    address: {
      type: String,
      default: "",
    },
    bio: {
      type: String,
      default: "",
    },
    dp: {
      type: String,
      default: "",
    },
    DOB: {
      type: String,
      default: "",
    },
    OTP: {
      type: Number,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("Users", userSchema);