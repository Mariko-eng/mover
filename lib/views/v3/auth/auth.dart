import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bus_stop/views/v3/auth/signin.dart';
import 'package:bus_stop/views/v3/auth/signup.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('lib/images/city_bus.svg',
              // width: size.width,
              // height: 200,
            ),
            Text("Explore new places or get home with ease \n book your bus ride today!",
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium!.copyWith(
                  fontSize: 17,
                  color: Colors.grey[900]
              ),
            ),

            SizedBox(height: 50,),

            InkWell(
              onTap: () {
                Get.to(() => SignUpView());
              },
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Text("Sign Up",
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium!.copyWith(
                      fontSize: 17,
                      color: Colors.white
                  ),
                ),
              ),
            ),

            SizedBox(height: 50,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium!.copyWith(
                      fontSize: 17,
                      color: Colors.black54
                  ),
                ),
                SizedBox(width: 5,),
                InkWell(
                  onTap: () {
                    Get.to(() => SignInView());
                  },
                  child: Text("Sign in",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium!.copyWith(
                        fontSize: 17,
                        color: Colors.blue[500]
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 50,),

          ],
        ),
      ),
    );
  }
}
