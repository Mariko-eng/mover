import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bus_stop/contollers/authController.dart';
import 'package:bus_stop/views/main/home_view.dart';

class HomeType extends StatefulWidget {
  const HomeType({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<HomeType> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: userProvider.client == null ? Container() : SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.65,
                  decoration: const BoxDecoration(
                      color: Color(0xffE4181D),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      )),
                  child: Image.asset(
                    'assets/images/image11.png',
                  )),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.35,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Welcome " + userProvider.client!.username.toUpperCase(),
                      style: const TextStyle(fontSize: 22,
                      color: Color(0xffE4181D)
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Book Your Next Bus Trip Today",
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                              text: "We make the process of international bus "
                                  "travel fast and without all the hassle",
                              style: TextStyle(color: Color(0xffE4181D)))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomeView()));
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            decoration: BoxDecoration(
                                color: const Color(0xffE4181D),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: const Text(
                              "Travel",
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
