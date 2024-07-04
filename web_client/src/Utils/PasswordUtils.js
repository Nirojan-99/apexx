function validatePassword(password) {
  const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$/;
  return passwordPattern.test(password);
}

export { validatePassword };
