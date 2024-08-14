import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:bus_stop/views/pages/cargo/new/checkout_view.dart';
import 'package:bus_stop/views/pages/cargo/new/pages/delivery_details.dart';
import 'package:bus_stop/views/pages/cargo/new/pages/package_details.dart';
import 'package:bus_stop/views/pages/cargo/new/pages/receiver_details.dart';
import 'package:bus_stop/views/pages/cargo/new/pages/summary.dart';

class NewCargoWrapperView extends StatefulWidget {
  const NewCargoWrapperView({super.key});

  @override
  State<NewCargoWrapperView> createState() => _NewCargoWrapperViewState();
}

class _NewCargoWrapperViewState extends State<NewCargoWrapperView> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  final GlobalKey<FormState> _formKey0 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  // final _formKeys = List.generate(4, (index) => GlobalKey<FormState>());

  final TextEditingController itemNameCtr = TextEditingController();
  final TextEditingController itemWeightCtr = TextEditingController();
  final TextEditingController itemLengthCtr = TextEditingController();
  final TextEditingController itemWidthCtr = TextEditingController();
  final TextEditingController itemHeightCtr = TextEditingController();
  final TextEditingController busCompanyIdCtr = TextEditingController();

  final TextEditingController busCompanyNameCtr = TextEditingController();
  final TextEditingController departureIdCtr = TextEditingController();
  final TextEditingController departureNameCtr = TextEditingController();
  final TextEditingController arrivalIdCtr = TextEditingController();
  final TextEditingController arrivalNameCtr = TextEditingController();
  final TextEditingController dateTimeCtr = TextEditingController();
  final TextEditingController pickUpIdCtr = TextEditingController();
  final TextEditingController pickUpNameCtr = TextEditingController();
  final TextEditingController pickUpLatCtr = TextEditingController();
  final TextEditingController pickUpLngCtr = TextEditingController();

  final TextEditingController senderNameCtr = TextEditingController();
  final TextEditingController senderPhoneCtr = TextEditingController();
  final TextEditingController receiverNameCtr = TextEditingController();
  final TextEditingController receiverPhoneCtr = TextEditingController();
  final TextEditingController additionalNotesCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChanged);
    setState(() {
      dateTimeCtr.text = DateFormat.yMEd().add_jms().format(DateTime.now());
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _currentPage.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    _currentPage.value = _pageController.page?.toInt() ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 150 + statusBarHeight,
        backgroundColor: Theme.of(context).primaryColor,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(top: statusBarHeight, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (_currentPage.value == 0) {
                          Get.back(); // Navigate back if on the first page
                        } else {
                          _pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Icon(Icons.arrow_back, color: Colors.white))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "New Order",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 30, color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Please Complete The Steps Make Your Order",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 15, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              ValueListenableBuilder<int>(
                  valueListenable: _currentPage,
                  builder: (context, pageIndex, child) {
                    return Row(
                      children: [
                        Container(
                          height: 10,
                          width: pageIndex == 0 ? 30 : 10,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 10,
                          width: pageIndex == 1 ? 30 : 10,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 10,
                          width: pageIndex == 2 ? 30 : 10,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 10,
                          width: pageIndex == 3 ? 30 : 10,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    );
                  }),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  NewCargoPackageDetails(
                    itemNameCtr: itemNameCtr,
                    itemWeightCtr: itemWeightCtr,
                    itemLengthCtr: itemLengthCtr,
                    itemWidthCtr: itemWidthCtr,
                    itemHeightCtr: itemHeightCtr,
                    formKey: _formKey0,
                  ),
                  NewCargoDeliveryDetails(
                    busCompanyIdCtr: busCompanyIdCtr,
                    busCompanyNameCtr: busCompanyNameCtr,
                    departureIdCtr: departureIdCtr,
                    departureNameCtr: departureNameCtr,
                    arrivalIdCtr: arrivalIdCtr,
                    arrivalNameCtr: arrivalNameCtr,
                    dateTimeCtr: dateTimeCtr,
                    pickUpIdCtr: pickUpIdCtr,
                    pickUpNameCtr: pickUpNameCtr,
                    pickUpLatCtr: pickUpLatCtr,
                    pickUpLngCtr: pickUpLngCtr,
                    formKey: _formKey1,
                  ),
                  NewCargoReceiverDetails(
                    senderNameCtr: senderNameCtr,
                    senderPhoneCtr: senderPhoneCtr,
                    receiverNameCtr: receiverNameCtr,
                    receiverPhoneCtr: receiverPhoneCtr,
                    additionalNotesCtr: additionalNotesCtr,
                    formKey: _formKey2,
                  ),
                  const NewCargoSummary(),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       GestureDetector(
            //         onTap: () {
            //           if (_currentPage.value == 0) {
            //             Get.back(); // Navigate back if on the first page
            //           } else {
            //             _pageController.previousPage(
            //               duration: Duration(milliseconds: 300),
            //               curve: Curves.easeInOut,
            //             );
            //           }
            //         },
            //         child: Container(
            //           height: 40,
            //           width: 130,
            //           alignment: Alignment.center,
            //           child: Text("Previous",
            //               style: Theme.of(context)
            //                   .textTheme
            //                   .bodyMedium!
            //                   .copyWith(
            //                       fontSize: 18,
            //                       color: Theme.of(context).primaryColor,
            //                       fontWeight: FontWeight.bold)),
            //           decoration: BoxDecoration(
            //               border:
            //                   Border.all(color: Theme.of(context).primaryColor),
            //               borderRadius: BorderRadius.circular(5)),
            //         ),
            //       ),
            //       GestureDetector(
            //         onTap: () {
            //           if(_currentPage.value == 0) {
            //             bool formValid = _formKey0.currentState?.validate() ?? false;
            //             if(formValid) {
            //               _pageController.nextPage(
            //                 duration: Duration(milliseconds: 300),
            //                 curve: Curves.easeInOut,
            //               );
            //             }else {
            //               ScaffoldMessenger.of(context).showSnackBar(
            //                 SnackBar(content: Text('Please fill in the required data.')),
            //               );
            //               return;
            //             }
            //           }
            //
            //           if(_currentPage.value == 1) {
            //             bool formValid = _formKey1.currentState?.validate() ?? false;
            //             if(formValid) {
            //               _pageController.nextPage(
            //                 duration: Duration(milliseconds: 300),
            //                 curve: Curves.easeInOut,
            //               );
            //             }else {
            //               ScaffoldMessenger.of(context).showSnackBar(
            //                 SnackBar(content: Text('Please fill in the required data.')),
            //               );
            //               return;
            //             }
            //           }
            //
            //
            //           if (_currentPage.value == 2) {
            //             bool formValid = _formKey2.currentState?.validate() ?? false;
            //             if(formValid) {
            //               Get.to(() => const NewCargoCheckoutView());
            //             }else {
            //               ScaffoldMessenger.of(context).showSnackBar(
            //                 SnackBar(content: Text('Please fill in the required data.')),
            //               );
            //               return;
            //             }
            //           }
            //
            //           _pageController.nextPage(
            //             duration: Duration(milliseconds: 300),
            //             curve: Curves.easeInOut,
            //           );
            //         },
            //         child: Container(
            //           height: 40,
            //           width: 130,
            //           alignment: Alignment.center,
            //           child: Text(_currentPage.value < 3 ? "Next" : "Checkout",
            //               style: Theme.of(context)
            //                   .textTheme
            //                   .bodyMedium!
            //                   .copyWith(
            //                       fontSize: 18,
            //                       color: Colors.white,
            //                       fontWeight: FontWeight.bold)),
            //           decoration: BoxDecoration(
            //               color: Theme.of(context).primaryColor,
            //               border:
            //                   Border.all(color: Theme.of(context).primaryColor),
            //               borderRadius: BorderRadius.circular(5)),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (_currentPage.value == 0) {
                      Get.back(); // Navigate back if on the first page
                    } else {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 130,
                    alignment: Alignment.center,
                    child: Text("Previous",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                            fontSize: 18,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold)),
                    decoration: BoxDecoration(
                        border:
                        Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if(_currentPage.value == 0) {
                      bool formValid = _formKey0.currentState?.validate() ?? false;
                      if(formValid) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please fill in the required data.')),
                        );
                        return;
                      }
                    }

                    if(_currentPage.value == 1) {
                      bool formValid = _formKey1.currentState?.validate() ?? false;
                      if(formValid) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please fill in the required data.')),
                        );
                        return;
                      }
                    }


                    if (_currentPage.value == 2) {
                      bool formValid = _formKey2.currentState?.validate() ?? false;
                      if(formValid) {
                        Get.to(() => const NewCargoCheckoutView());
                      }else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 1),
                              content: Text('Please fill in the required data.')),
                        );
                        return;
                      }
                    }

                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    height: 40,
                    width: 130,
                    alignment: Alignment.center,
                    child: Text(_currentPage.value < 3 ? "Next" : "Checkout",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border:
                        Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void _submitOrder() {
  //   // for (var key in _formKeys) {
  //   //   print(key.currentState); // Should not be null
  //   // }
  //   // bool iv = _formKeys[0].currentState!.validate();
  //
  //   print("_formKey1");
  //   print(_formKey1);
  //
  //   bool valid1 = _formKey1.currentState?.validate() ?? false;
  //   bool valid2 = _formKey2.currentState?.validate() ?? false;
  //   bool valid3 = _formKey3.currentState?.validate() ?? false;
  //
  //   // bool allValid =
  //   //     _formKeys.every((key) => key.currentState?.validate() ?? false);
  //
  //   bool allValid = valid1 && valid2 && valid3;
  //
  //   if (allValid) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Order Submitted!')),
  //     );
  //     Get.to(() => const NewCargoCheckoutView());
  //     // Here you would typically handle form submission, e.g., sending data to a server.
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Please complete all pages.')),
  //     );
  //   }
  // }
}
