import 'package:apexx/Components/C_DropDown.dart';
import 'package:flutter/material.dart';
import 'package:apexx/Model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:apexx/Service/UserService.dart';
import 'package:apexx/Components/C_Label.dart';
import 'package:apexx/Components/C_Button.dart';
import 'package:apexx/Components/C_Error_Message.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AppBar _appBar = AppBar(
    title: const Text("Register"),
  );

  // Error messages
  String userNameErrorText = "";
  String emailErrorText = "";
  String passwordErrorText = "";
  String confirmPasswordErrorText = "";
  String contactNumberErrorText = "";
  String addressErrorText = "";
  String genderErrorText = "";
  String dateOfBirthErrorText = "";
  double invalidRegisterHeight = 0;

  // Controllers
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final contactNumberController = TextEditingController();
  final addressController = TextEditingController();
  final genderController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  // Register handler
  register() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      invalidRegisterHeight = 0;
      userNameErrorText = "";
      emailErrorText = "";
      passwordErrorText = "";
      confirmPasswordErrorText = "";
      contactNumberErrorText = "";
      addressErrorText = "";
      genderErrorText = "";
      dateOfBirthErrorText = "";
    });

    bool validateEmail(String email) {
      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
      return emailRegex.hasMatch(email);
    }

    bool validatePassword(String password) {
      return password.length >= 6;
    }

    // Validation
    if (userNameController.text.trim().isEmpty ||
        userNameController.text.length < 2) {
      setState(() {
        userNameErrorText = "Enter valid Name";
      });
      return;
    }
    if (!validateEmail(emailController.text)) {
      setState(() {
        emailErrorText = "Enter valid Email";
      });
      return;
    }
    if (!validatePassword(passwordController.text)) {
      setState(() {
        passwordErrorText = "Enter valid Password";
      });
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        confirmPasswordErrorText = "Passwords do not match";
      });
      return;
    }
    if (contactNumberController.text.trim().isEmpty ||
        contactNumberController.text.length < 8) {
      setState(() {
        contactNumberErrorText = "Enter valid Contact Number";
      });
      return;
    }
    if (addressController.text.trim().isEmpty ||
        addressController.text.length < 3) {
      setState(() {
        addressErrorText = "Enter valid Address";
      });
      return;
    }
    if (genderController.text.trim().isEmpty ||
        genderController.text.length < 3) {
      setState(() {
        genderErrorText = "Select a Gender";
      });
      return;
    }
    if (dateOfBirthController.text.trim().isEmpty) {
      setState(() {
        dateOfBirthErrorText = "Enter valid Date of Birth";
      });
      return;
    }

    // API call for registration
   Map<String, dynamic>? res = await registerService(
      "users",
      userNameController.text,
      emailController.text,
      passwordController.text,
      contactNumberController.text,
      addressController.text,
      genderController.text,
      dateOfBirthController.text,
    );

    if (res != null) {
      await prefs.setString('token', res["token"]);
      await prefs.setString('userID', res["_id"]);
      Navigator.pushReplacementNamed(context, "/account");
    } else {
      setState(() {
        invalidRegisterHeight = 20;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height -
        _appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: _appBar,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CLabel("User Name"),
              TextField(
                autocorrect: false,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "open sans",
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                controller: userNameController,
                cursorColor: Colors.white,
                maxLines: 1,
                decoration: InputDecoration(
                    errorStyle: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w700),
                    errorText:
                        userNameErrorText != "" ? userNameErrorText : null,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff4b576f),
                    filled: true),
              ),
              SizedBox(height: height * 0.02),
              CLabel("Email"),
              TextField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "open sans",
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                controller: emailController,
                cursorColor: Colors.white,
                maxLines: 1,
                decoration: InputDecoration(
                    errorStyle: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w700),
                    errorText: emailErrorText != "" ? emailErrorText : null,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff4b576f),
                    filled: true),
              ),
              SizedBox(height: height * 0.02),
              CLabel("Password"),
              TextField(
                autocorrect: false,
                obscureText: true,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "open sans",
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                controller: passwordController,
                cursorColor: Colors.white,
                maxLines: 1,
                decoration: InputDecoration(
                    errorStyle: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w700),
                    errorText:
                        passwordErrorText != "" ? passwordErrorText : null,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff4b576f),
                    filled: true),
              ),
              SizedBox(height: height * 0.02),
              CLabel("Confirm Password"),
              TextField(
                autocorrect: false,
                obscureText: true,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "open sans",
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                controller: confirmPasswordController,
                cursorColor: Colors.white,
                maxLines: 1,
                decoration: InputDecoration(
                    errorStyle: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w700),
                    errorText: confirmPasswordErrorText != ""
                        ? confirmPasswordErrorText
                        : null,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff4b576f),
                    filled: true),
              ),
              SizedBox(height: height * 0.02),
              CLabel("Contact Number"),
              TextField(
                autocorrect: false,
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "open sans",
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                controller: contactNumberController,
                cursorColor: Colors.white,
                maxLines: 1,
                decoration: InputDecoration(
                    errorStyle: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w700),
                    errorText: contactNumberErrorText != ""
                        ? contactNumberErrorText
                        : null,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff4b576f),
                    filled: true),
              ),
              SizedBox(height: height * 0.02),
              CLabel("Address"),
              TextField(
                autocorrect: false,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "open sans",
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                controller: addressController,
                cursorColor: Colors.white,
                maxLines: 1,
                decoration: InputDecoration(
                    errorStyle: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w700),
                    errorText: addressErrorText != "" ? addressErrorText : null,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff4b576f),
                    filled: true),
              ),
              SizedBox(height: height * 0.02),
              CLabel("Gender"),
              CDropDown(const ["Male", "Female"]),
              SizedBox(height: height * 0.02),
              CLabel("Date of Birth(YYYY/MM/DD)"),
              TextField(
                autocorrect: false,
                keyboardType: TextInputType.datetime,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "open sans",
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                controller: dateOfBirthController,
                cursorColor: Colors.white,
                maxLines: 1,
                decoration: InputDecoration(
                    errorStyle: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w700),
                    errorText: dateOfBirthErrorText != ""
                        ? dateOfBirthErrorText
                        : null,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff4b576f),
                    filled: true),
              ),
              ErrorMessage(invalidRegisterHeight, "Registration Failed"),
              SizedBox(height: height * 0.04),
              CButton("Register", register),
            ],
          ),
        ),
      ),
    );
  }
}
