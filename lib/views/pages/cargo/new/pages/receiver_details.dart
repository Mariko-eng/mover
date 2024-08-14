import 'package:flutter/material.dart';

class NewCargoReceiverDetails extends StatefulWidget {
  final TextEditingController senderNameCtr;
  final TextEditingController senderPhoneCtr;
  final TextEditingController receiverNameCtr;
  final TextEditingController receiverPhoneCtr;
  final TextEditingController additionalNotesCtr;

  final GlobalKey<FormState> formKey;

  const NewCargoReceiverDetails({
    super.key,
    required this.formKey,
    required this.senderNameCtr,
    required this.senderPhoneCtr,
    required this.receiverNameCtr,
    required this.receiverPhoneCtr,
    required this.additionalNotesCtr,
  });

  @override
  State<NewCargoReceiverDetails> createState() =>
      _NewCargoReceiverDetailsState();
}

class _NewCargoReceiverDetailsState extends State<NewCargoReceiverDetails> {
  @override
  void initState() {
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
                "Sender & Receiver Info",
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
                  Text("Sender Name"),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: widget.senderNameCtr,
                          decoration:
                              InputDecoration(
                                  hintText: "Enter sender name",
                                border: OutlineInputBorder(),
                              ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
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
                  Text("Sender Phone Number"),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: widget.senderPhoneCtr,
                          decoration:
                              InputDecoration(
                                  hintText: "Enter sender phone",
                                border: OutlineInputBorder(),
                              ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter phone';
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
                  Text("Receiver Name"),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: widget.receiverNameCtr,
                          decoration:
                              InputDecoration(
                                  hintText: "Enter recipient name",
                                border: OutlineInputBorder(),
                              ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
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
                  Text("Reciever Phone Number"),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: widget.receiverPhoneCtr,
                          decoration: InputDecoration(
                              hintText: "Enter receiver phone",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter phone';
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
                      Text("Additional Notes "),
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
                          controller: widget.additionalNotesCtr,
                          minLines: 2,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: "Enter here",
                            border: OutlineInputBorder(),
                          ),
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
