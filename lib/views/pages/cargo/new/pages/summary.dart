import 'package:flutter/material.dart';

class NewCargoSummary extends StatefulWidget {
  const NewCargoSummary({super.key});

  @override
  State<NewCargoSummary> createState() => _NewCargoSummaryState();
}

class _NewCargoSummaryState extends State<NewCargoSummary> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Summary",
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
                Text("Package Type"),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.add_box_outlined),
                    title: Text("2kg box"),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Delivery Details"),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("FROM?"),
                        ListTile(
                          leading: Icon(Icons.location_city),
                          title: Text("Kampala"),
                        ),
                        Text("Pickup"),
                        ListTile(
                          leading: Icon(Icons.location_on),
                          title: Text("Kyadondo"),
                        ),
                        Text("TO?"),
                        ListTile(
                          leading: Icon(Icons.location_city),
                          title: Text("Mbarara"),
                        ),
                        Text("Date/Time"),
                        ListTile(
                          leading: Icon(Icons.calendar_month),
                          title: Text("ASAP"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sender & Recipient Info"),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Sender Name?"),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text("Mike"),
                        ),
                        Text("Sender Phone Number?"),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text("0798273833"),
                        ),
                        Text("Receiver Name?"),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text("Mike"),
                        ),
                        Text("Receiver Phone Number?"),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text("0798273833"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
