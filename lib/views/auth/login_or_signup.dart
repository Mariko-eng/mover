import 'package:bus_stop/views/auth/login.dart';
import 'package:bus_stop/views/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginOrSignUpView extends StatefulWidget {
  const LoginOrSignUpView({Key? key}) : super(key: key);

  @override
  _LoginOrSignUpViewState createState() => _LoginOrSignUpViewState();
}

class _LoginOrSignUpViewState extends State<LoginOrSignUpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Column(
                      children:  [
                        Image.asset('assets/images/image12.png',
                        height: 100,
                          width: 100,
                        ),
                        const SizedBox(height: 5,),
                        const Text("Start by creating an",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                        ),
                        const SizedBox(height: 5,),
                        const Text("account.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Column(
                      children: const [
                        Text("Enjoy a blissful travel experience",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 17
                          ),
                        ),
                        Text("Book tour ticket today.",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 17
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //Buttons
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: GestureDetector(
                        onTap: (){
                          Get.to(() => LoginView());
                        },
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color(0xffE4181D),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text("Sign in".toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: GestureDetector(
                        onTap: (){
                          Get.to(() => SignUpView());
                        },
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffE4181D),
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text("Create account".toUpperCase(),
                            style: const TextStyle(
                                color: Color(0xffE4181D),
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}
