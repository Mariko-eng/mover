import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bus_stop/config/collections/prod.dart';
import 'package:bus_stop/config/collections/dev.dart';

class AppCollections{
  // Production
  // static CollectionReference adminAccountsRef = prodAdminAccounts;
  // static CollectionReference clientsRef = prodClients;
  // static CollectionReference companiesRef = prodCompanies;
  // static CollectionReference destinationsRef = prodDestinations;
  // static CollectionReference ticketsRef = prodTickets;
  // static CollectionReference ticketsPreRef = prodTicketsPre;
  // static CollectionReference ticketsHistoryRef = prodTicketsHistory;
  // static CollectionReference tripsRef = prodTrips;
  // static CollectionReference notificationsRef = prodNotifications;
  // static CollectionReference infoRef = prodInfo;


  // Development
  static CollectionReference adminAccountsRef = testAdminAccounts;
  static CollectionReference clientsRef = testClients;
  static CollectionReference companiesRef = testCompanies;
  static CollectionReference destinationsRef = testDestinations;
  static CollectionReference ticketsRef = testTickets;
  static CollectionReference ticketsPreRef = testTicketsPre;
  static CollectionReference ticketsHistoryRef = testTicketsHistory;
  static CollectionReference tripsRef = testTrips;
  static CollectionReference notificationsRef = testNotifications;
  static CollectionReference infoRef = testInfo;
}