import { Box } from "@mui/material";

function Label(props) {
  return (
    <Box mb={1}>
      <label
        style={{
          fontFamily: "open sans",
          fontWeight: "800",
          fontSize: 13,
          color: "#1A374D",
        }}
        htmlFor={props.for}
      >
        {props.title}
      </label>
    </Box>
  );
}

export default Label;
