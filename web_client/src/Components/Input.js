import { TextField } from "@mui/material";

function Input(props) {
  return (
    <>
      <TextField
        helperText={props.helperText}
        onFocus={() => {
          props?.onFocus && props.onFocus();
        }}
        autoFocus={props.autoFocus}
        size={props.size}
        fullWidth
        value={props.value}
        onChange={(event) => {
          props.set(event.target.value);
        }}
        error={props.error}
        id={props.id}
        label={props.label}
        variant="outlined"
        type={props.type}
        inputProps={{ style: { color: "#508D4E", fontWeight: "500" } }}
        InputLabelProps={{ style: {} }}
        color="info"
        disabled={props.disabled}
        maxRows={props.maxRows}
        minRows={props.minRows}
        multiline={!!props.minRows}
        required
        sx={{
          mb: 1,
          '& .MuiOutlinedInput-root.Mui-focused .MuiOutlinedInput-notchedOutline': {
            borderColor: '#508D4E',
          },
          ...props.sx,
        }}
        hidden={props.hidden}
        placeholder={props.placeholder}
      />
    </>
  );
}

export default Input;
