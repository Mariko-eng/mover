import 'package:bus_stop/views/homeType.dart';
import 'package:bus_stop/views/auth/login.dart';
import 'package:bus_stop/views/v2/widgets/TextFieldConatiner.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bus_stop/contollers/authController.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String countryCde = "";
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController1 = TextEditingController();
  final _passwordController2 = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool obscurePassword = true;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    UserProvider _userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: const Color(0xffE4181D),
        ),
        centerTitle: true,
        title: Text(
          "Create an account",
          style: TextStyle(
            color: const Color(0xffE4181D),
          ),
        ),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        controller: _usernameController,
                        cursorColor: Colors.red,
                        style: const TextStyle(fontSize: 15),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(
                          hintText: "Username",
                          icon: Icon(
                            Icons.person,
                            color: Colors.red,
                          ),
                          border: InputBorder.none,
                        ),
                        validator: (String? val) {
                          if (val!.trim().length < 3) {
                            return "Enter Valid Username. (At least 4 letters)";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        controller: _phoneController,
                        cursorColor: Colors.red,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          prefixIcon: SizedBox(
                            width: 125,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  color: Colors.red,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 110,
                                  child: CountryCodePicker(
                                    initialSelection: "ug",
                                    onInit: (code) {
                                      countryCde = code!.dialCode!;
                                    },
                                    onChanged: (code) {
                                      countryCde = code.dialCode!;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hintText: "Phone Number(7xx...)",
                          hintStyle: const TextStyle(fontSize: 13),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        controller: _emailController,
                        style: const TextStyle(fontSize: 17),
                        cursorColor: Colors.red,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Colors.red,
                          ),
                          hintText: "Email",
                          border: InputBorder.none,
                        ),
                        validator: (String? val) {
                          final bool isValid = EmailValidator.validate(val!.trim());
                          if (isValid == false) {
                            return "Enter Valid Email";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        controller: _passwordController1,
                        cursorColor: Colors.red,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(fontSize: 15),
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                            hintText: "Password",
                            icon: const Icon(
                              Icons.lock,
                              color: Colors.red,
                            ),
                            border: InputBorder.none,
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                                child: Icon(Icons.visibility))),
                        validator: (String? val) {
                          if (val!.trim().length < 7) {
                            return "Enter Valid Password";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        controller: _passwordController2,
                        cursorColor: Colors.red,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(fontSize: 15),
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                            hintText: "Confirm Password",
                            icon: const Icon(
                              Icons.lock,
                              color: Colors.red,
                            ),
                            border: InputBorder.none,
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                                child: Icon(Icons.visibility))),
                        validator: (String? val) {
                          if (_passwordController1.text.trim() != val!.trim()) {
                            return "Passwords Don't Match";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    isLoading
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Container(
                                alignment: Alignment.center,
                                height: 62,
                                decoration: BoxDecoration(
                                    color: const Color(0xffE4181D),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                )),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: GestureDetector(
                              onTap: () async {
                                bool formValid = _formKey.currentState!.validate();
                                if (formValid == false) {
                                  return;
                                }
                                setState(() {
                                  isLoading = true;
                                });

                                String phoneNumber = "";
                                if ((countryCde + _phoneController.text.trim())
                                        .length >=
                                    10) {
                                  phoneNumber =
                                      countryCde + _phoneController.text.trim();
                                }

                                bool res = await _userProvider.registerClient(
                                  email: _emailController.text.trim(),
                                  username: _usernameController.text.trim(),
                                  phoneNumber: phoneNumber,
                                  password: _passwordController1.text.trim(),
                                );

                                if (res == true) {
                                  Get.offAll(() => HomeType());
                                }

                                setState(() {
                                  isLoading = false;
                                });
                                },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 62,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffE4181D),
                                      borderRadius: BorderRadius.circular(10.0)),
                                  child: Text(
                                    "CREATE AN ACCOUNT".toUpperCase(),
                                    style:
                                        TextStyle(fontSize: 20, color: Colors.white),
                                  )),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.off(() => LoginView());
                              // widget.toggleView();
                            },
                            child: const Text(
                              "Sign In",
                              style:
                                  TextStyle(fontSize: 20, color: Color(0xffE4181D)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
