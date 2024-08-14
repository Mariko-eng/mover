import 'dart:async';
import 'package:bus_stop/views/welcome/splashScreen.dart';
import 'package:flutter/material.dart';

class Initial extends StatefulWidget {
  const Initial({Key? key}) : super(key: key);

  @override
  _InitialState createState() => _InitialState();
}

class _InitialState extends State<Initial> with SingleTickerProviderStateMixin {
  Widget _myAnimatedWidget = InitialWidget();
  final List<Widget> _widgets = [
    InitialWidget(),
    FirstWidget(),
    SecondWidget(),
    ThirdWidget(),
    FourthWidget(),
    FifthWidget(),
  ];
  int i = 0;

  _changeAnimation() async {
    setState(() {
      Timer.periodic(Duration(milliseconds: 700), (Timer timer) {
        setState(() {
          i = i + 1;
          _myAnimatedWidget = _widgets[i];
        });
        if (i == 5) {
          timer.cancel();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const SplashScreen()));
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _changeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: SafeArea(
        child: Stack(
          children: [
            const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(50.0),
                  child: Text("travel made easy"),
                )),
            Center(
              child: Container(
                child: AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: Tween<double>(
                        begin: 0.0,
                        end: 1.0,
                      ).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.fastOutSlowIn,
                        ),
                      ),
                      child: child,
                    );
                  },
                  child: _myAnimatedWidget,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InitialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffffffff),
      ),
    );
  }
}

class FirstWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 200.0,
      child: Center(child: Image.asset('assets/images/image1.png')),
    );
  }
}

class FifthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffE4181D),
    );
  }
}

class SecondWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 200.0,
      child: Center(child: Image.asset('assets/images/image7.png')),
    );
  }
}

class ThirdWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 200.0,
      child: Center(child: Image.asset('assets/images/image6.png')),
    );
  }
}

class FourthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 200.0,
      // color: Color(0xffffffff),
      child: Center(child: Image.asset('assets/images/image5.png')),
    );
  }
}
