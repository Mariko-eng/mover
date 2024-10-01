import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_stop/models/info.dart';

class InfoNewsDetailView extends StatefulWidget {
  final InfoModel infoModel;

  const InfoNewsDetailView({super.key, required this.infoModel});

  @override
  State<InfoNewsDetailView> createState() => _InfoNewsDetailViewState();
}

class _InfoNewsDetailViewState extends State<InfoNewsDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffffffff),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.infoModel.title.toUpperCase(),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Hero(
                      tag: widget.infoModel.id,
                      child: Image.network(
                        widget.infoModel.imageUrl,
                        height: 200,
                      ),
                    ),
                  )
                  ,
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text(widget.infoModel.subTitle.toUpperCase(),
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue[800],
                      fontWeight: FontWeight.w400
                  ),
                )],
              ),
              Divider(),
              SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.infoModel.description,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 17,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
