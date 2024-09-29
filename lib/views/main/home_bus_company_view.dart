import 'package:get/get.dart';
import 'package:bus_stop/controllers/locController.dart';
import 'package:bus_stop/models/busCompany.dart';
import 'package:bus_stop/views/pages/bus_company/BusCompanyMyTickets.dart';
import 'package:bus_stop/views/pages/bus_company/BusCompanyTrips.dart';
import 'package:bus_stop/views/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
// import 'package:bus_stop/views/v2/widgets/bottom_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:bus_stop/controllers/authController.dart';

class HomeBusCompanyView extends StatefulWidget {
  const HomeBusCompanyView({super.key});

  @override
  State<HomeBusCompanyView> createState() => _HomeBusCompanyViewState();
}

class _HomeBusCompanyViewState extends State<HomeBusCompanyView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    LocationController controller = Get.find();

    controller.busCompanies();

    List<BusCompany> data = controller.companies;

    return Scaffold(
      key: scaffoldKey,
      appBar: buildHomeAppBar(
          scaffoldKey: scaffoldKey, context: context, title: "Bus Companies"),
      // drawer: DrawerView(),
      body: userProvider.client == null
          ? Container()
          : Obx(() => Column(
                children: [
                  Visibility(
                      visible: controller.isCompaniesLoading.value,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Colors.red,
                            )
                          ],
                        ),
                      )),
                  Expanded(
                      child: controller.isCompaniesLoading.value && data.isEmpty
                          ? Container()
                          : controller.isCompaniesError.value
                              ? Center(
                                  child: Text("Something Went Wrong!"),
                                )
                              : data.isEmpty
                                  ? Center(
                                      child: Text("No Results Found!"),
                                    )
                                  : ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder: (context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                )),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red[100],
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                      )),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Name : ",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(data[index].name)
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Email : ",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                              data[index].email)
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Phone Number : ",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(data[index]
                                                              .phoneNumber)
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            BusCompanyTrips(
                                                                              client: userProvider.client!,
                                                                              company: data[index],
                                                                            )));
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            alignment: Alignment
                                                                .center,
                                                            child: const Text(
                                                              "View Trips",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .blue[900],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            BusCompanyMyTickets(
                                                                              client: userProvider.client!,
                                                                              company: data[index],
                                                                            )));
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            alignment: Alignment
                                                                .center,
                                                            child: const Text(
                                                              "View Tickets",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .red[900],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          _openBottomSheet(
                                                              company:
                                                                  data[index]);
                                                        },
                                                        child: Container(
                                                          height: 30,
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Text(
                                                            "More",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red[900]),
                                                          ),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                          .red[
                                                                      900]!),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }))
                ],
              )),
    );
  }

  void _openBottomSheet({required BusCompany company}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getTicketOptions(company: company);
        });
  }

  Widget _getTicketOptions({required BusCompany company}) {
    final options = ["Destinations", "Bus Company Profile"];
    return Container(
      height: 250,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(children: [
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "More Options",
              style: TextStyle(fontSize: 17, color: Colors.blue[900]),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        ...options
            .map((option) => Card(
                  child: ListTile(
                    onTap: () => {
                      if (option == "Destinations")
                        {
                          Navigator.of(context).pop(),
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => BusCompanyDestinations(
                          //           company: company,
                          //         )))
                        },
                      if (option == "Bus Company Profile")
                        {
                          Navigator.of(context).pop(),
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => BusCompanyProfile(
                          //           company: company,
                          //         )))
                        }
                    },
                    trailing: Icon(Icons.arrow_forward_ios),
                    title: Text(
                      option,
                      textAlign: TextAlign.start,
                      style: const TextStyle(color: Color(0xFFE4191D)),
                    ),
                  ),
                ))
            .toList(),
      ]),
    );
  }
}
