import 'package:bus_stop/config/shared/utils.dart';
import 'package:bus_stop/models/transaction/transaction.dart';
import 'package:flutter/material.dart';

class MyTransactionsView extends StatefulWidget {
  final String clientId;
  const MyTransactionsView({super.key, required this.clientId});

  @override
  State<MyTransactionsView> createState() => _MyTransactionsViewState();
}

class _MyTransactionsViewState extends State<MyTransactionsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.grey[300],
          title: const Text(
            "My Transactions",
            style: TextStyle(color: Color(0xffE4181D)),
          ),
          centerTitle: true,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
                Navigator.of(context).pop();
            },
            child: SizedBox(
                width: 20,
                height: 25,
                child: Image.asset(
                  'assets/images/back_arrow.png',
                )),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: TransactionModel.getClientTransactions(
                    clientId: widget.clientId),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("Something has Gone Wrong!"),
                            ],
                          ),
                        ));
                  }
                  if (!snapshot.hasData) {
                    return const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        ));
                  } else {
                    List<TransactionModel>? data = snapshot.data;
                    if (data == null) {
                      return Expanded(
                          child: Center(
                              child: Text(
                                "Hey!\n No Data Found!",
                                textAlign: TextAlign.center,
                              )));
                    }
                    if (data.isEmpty) {
                      return Expanded(
                          child: Center(
                              child: Text(
                                "Hey!\n No Data Found!",
                                textAlign: TextAlign.center,
                              )));
                    }
                    return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, int index) {
                                return Card(
                                  child: ListTile(
                                    // onTap: () {
                                    //   _openBottomSheet(destination: data[index]);
                                    // },
                                    leading: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: data[index].paymentStatus == "SETTLED" ? Colors.green[600] :
                                          data[index].paymentStatus == "PENDING" ? Colors.blue[500] : Colors.orange[500]
                                      ),
                                      child: Text(data[index].paymentStatus.toUpperCase(),
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            color: Colors.white,
                                            fontSize: 14
                                        ),
                                      ),
                                    ),
                                    title: Text("SHS "+data[index].totalAmount.toString() + " (${data[index].numberOfTickets})",
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: Colors.green[900],
                                          fontSize: 18
                                      ),
                                    ),
                                    subtitle: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: 80,
                                                child: Text("Phone")),
                                            Text(data[index].buyerPhone,
                                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                  color: Colors.blue[900],
                                                  fontSize: 14
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: 80,
                                                child: Text("Client")),
                                            Text(data[index].buyerNames,
                                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                  color: Colors.blue[900],
                                                  fontSize: 14
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: 80,
                                                child: Text("Company")),
                                            Text(data[index].companyName,
                                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                  color: Colors.blue[900],
                                                  fontSize: 14
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: 80,
                                                child: Text("Trip")),
                                            Text(data[index].tripNumber,
                                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                  color: Colors.blue[900],
                                                  fontSize: 14
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              dateToStringNew(data[index].createdAt) +
                                                  "/" +
                                                  dateToTime(data[index].createdAt,
                                                  ),
                                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                  color: Colors.red,
                                                  fontSize: 14
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
