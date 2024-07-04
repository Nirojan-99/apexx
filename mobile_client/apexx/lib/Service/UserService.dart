import 'package:apexx/Model/User.dart';
import 'package:apexx/Util/env.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String? _URI = URI;

Future<Map<String, dynamic>?> loginService(path, email, password) async {
  var response = await http.post(Uri.parse('$_URI$path'),
      body: {"email": email, "password": password});
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return null;
  }
}

Future<Map<String, dynamic>?> getUserService(path, token) async {
  var response = await http.get(Uri.parse('$_URI$path'),
      headers: {"Authorization": "test " + token});
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return null;
  }
}

Future<Map<String, dynamic>?> registerService(
  path,
  userName,
  email,
  password,
  contactNumber,
  address,
  gender,
  dateOfBirth,
) async {
  var response = await http.post(Uri.parse('$_URI$path'), body: {
    "email": email,
    "password": password,
    "name": userName,
    "mobile_number": contactNumber,
    "address": address,
    "gender": gender,
    "DOB": dateOfBirth
  });
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return null;
  }
}
