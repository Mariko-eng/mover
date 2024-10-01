import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bus_stop/config/collections/prod.dart';
import 'package:bus_stop/config/collections/dev.dart';

bool isTestMode = false;

class AppCollections {
  // Private constructor for singleton
  AppCollections._privateConstructor();

  // The single instance
  static final AppCollections _instance = AppCollections._privateConstructor();

  // Factory constructor to return the single instance
  factory AppCollections() {
    return _instance;
  }

  // Method to get collection reference based on the environment
  CollectionReference get adminAccountsRef {
    if (isTestMode == true) {
      return testAdminAccounts;
    }
    return prodAdminAccounts;
  }

  CollectionReference get clientsRef {
    if (isTestMode == true) {
      return testClients;
    }
    return prodClients;
  }

  CollectionReference get companiesRef {
    if (isTestMode == true) {
      return testCompanies;
    }
    return prodCompanies;
  }

  CollectionReference get destinationsRef {
    if (isTestMode == true) {
      return testDestinations;
    }
    return prodDestinations;
  }

  CollectionReference get transactionsRef {
    if (isTestMode == true) {
      return testTransactions;
    }
    return prodTransactions;
  }

  CollectionReference get tripsRef {
    if (isTestMode == true) {
      return testTrips;
    }
    return prodTrips;
  }

  CollectionReference get ticketsRef {
    if (isTestMode == true) {
      return testTickets;
    }
    return prodTickets;
  }

  CollectionReference get ticketsHistoryRef {
    if (isTestMode == true) {
      return testTicketsHistory;
    }
    return prodTicketsHistory;
  }

  CollectionReference get notificationsRef {
    if (isTestMode == true) {
      return testNotifications;
    }
    return prodNotifications;
  }

  CollectionReference get infoRef {
    if (isTestMode == true) {
      return testInfo;
    }
    return prodInfo;
  }
}

// class AppCollections1 {
//   // Production || Development
//   static bool isTestMode = true;
//
//   static late CollectionReference groupsRef;
//   static late CollectionReference adminAccountsRef;
//   static late CollectionReference clientsRef;
//   static late CollectionReference companiesRef;
//   static late CollectionReference destinationsRef;
//   static late CollectionReference transactionsRef;
//   static late CollectionReference ticketsRef;
//   static late CollectionReference ticketsPreRef;
//   static late CollectionReference ticketsHistoryRef;
//   static late CollectionReference tripsRef;
//   static late CollectionReference notificationsRef;
//   static late CollectionReference infoRef;
//
//   AppCollections() {
//     // print("isTestMode :: " + isTestMode.toString());
//
//     if (isTestMode == true) {
//       // Development
//       // adminAccountsRef = testAdminAccounts;
//       // clientsRef = testClients;
//       // companiesRef = testCompanies;
//       // destinationsRef = testDestinations;
//       // transactionsRef = testTransactions;
//       // ticketsRef = testTickets;
//       // ticketsHistoryRef = testTicketsHistory;
//       // tripsRef = testTrips;
//       // notificationsRef = testNotifications;
//       infoRef = testInfo;
//     } else {
//       // Production
//       adminAccountsRef = prodAdminAccounts;
//       clientsRef = prodClients;
//       companiesRef = prodCompanies;
//       destinationsRef = prodDestinations;
//       transactionsRef = prodTransactions;
//       ticketsRef = prodTickets;
//       ticketsHistoryRef = prodTicketsHistory;
//       tripsRef = prodTrips;
//       notificationsRef = prodNotifications;
//       infoRef = prodInfo;
//     }
//   }
// }
