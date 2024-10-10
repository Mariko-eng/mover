import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:bus_stop/controllers/authController.dart';
import 'package:bus_stop/views/auth/wrapper.dart';
import 'package:bus_stop/views/auth/signup.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                    "Sign in",
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
                    "Login into your account.",
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
                    height: 20,
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
                              controller: _passwordController,
                              minLines: 1,
                              maxLines: 1,
                              obscureText: _obscurePassword,
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
                                if (value == null || value.isEmpty) {
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

                      bool res = await _userProvider.signIn(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim());

                      setState(() {
                        isLoading = false;
                      });
                      if (res == true) {
                        Get.offAll(() => const AuthWrapperView());
                      }
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
                              "Sign in",
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
                        "Don't have an account?",
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium!
                            .copyWith(fontSize: 17, color: Colors.black54),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Get.off(() => SignUpView());
                        },
                        child: Text(
                          "Sign up",
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
