import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop/views/v2/widgets/home_app_bar.dart';

class HomeInfoView extends StatefulWidget {
  const HomeInfoView({super.key});

  @override
  State<HomeInfoView> createState() => _HomeInfoViewState();
}

class _HomeInfoViewState extends State<HomeInfoView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: buildHomeAppBar(
          scaffoldKey: scaffoldKey, context: context, title: "Info"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 270,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                    // Dark color at the bottom (adjust opacity as needed)
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/image11.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bus Stop",
                            style: TextStyle(
                              fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Welcome to Bus Stop",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
