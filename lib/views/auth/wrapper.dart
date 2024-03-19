import 'package:bus_stop/views/homeType.dart';
import 'package:bus_stop/views/shared/loading.dart';
import 'package:bus_stop/views/auth/login_or_signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bus_stop/contollers/authController.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    if (userProvider.isLoading) {
      return Loading();
    } else {
      if (userProvider.client == null) {
        return const LoginOrSignUpView();
        // return AuthWrapper();
      } else {
        return HomeType();
        // return HomeType(
        //   client: userProvider.client!,
        // );
      }
    }
  }
}
