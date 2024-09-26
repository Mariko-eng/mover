// import 'package:bus_stop/views/auth/forgot_password.dart';
// import 'package:bus_stop/views/auth/wrapper.dart';
// import 'package:bus_stop/views/auth/signup.dart';
// import 'package:bus_stop/views/v3/auth/wrapper.dart';
// import 'package:bus_stop/views/widgets/TextFieldConatiner.dart';
// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:bus_stop/contollers/authController.dart';
//
// class LoginView extends StatefulWidget {
//   const LoginView({Key? key}) : super(key: key);
//
//   @override
//   _LoginViewState createState() => _LoginViewState();
// }
//
// class _LoginViewState extends State<LoginView> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   final _formKey = GlobalKey<FormState>();
//   bool obscurePassword = true;
//
//   bool isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
//     UserProvider _userProvider = Provider.of<UserProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         // backgroundColor: Colors.white,
//         backgroundColor: Color(0xffE4181D),
//         iconTheme: IconThemeData(color: Colors.white
//             // color: const Color(0xffE4181D),
//             ),
//         centerTitle: true,
//         title: const Text(
//           "Sign in to your account",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height * 0.35,
//             width: MediaQuery.of(context).size.width,
//             child: Padding(
//               padding: const EdgeInsets.all(25.0),
//               child: Center(
//                   child: Image.asset(
//                 'assets/images/image12.png',
//               )),
//             ),
//             decoration: const BoxDecoration(
//                 color: Color(0xffE4181D),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(50),
//                   bottomRight: Radius.circular(50),
//                 )),
//           ),
//           Form(
//             key: _formKey,
//             child: Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     TextFieldContainer(
//                       child: TextFormField(
//                         controller: _emailController,
//                         style: const TextStyle(fontSize: 17),
//                         cursorColor: Colors.red,
//                         textAlignVertical: TextAlignVertical.center,
//                         decoration: const InputDecoration(
//                           icon: Icon(
//                             Icons.email,
//                             color: Colors.red,
//                           ),
//                           hintText: "Email",
//                           border: InputBorder.none,
//                         ),
//                         validator: (String? val) {
//                           final bool isValid =
//                               EmailValidator.validate(val!.trim());
//                           if (isValid == false) {
//                             return "Enter Valid Email Address";
//                           } else {
//                             return null;
//                           }
//                         },
//                       ),
//                     ),
//                     TextFieldContainer(
//                       child: TextFormField(
//                         controller: _passwordController,
//                         style: const TextStyle(fontSize: 17),
//                         cursorColor: Colors.red,
//                         obscureText: obscurePassword,
//                         textAlignVertical: TextAlignVertical.center,
//                         decoration: InputDecoration(
//                             hintText: "Password",
//                             icon: Icon(
//                               Icons.lock,
//                               color: Colors.red,
//                             ),
//                             border: InputBorder.none,
//                             suffixIcon: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     obscurePassword = !obscurePassword;
//                                   });
//                                 },
//                                 child: Icon(Icons.visibility))),
//                         validator: (String? val) {
//                           if (val!.trim().length < 7) {
//                             return "Enter Valid Password";
//                           } else {
//                             return null;
//                           }
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               Get.to(() => const ForgotPassword());
//                             },
//                             child: Text(
//                               "Forgot your password?",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyMedium!
//                                   .copyWith(
//                                       fontSize: 16, color: Colors.blue[800]),
//                               // style: TextStyle(
//                               //     fontSize: 16, color: Colors.black87),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     isLoading
//                         ? Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 20, vertical: 20),
//                             child: Container(
//                                 alignment: Alignment.center,
//                                 height: 62,
//                                 decoration: BoxDecoration(
//                                     color: const Color(0xffE4181D),
//                                     borderRadius: BorderRadius.circular(10.0)),
//                                 child: CircularProgressIndicator(
//                                   color: Colors.white,
//                                 )),
//                           )
//                         : Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 20, vertical: 20),
//                             child: GestureDetector(
//                               onTap: () async {
//                                 bool formValid =
//                                     _formKey.currentState!.validate();
//                                 if (formValid == false) {
//                                   return;
//                                 }
//                                 setState(() {
//                                   isLoading = true;
//                                 });
//
//                                 bool res = await _userProvider.signIn(
//                                     email: _emailController.text.trim(),
//                                     password: _passwordController.text.trim());
//
//                                 setState(() {
//                                   isLoading = false;
//                                 });
//                                 if (res == true) {
//                                   Get.offAll(() => const AuthWrapperView());
//                                   // Get.offAll(() => const AuthWrapper());
//                                 }
//                               },
//                               child: Container(
//                                   alignment: Alignment.center,
//                                   height: 62,
//                                   decoration: BoxDecoration(
//                                       color: const Color(0xffE4181D),
//                                       borderRadius:
//                                           BorderRadius.circular(10.0)),
//                                   child: Text(
//                                     "Sign in".toUpperCase(),
//                                     style: TextStyle(
//                                         fontSize: 20, color: Colors.white),
//                                   )),
//                             ),
//                           ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text("Not a member?"),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Get.off(() => SignUpView());
//                               // widget.toggleView();
//                             },
//                             child: const Text(
//                               "Sign Up",
//                               style: TextStyle(
//                                   fontSize: 20, color: Color(0xffE4181D)),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
