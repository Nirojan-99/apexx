const Router = require("express").Router;
const router = Router();
const fileUpload = require("express-fileupload");
const UserCtrl = require("../Controller/UserController");
const auth = require("../Middleware/auth");

router.use(fileUpload());

//login
router.post("/auth", UserCtrl.Login);

//single user
router
  .route("/:_id")
  .get(auth, UserCtrl.GetUser)
  .put(auth, UserCtrl.UpdateUser);

//dp route
router.route("/dp/:_id").put(auth, UserCtrl.UpdateDp);

//register
router.route("/").post(UserCtrl.Register);

module.exports = router;
