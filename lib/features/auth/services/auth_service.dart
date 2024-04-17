// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopsphere/common/animated_bottom_bar.dart';
import 'package:shopsphere/constants/error_handling.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:shopsphere/constants/utils.dart';
import 'package:shopsphere/features/admin/screens/admin_screen.dart';
import 'package:shopsphere/models/user.dart';
import 'package:shopsphere/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // sign up user
  Future<String> signUpUser({
    //function
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
        cart: [],
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          // the headers are added because this -> app.use(express.json()); is used in index.js
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      print(res.statusCode);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
      return "success";
    } catch (e) // catch block is to catch the error send in the res from server as try will not catch the error it will take the res if there is no error.
    {
      showSnackBar(context, e.toString());
    }
    return "error";
  }

  // sign in user
  Future<String> signInUser(
      {
      //function
      required BuildContext context,
      required String email,
      required String password}) async {
    try {
      // User user = User(
      //     id: '',
      //     name: '',
      //     email: email,
      //     password: password,
      //     address: '',
      //     type: '',
      //     token: '');

      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode(
          {
            'email': email,
            'password': password,
          },
        ),
        headers: <String, String>{
          // the headers are added because this -> app.use(express.json()); is used in index.js
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      print(res.statusCode);
      print(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res
              .body); // if we are outside the build function then we have to set lister:false.
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);

          Provider.of<UserProvider>(context, listen: false).user.type == 'user'
              ? Navigator.pushNamedAndRemoveUntil(
                  context, AnimatedBottomBar.routeName, (route) => false)
              : Navigator.pushNamedAndRemoveUntil(
                  context, AdminScreen.routeName, (route) => false);
          // Navigator.pushNamedAndRemoveUntil(
          //     context, BottomBar.routeName, (route) => false);

          showSnackBar(
            context,
            'Logged In',
          );
        },
      );

      return "success";
    } catch (e) // catch block is to catch the error send in the res from server as try will not catch the error it will take the res if there is no error.
    {
      showSnackBar(context, e.toString());
    }
    return "error";
  }

  // get user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        // get user data
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) // catch block is to catch the error send in the res from server as try will not catch the error it will take the res if there is no error.
    {
      showSnackBar(context, e.toString());
    }
  }
}
