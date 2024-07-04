import React, { useEffect, useState } from "react";
import {
  Box,
  Button,
  Card,
  CardContent,
  Grid,
  TextField,
  Typography,
} from "@mui/material";
import { styled } from "@mui/system";
import { useSelector } from "react-redux";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";

function Account() {
  const [profilePic, setProfilePic] = useState(null);
  const [username, setUsername] = useState("");
  const [email, setEmail] = useState("");
  const [bio, setBio] = useState("");

  const handleProfilePicChange = (event) => {
    if (event.target.files && event.target.files[0]) {
      setProfilePic(URL.createObjectURL(event.target.files[0]));

      const data = new FormData();
      data.append("dp", event.target.files[0]);

      axios
        .put(
          `http://localhost:5000/api/v1/users/dp/${userID}`,
           data ,
          {
            headers: {
              Authorization: "verify " + token,
            },
          }
        )
        .then((res) => {
          setBio(res.data.bio);
          toast("Updated", { type: "info" });
        })

        .catch((er) => {
          toast("Try again" + er, { type: "error" });
        });
    }
  };

  const { token, userID } = useSelector((state) => state.loging);

  useEffect(() => {
    axios
      .get(`http://localhost:5000/api/v1/users/${userID}`, {
        headers: {
          Authorization: "verify " + token,
        },
      })
      .then((res) => {
        setUsername(res.data.name);
        setEmail(res.data.email);
        setBio(res.data.bio);
        setProfilePic(res.data.dp);
      })

      .catch((er) => {
        toast("reload please", { type: "error" });
      });
  }, []);

  const ProfileImage = styled("div")(({ image }) => ({
    position: "relative",
    width: "100%",
    paddingBottom: "100%",
    backgroundImage: `url(${image})`,
    backgroundSize: "cover",
    backgroundPosition: "center",
    borderRadius: "2%",
  }));

  const updateBio = () => {
    axios
      .put(
        `http://localhost:5000/api/v1/users/${userID}`,
        { bio: bio },
        {
          headers: {
            Authorization: "verify " + token,
          },
        }
      )
      .then((res) => {
        setBio(res.data.bio);
        toast("Updated", { type: "info" });
      })

      .catch((er) => {
        toast("Try again", { type: "error" });
      });
  };

  const uploadDp = (file) => {};

  return (
    <Box mt={4} px={{ md: 10, xs: 1 }}>
      <ToastContainer />
      <Card>
        <CardContent>
          <Grid container spacing={2} alignItems="center">
            <Grid item xs={12} sm={4}>
              <ProfileImage
                image={profilePic || "https://via.placeholder.com/1080"}
              />
              <Button
                variant="contained"
                component="label"
                fullWidth
                sx={{ mt: 2 }}
              >
                Upload Picture
                <input
                  type="file"
                  hidden
                  accept="image/*"
                  onChange={handleProfilePicChange}
                />
              </Button>
            </Grid>
            <Grid item xs={12} sm={8}>
              <Typography
                variant="h5"
                sx={{ fontFamily: "open sans", fontWeight: 700 }}
              >
                User Details
              </Typography>
              <TextField
                fullWidth
                label="Username"
                margin="normal"
                disabled
                value={username}
                onChange={(e) => setUsername(e.target.value)}
              />
              <TextField
                fullWidth
                label="Email"
                margin="normal"
                value={email}
                disabled
                onChange={(e) => setEmail(e.target.value)}
              />
              <TextField
                fullWidth
                label="Bio"
                margin="normal"
                multiline
                rows={4}
                value={bio}
                onChange={(e) => setBio(e.target.value)}
              />
              <Button
                variant="outlined"
                component="label"
                fullWidth
                onClick={updateBio}
                sx={{ mt: 2, fontWeight: 700 }}
              >
                Update Bio
              </Button>
            </Grid>
          </Grid>
        </CardContent>
      </Card>
    </Box>
  );
}

export default Account;
