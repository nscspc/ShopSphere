import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopsphere/common/custom_grey_textfield.dart';
import 'package:shopsphere/common/rounded_button.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:shopsphere/features/auth/services/auth_service.dart';

enum Auth // to keep track of radio button
{ signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = 'auth-screen';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signin;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool signinLoader = false;
  bool signupLoader = false;
  // final AuthService authService = AuthService();

  @override
  void dispose() {
    // dispose all the controllers so that we don't have any memory leaks.
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signInUser() async {
    setState(() {
      signinLoader = true;
    });
    await authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
    setState(() {
      signinLoader = false;
    });
  }

  void signUpUser() async {
    setState(() {
      signupLoader = true;
    });
    await authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
    setState(() {
      signupLoader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Text(
                //   'Welcome',
                //   style: TextStyle(
                //     fontSize: 22,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),

                ListTile(
                  // tileColor: _auth == Auth.signin
                  //     ? GlobalVariables.backgroundColor
                  //     : GlobalVariables.greyBackgroundCOlor,
                  title: const Text(
                    'Sign-In.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.blackThemeColor,
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),

                if (_auth == Auth.signin)
                  Column(
                    children: [
                      Lottie.asset(
                          'assets/lottie_animations/login_lottie.json'),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: GlobalVariables.backgroundColor,
                        child: Form(
                          key: _signInFormKey,
                          child: Column(
                            children: [
                              CustomGreyTextField(
                                controller:
                                    _emailController, // we have used the same controllers in both signup and signin because if the user selects the sign in option in between signup then the information filled up by the user in signup block will come into signin block.
                                hintText: 'Email',
                              ),
                              const SizedBox(height: 10),
                              CustomGreyTextField(
                                controller: _passwordController,
                                hintText: 'Password',
                              ),
                              const SizedBox(height: 15),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Forgot Password ? ",
                                  style: TextStyle(
                                      color: GlobalVariables.darkGrey),
                                ),
                              ),
                              const SizedBox(height: 15),
                              RoundedButton(
                                text: 'Sign In',
                                loader: signinLoader,
                                loaderColor: GlobalVariables.backgroundColor,
                                onTap: () {
                                  if (_signInFormKey.currentState!.validate()) {
                                    signInUser();
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: _auth == Auth.signup ? 0 : 10,
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // tileColor: _auth == Auth.signup
                  //     ? GlobalVariables.backgroundColor
                  //     : GlobalVariables.greyBackgroundCOlor,
                  title: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.blackThemeColor,
                    value: Auth.signup,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),

                if (_auth == Auth.signup)
                  Column(
                    children: [
                      Lottie.asset(
                          'assets/lottie_animations/signup_lottie.json'),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: GlobalVariables.backgroundColor,
                        child: Form(
                          key: _signUpFormKey,
                          child: Column(
                            children: [
                              CustomGreyTextField(
                                controller: _nameController,
                                hintText: 'Name',
                              ),
                              const SizedBox(
                                  height:
                                      10), // as the sizedbox is const so it will not rebuild again and again which will improve the performance.
                              CustomGreyTextField(
                                controller: _emailController,
                                hintText: 'Email',
                              ),
                              const SizedBox(height: 10),
                              CustomGreyTextField(
                                controller: _passwordController,
                                hintText: 'Password',
                              ),
                              const SizedBox(height: 25),
                              RoundedButton(
                                text: 'Sign Up',
                                loader: signupLoader,
                                loaderColor: GlobalVariables.backgroundColor,
                                onTap: () {
                                  if (_signUpFormKey.currentState!.validate()) {
                                    signUpUser();
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
