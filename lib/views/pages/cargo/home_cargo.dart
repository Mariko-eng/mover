import 'package:bus_stop/views/pages/cargo/new/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCargoView extends StatefulWidget {
  const HomeCargoView({super.key});

  @override
  State<HomeCargoView> createState() => _HomeCargoViewState();
}

class _HomeCargoViewState extends State<HomeCargoView> {
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150 + statusBarHeight,
        backgroundColor: Theme.of(context).primaryColor,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(top: statusBarHeight, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Text("Track Your Package",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 30,
                      color: Colors.white
                    ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Expanded(child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
                      child: TextField(
                        readOnly: true,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          hintText: "Search By Order Number",
                          suffixIcon: Icon(Icons.qr_code),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Get.to(() => NewCargoWrapperView());
        },
        child: Icon(Icons.add_circle,
        color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Recent Orders",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      color: Colors.black54,
                    fontWeight: FontWeight.bold
                  ),),
                Row(
                  children: [
                    Text("See All",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 18,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold
                        )
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
