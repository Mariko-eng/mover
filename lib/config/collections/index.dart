import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bus_stop/config/collections/prod.dart';
import 'package:bus_stop/config/collections/dev.dart';

// class AppCollections{
//   // Production
//   static bool isTestMode = false;
//   static CollectionReference adminAccountsRef = prodAdminAccounts;
//   static CollectionReference clientsRef = prodClients;
//   static CollectionReference companiesRef = prodCompanies;
//   static CollectionReference destinationsRef = prodDestinations;
//   static CollectionReference transactionsRef = prodTransactions;
//   static CollectionReference ticketsRef = prodTickets;
//   static CollectionReference ticketsHistoryRef = prodTicketsHistory;
//   static CollectionReference tripsRef = prodTrips;
//   static CollectionReference notificationsRef = prodNotifications;
//   static CollectionReference infoRef = prodInfo;
//
//
//   // Development
//   // static bool isTestMode = true;
//   // static CollectionReference adminAccountsRef = testAdminAccounts;
//   // static CollectionReference clientsRef = testClients;
//   // static CollectionReference companiesRef = testCompanies;
//   // static CollectionReference destinationsRef = testDestinations;
//   // static CollectionReference transactionsRef = testTransactions;
//   // static CollectionReference ticketsRef = testTickets;
//   // static CollectionReference ticketsHistoryRef = testTicketsHistory;
//   // static CollectionReference tripsRef = testTrips;
//   // static CollectionReference notificationsRef = testNotifications;
//   // static CollectionReference infoRef = testInfo;
// }

class AppCollections {
  // Production
  static bool isTestMode = false;

  static late CollectionReference groupsRef;
  static late CollectionReference adminAccountsRef;
  static late CollectionReference clientsRef;
  static late CollectionReference companiesRef;
  static late CollectionReference destinationsRef;
  static late CollectionReference transactionsRef;
  static late CollectionReference ticketsRef;
  static late CollectionReference ticketsPreRef;
  static late CollectionReference ticketsHistoryRef;
  static late CollectionReference tripsRef;
  static late CollectionReference notificationsRef;
  static late CollectionReference infoRef;

  AppCollections() {
    // print("isTestMode :: " + isTestMode.toString());

    if (isTestMode == true) {
      // Development
      adminAccountsRef = testAdminAccounts;
      clientsRef = testClients;
      companiesRef = testCompanies;
      destinationsRef = testDestinations;
      transactionsRef = testTransactions;
      ticketsRef = testTickets;
      ticketsHistoryRef = testTicketsHistory;
      tripsRef = testTrips;
      notificationsRef = testNotifications;
      infoRef = testInfo;
    } else {
      // Production
      adminAccountsRef = prodAdminAccounts;
      clientsRef = prodClients;
      companiesRef = prodCompanies;
      destinationsRef = prodDestinations;
      transactionsRef = prodTransactions;
      ticketsRef = prodTickets;
      ticketsHistoryRef = prodTicketsHistory;
      tripsRef = prodTrips;
      notificationsRef = prodNotifications;
      infoRef = prodInfo;
    }
  }
}
