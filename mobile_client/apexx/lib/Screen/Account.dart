import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:apexx/Components/C_Button.dart';
import 'package:apexx/Service/UserService.dart';
import 'dart:convert';
import 'package:apexx/Util/env.dart';
import 'package:apexx/Util/env.dart';

import 'package:http/http.dart' as http;

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? _profilePicUrl; // URL of the profile picture
  File? _profilePic;
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Fetch user details when screen loads
    getDetails();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profilePicUrl = null;
        _profilePic = File(pickedFile.path);
      });

      var prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");
      String? userID = prefs.getString("userID");

      try {
        var request = http.MultipartRequest(
          'PUT',
          Uri.parse('${URI}users/dp/$userID'),
        );
        request.files
            .add(await http.MultipartFile.fromPath('dp', pickedFile.path));
        request.headers['Authorization'] = 'verify $token';
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);
      } catch (e) {
        print('Error updating profile picture: $e');
      }
    }
  }

  Future<void> getDetails() async {
    var prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");
    String? userID = prefs.getString("userID");

    Map<String, dynamic>? data = await getUserService("users/$userID", token);
    if (data != null) {
      setState(() {
        _usernameController.text = data['name'];
        _emailController.text = data['email'];
        _bioController.text = data['bio'];
        _profilePicUrl = data['dp'].replaceFirst(
          "localhost",
          IP,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _profilePic != null
                      ? FileImage(_profilePic!)
                      : _profilePicUrl != null
                          ? NetworkImage(_profilePicUrl!)
                          : const AssetImage('assets/1080.png')
                              as ImageProvider,
                  child: _profilePic == null
                      ? const Icon(
                          Icons.camera_alt,
                          size: 50,
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 10),
              CButton("Upload Picture", _pickImage),
              const SizedBox(height: 20),
              const Text(
                'User Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                enabled: false,
                controller: _usernameController,
                autocorrect: false,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "open sans",
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                cursorColor: Colors.white,
                maxLines: 1,
                decoration: InputDecoration(
                    labelText: 'User Name',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff4b576f),
                    filled: true),
              ),
              const SizedBox(height: 10),
              TextField(
                enabled: false,
                controller: _emailController,
                autocorrect: false,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "open sans",
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                cursorColor: Colors.white,
                maxLines: 1,
                decoration: InputDecoration(
                    labelText: 'Email',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff4b576f),
                    filled: true),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _bioController,
                maxLines: 4,
                enabled: true,
                autocorrect: false,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "open sans",
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    labelText: 'Bio',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff4b576f),
                    filled: true),
              ),
              const SizedBox(height: 10),
              CButton("Update Bio", () {}),
            ],
          ),
        ),
      ),
    );
  }
}
