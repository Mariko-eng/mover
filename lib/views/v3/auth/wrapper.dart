import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bus_stop/contollers/authController.dart';
import 'package:bus_stop/views/v3/auth/auth.dart';
import 'package:bus_stop/views/widgets/loading_view.dart';
import 'package:bus_stop/views/v3/main/home.dart';

class AuthWrapperView extends StatelessWidget {
  const AuthWrapperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    if (userProvider.isLoading) {
      return const LoadingView();
    } else {
      if (userProvider.client == null) {
        return const AuthView();
      } else {
        return const HomeView();
      }
    }
  }
}
