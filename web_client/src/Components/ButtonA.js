import { Button, Typography } from "@mui/material";

function ButtonA(props) {
  return (
    <>
      <Button
        fullWidth={props.fullWidth}
        disabled={props.disabled}
        color="secondary"
        variant="contained"
        disableElevation
        onClick={() => {
          props.handler();
        }}
        sx={{ my: 1 }}
      >
        <Typography
          sx={{
            letterSpacing: 1.5,
            fontWeight: "700",
            fontFamily: "open sans",
            textTransform: "none",
          }}
        >
          {props.title}
        </Typography>
      </Button>
    </>
  );
}

export default ButtonA;
