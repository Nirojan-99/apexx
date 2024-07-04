import { Box, MenuItem, Paper, Select, Typography } from "@mui/material";
import { Container } from "@mui/system";
import ButtonA from "../Components/ButtonA";
import Input from "../Components/Input";
import Label from "../Components/Label";
import { login } from "../Store/auth";
import { useDispatch } from "react-redux";
import { useNavigate } from "react-router-dom";
import { useState } from "react";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";
import PasswordStrengthBar from "react-password-strength-bar";
import { validateEmail } from "../Utils/EmailUtils";
import { validatePassword } from "../Utils/PasswordUtils";

function SignUp() {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [cpassword, setCPassword] = useState("");
  const [contactNo, setContactNo] = useState("");
  const [address, setAddress] = useState("");
  const [gender, setGender] = useState();
  const [dob, setDob] = useState("");

  const dispatch = useDispatch();
  const navigate = useNavigate();

  const [error, setError] = useState(false);

  const OnSubmitHandler = () => {
    setError(false);
    //validation
    if (!name.trim() || name.length < 2) {
      toast("Enter valid Name", { type: "error" });
      return setError(true);
    }
    if (!email.trim() || !validateEmail(email)) {
      toast("Enter valid Email", { type: "error" });
      return setError(true);
    }
    if (!password.trim() || !validatePassword(password)) {
      toast("Enter valid Password", { type: "error" });
      return setError(true);
    }
    if (!cpassword.trim() || !(cpassword == password)) {
      toast("Please check confirm password", { type: "error" });
      return setError(true);
    }
    if (!contactNo.trim() || contactNo.length < 8) {
      toast("Enter valid Contact Number", { type: "error" });
      return setError(true);
    }
    if (!address.trim() || address.length < 3) {
      toast("Enter valid Address", { type: "error" });
      return setError(true);
    }
    if (!gender.trim() || gender.length < 3) {
      toast("Select a Gender", { type: "error" });
      return setError(true);
    }
    if (!dob.trim()) {
      toast("Enter valid Date of birth", { type: "error" });
      return setError(true);
    }
    const data = {
      name: name,
      email: email,
      password: password,
      mobile_number: contactNo,
      address: address,
      gender: gender,
      DOB: dob,
    };
    axios
      .post(`http://localhost:5000/api/v1/users`, data)
      .then((res) => {
        console.log(res)
        dispatch(
          login({
            userID: res.data._id,
            token: res.data.token,
          })
        );
        setTimeout(() => {
          toast(res.data.msg, { type: "success" });
        }, 1000);

        setTimeout(() => {
          navigate("/account");
        }, 2000);
      })

      .catch((er) => {
        toast(er.response.data.msg, { type: "error" });
      });
  };

  return (
    <>
      <Box>
        <ToastContainer />
        <Container maxWidth="sm">
          {/* title */}

          <Box component={Paper} sx={{ bgcolor: "#fff" }} p={3} my={2.5}>
            {/* title */}
            <Typography
              sx={{
                fontFamily: "open sans",
                fontWeight: "1000",
                color: "#2B4865",
                letterSpacing: -0.9,
                fontSize: 20,
                my: 1,
                textAlign: "center",
              }}
            >
              Register
            </Typography>
            {/* user name */}
            <Label title="UserName" for="uname" />
            <Input
              id="uname"
              autoFocus={true}
              size="small"
              type="text"
              value={name}
              set={setName}
            />
            {/* Email */}
            <Label title="Email" for="email" />
            <Input
              id="email"
              size="small"
              placeholder="xxxxxx@gmail.com"
              type="text"
              value={email}
              set={setEmail}
            />
            {/* Password */}
            <Label for="password" title="Password" />
            <Input
              id="password"
              type="password"
              size="small"
              value={password}
              set={setPassword}
            />
            <PasswordStrengthBar password={password} />
            {/* Confirm Password */}
            <Label for="re_password" title="Confirm Password" />
            <Input
              id="re_password"
              type="password"
              size="small"
              value={cpassword}
              set={setCPassword}
            />
            {/* contact number */}
            <Label title="Contact Number" for="contact_number" />
            <Input
              id="contact_number"
              size="small"
              placeholder="07xxxxxxxx"
              type="number"
              value={contactNo}
              set={setContactNo}
            />
            {/* address */}
            <Label for="address" title="Address" />
            <Input
              id="address"
              multiple={true}
              minRows={3}
              maxRows={4}
              type="text"
              size="small"
              value={address}
              set={setAddress}
            />
            {/* gender */}
            <Label title="Gender" for="gender" />
            <Select
              sx={{ mb: 1, color: "#1597BB", fontWeight: "500" }}
              fullWidth
              required
              size="small"
              color="info"
              id="gender"
              value={gender}
              // set={setGender}
              onChange={(event) => setGender(event.target.value)}
            >
              <MenuItem value={"male"}>Male</MenuItem>
              <MenuItem value={"female"}>Female</MenuItem>
            </Select>
            {/* dob */}
            <Label title="Date of Birth" for="dob" />
            <Input id="dob" size="small" type="date" value={dob} set={setDob} />

            {/* save button */}
            <Box mt={2} />
            <ButtonA
              fullWidth={true}
              title="REGISTER"
              handler={OnSubmitHandler}
            />
            <Box mt={2} />
          </Box>
        </Container>
      </Box>
    </>
  );
}

export default SignUp;
