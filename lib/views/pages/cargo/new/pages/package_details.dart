import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewCargoPackageDetails extends StatefulWidget {
  final TextEditingController itemNameCtr;
  final TextEditingController itemWeightCtr;
  final TextEditingController itemLengthCtr;
  final TextEditingController itemWidthCtr;
  final TextEditingController itemHeightCtr;
  final GlobalKey<FormState> formKey;

  const NewCargoPackageDetails(
      {super.key,
      required this.formKey,
      required this.itemNameCtr,
      required this.itemWeightCtr,
      required this.itemLengthCtr,
      required this.itemWidthCtr,
      required this.itemHeightCtr});

  @override
  State<NewCargoPackageDetails> createState() => _NewCargoPackageDetailsState();
}

class _NewCargoPackageDetailsState extends State<NewCargoPackageDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Package Parameters",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Item Name/Description "),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: widget.itemNameCtr,
                          minLines: 2,
                          maxLines: 5,
                          decoration:
                              InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter item name"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter item name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Weight (kg) "),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: widget.itemWeightCtr,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration:
                              InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter package weight"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter package weight';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Length (cm) "),
                      Text(
                        "*Optional",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 15, color: Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: widget.itemLengthCtr,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration:
                              InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter package length"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Width (cm) "),
                      Text(
                        "*Optional",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 15, color: Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: widget.itemWidthCtr,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration:
                              InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter package width"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Height (cm) "),
                      Text(
                        "*Optional",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 15, color: Colors.blue),
                      ),                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: widget.itemHeightCtr,
                          decoration:
                              InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter package height"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
