// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/routes.dart';
import '../progress_hud.dart';
import '../models/login_model.dart';
import '../utils/validators.dart' as valid;
import '../static_data/getuser_data.dart' as data;
import '../static_data/login_data.dart' as loginData;

/*

get email and password from user
hit api with these
get refresh and access token
store in shared_prefs

*/

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _isApiCallInProgress = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: _isApiCallInProgress,
      opacity: 0.3,
      child: _uiSetup(context),
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          // padding: const EdgeInsets.only(left: 35, top: 130),
          height: MediaQuery.of(context).size.height * 1.0,
          width: MediaQuery.of(context).size.width * 1.0,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.blue, Color.fromARGB(255, 255, 255, 255)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          )),
          // child: Image.asset(
          //   "images/log_img.png",
          // )
        ),
        SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image.asset(
              "images/teacher_logo.png",
            ),
            const SizedBox(height: 50),
            Container(
              margin: const EdgeInsets.only(left: 35, right: 35),
              child: Form(
                key: _formkey,
                child: Column(children: [
                  TextFormField(
                    controller: _emailCtrl,
                    validator: valid.isEmail,
                    style: const TextStyle(color: Colors.black),
                    autocorrect: false,
                    decoration: _getDecor('Email'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: valid.isShort,
                    controller: _passCtrl,
                    autocorrect: false,
                    obscureText: true,
                    decoration: _getDecor('Password'),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: 27, fontWeight: FontWeight.w700),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xff4c505b),
                        child: IconButton(
                            color: Colors.white,
                            onPressed: loginCallback,
                            icon: const Icon(
                              Icons.arrow_forward,
                            )),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(registerRoute);
                          },
                          child: const Text(
                            'Don\'t have an account? Sign Up',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xff4c505b),
                                fontSize: 18),
                          ),
                        ),
                      ]),
                ]),
              ),
            ),
          ]),
        ),
      ]),
    );
  }

  void loginCallback() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isApiCallInProgress = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _isApiCallInProgress = false;
      });
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('access', loginData.access);
      sharedPreferences.setString('refresh', loginData.refresh);
      _setUserDetails(loginData.access, sharedPreferences);

      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Login Successful')));
      Navigator.of(context)
          .pushNamedAndRemoveUntil(mainpageRoute, (route) => false);
    }
  }

  void _setUserDetails(
      String accessToken, SharedPreferences sharedPreferences) {
    sharedPreferences.setString('name', data.user.name ?? "null");
    sharedPreferences.setInt('contact', data.user.contact!);
    sharedPreferences.setString('email', data.user.email ?? "null");
    sharedPreferences.setString('teacher_id', data.user.teacherId ?? "null");
  }

  static InputDecoration _getDecor(String label) {
    return InputDecoration(
        fillColor: const Color.fromARGB(249, 245, 245, 245),
        filled: true,
        hintText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ));
  }
}
