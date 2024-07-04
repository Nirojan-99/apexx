const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const fs = require("fs");
const UserModel = require("../Model/UserModel");

//user register
exports.Register = (req, res) => {
  //incomming data
  let { name, email, mobile_number, password, role, NIC, gender,address } = req.body;
console.log(req.body)
  //encrypt
  bcrypt.hash(password, 12, (err, hash) => {
    password = hash;

    const newUser = new UserModel({
      name,
      email,
      mobile_number,
      password,
      address,
      role,
      NIC,
      gender,
    });

    newUser
      .save()
      .then((data) => {
        if (data._id) {
          //generate token
          const token = jwt.sign(
            { userID: data._id, email: data.email },
            "rpmtvalidation",
            { expiresIn: "2h" }
          );
          return res
            .status(200)
            .json({ added: true, token, _id: data._id });
        } else {
          return res.status(404).json({ added: false });
        }
      })
      .catch((er) => {
        return res.status(404).json({ added: false });
      });
  });
};

//user login
exports.Login = (req, res) => {
  //incomming data
  const { email, password } = req.body;
  

  UserModel.findOne({ email }, { email: 1, password: 1 })
    .then((data) => {

      //compare password
      if (data._id) {
        const result = bcrypt.compareSync(password, data.password);
        
        if (result) {
          //generate token
          const token = jwt.sign(
            { userID: data._id, email: data.email },
            "rpmtvalidation",
            { expiresIn: "2h" }
          );
          
          return res
            .status(200)
            .json({ auth: true, token,  _id: data._id });
        }
      } else {
        return res.status(404).json({ auth: false });
      }
    })
    .catch((er) => {
      return res.status(404).json({ auth: false });
    });
};

//get single user data
exports.GetUser = (req, res) => {
  //incomming data
  const { _id } = req.params;

  UserModel.findById({ _id }, { password: 0 })
    .then((data) => {
      return res.status(200).json(data._doc);
    })
    .catch((er) => {
      return res.status(404).json({ fetched: false });
    });
};


//update dp
exports.UpdateDp = (req, res) => {
  //coming data
  const { _id } = req.params;
  const date = Date.now();

  console.log(req)
  if (req.files) {
    let fileToUpload = req.files.dp;
    const fileName = _id + date + fileToUpload.name;

    UserModel.findById({ _id }, { dp: 1 }).then((data) => {
      if (data.dp) {
        const path = data.dp.split(process.env.URL)[1];
        fs.unlink(path, (er) => {
          if (er) {
            console.log(er);
          }
        });
      }
      //add new
      fileToUpload.mv("Uploads/" + fileName, (error) => {
        if (error) {
          console.log(error);
          return res.status(404).json({ updated: false });
        } else {
          const link = `${process.env.URL}Uploads/` + fileName;
          UserModel.findByIdAndUpdate({ _id }, { dp: link })
            .then((data) => {
              return res.status(200).json({ updated: true });
            })
            .catch((er) => {
              return res.status(404).json({ updated: false });
            });
        }
      });
    });
  } else {
    return res.status(404).json({ updated: false });
  }
};


//update user
exports.UpdateUser = (req, res) => {
  //incomming data
  const { _id } = req.params;
  const {
    name,
    mobile_number,
    password,
    NIC,
    gender,
    bio,
    address,
    DOB,
  } = req.body;

  if (password) {
    const password = bcrypt.hashSync(password, 12);
  }

  UserModel.findByIdAndUpdate(
    { _id },
    { name, mobile_number, password, NIC, gender, bio, address, DOB }
  )
    .then((data) => {
      return res.status(200).json({ updated: true });
    })
    .catch((er) => {
      return res.status(404).json({ updated: false });
    });
};