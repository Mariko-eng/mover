import 'package:bus_stop/views/main/home_view.dart';
import 'package:bus_stop/views/v3/auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:bus_stop/controllers/authController.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String countryCde = "";
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController1 = TextEditingController();
  final _passwordController2 = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    UserProvider _userProvider = Provider.of<UserProvider>(context);

    final statusHeight = MediaQuery.of(context).padding.top;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: KeyboardDismisser(
        gestures: [
          GestureType.onTap,
          GestureType.onVerticalDragDown,
          GestureType.onPanUpdateDownDirection,
        ],
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: statusHeight + 20,
                  ),
                  Text(
                    "Create Account",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium!.copyWith(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Register with your username or phone number \n and password to get started.",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium!
                        .copyWith(fontSize: 17, color: Colors.grey[900]),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Username or Phone number",
                            style: textTheme.bodyMedium!
                                .copyWith(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _usernameController,
                              minLines: 1,
                              maxLines: 1,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter input",
                                hintStyle: TextStyle(fontSize: 12),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Email Address",
                            style: textTheme.bodyMedium!
                                .copyWith(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _emailController,
                              minLines: 1,
                              maxLines: 1,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter email",
                                hintStyle: TextStyle(fontSize: 12),
                              ),
                              validator: (String? val) {
                                final bool isValid =
                                    EmailValidator.validate(val!.trim());
                                if (isValid == false) {
                                  return "Enter Valid Email Address";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Password",
                            style: textTheme.bodyMedium!
                                .copyWith(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _passwordController1,
                              minLines: 1,
                              maxLines: 1,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter password",
                                  hintStyle: TextStyle(fontSize: 12),
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                      child: Icon(Icons.visibility))
                              ),
                              validator: (value) {
                                if (value == null || value.length < 7) {
                                  return 'Required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Password must be more than 8 characters.",
                            style: textTheme.bodyMedium!
                                .copyWith(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Confirm Password",
                            style: textTheme.bodyMedium!
                                .copyWith(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _passwordController2,
                              minLines: 1,
                              maxLines: 1,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter password",
                                  hintStyle: TextStyle(fontSize: 12),
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                      child: Icon(Icons.visibility))
                              ),
                              validator: (value) {
                                if (value == null || value.length < 7) {
                                  return 'Required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Password must be more than 8 characters.",
                            style: textTheme.bodyMedium!
                                .copyWith(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          checkColor: Colors.grey,
                          value: true,
                          onChanged: (val) {}),
                      Text(
                        "Agree with ",
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium!
                            .copyWith(fontSize: 15, color: Colors.black54),
                      ),
                      Text(
                        "Terms & Conditions",
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium!
                            .copyWith(fontSize: 15, color: Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () async {
                      bool formValid = _formKey.currentState!.validate();
                      if (formValid == false) {
                        return;
                      }
                      setState(() {
                        isLoading = true;
                      });

                      String phoneNumber = "";
                      if ((countryCde + _phoneController.text.trim()).length >=
                          10) {
                        phoneNumber = countryCde + _phoneController.text.trim();
                      }

                      bool res = await _userProvider.registerClient(
                        email: _emailController.text.trim(),
                        username: _usernameController.text.trim(),
                        phoneNumber: phoneNumber,
                        password: _passwordController1.text.trim(),
                      );

                      if (res == true) {
                        Get.offAll(() => HomeView());
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: isLoading
                          ? const SpinKitThreeInOut(
                              color: Colors.white,
                        size: 30,
                            )
                          : Text(
                              "Sign Up",
                              textAlign: TextAlign.center,
                              style: textTheme.bodyMedium!
                                  .copyWith(fontSize: 17, color: Colors.white),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium!
                            .copyWith(fontSize: 17, color: Colors.black54),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Get.off(() => SignInView());
                        },
                        child: Text(
                          "Sign in",
                          textAlign: TextAlign.center,
                          style: textTheme.bodyMedium!
                              .copyWith(fontSize: 17, color: Colors.blue[500]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
