import React from "react";
import ReactDOM from "react-dom/client";
import "./index.css";
import App from "./App";

import { ThemeProvider, createTheme } from "@mui/material/styles";
import { Provider } from "react-redux";
import store from "./Store";
import 'react-toastify/dist/ReactToastify.css';

//theme data
let theme1 = createTheme({
  typography: {
    mode: "light",
    primary: {
      main: "#508D4E",
    },
  },
  palette: {
    mode: "light",

    primary: {
      main: "#508D4E",
      button: "#80AF81",
    },
    status: {
      main: "#ddd",
    },
    background: {
      default: "#508D4E",
      paper: "#fff",
      button: "#80AF81",
    },
    divider: "#508D4E",
    secondary: {
      main: "#80AF81",
    },
    text: {
      primary: "#508D4E",
      secondary: "#fff",
    },
    success: {
      main: "#FEC260",
    },
    info: {
      main: "#1597BB",
    },
    error: {
      main: "#FF0000",
    },
  },
});

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <React.StrictMode>
    <ThemeProvider theme={theme1}>
      <Provider store={store}>
        <App />
      </Provider>
    </ThemeProvider>
  </React.StrictMode>
);
