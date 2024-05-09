import 'package:bus_stop/models/transaction/payment.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bus_stop/config/collections/index.dart';

final CollectionReference transactionsCollection =
    AppCollections.transactionsRef;

class TransactionModel {
  final String transactionId;
  final String companyId;
  final String companyName;
  final String tripId;
  final String tripNumber;
  final String departureLocationId;
  final String departureLocationName;
  final String arrivalLocationId;
  final String arrivalLocationName;
  final String ticketType;

  final String ticketPrice;
  final String numberOfTickets;
  final String totalAmount;

  final String buyerNames;
  final String buyerPhone;
  final String buyerEmail;
  final String clientId;
  final String clientUsername;
  final String clientEmail;
  final String paymentStatus;
  final String paymentAccount;

  final String paymentAmount;

  final String paymentWallet;
  final String paymentMemo;

  final DateTime createdAt;

  TransactionModel(
      {required this.transactionId,
        required this.companyId,
        required this.companyName,
        required this.tripId,
        required this.tripNumber,
        required this.departureLocationId,
        required this.departureLocationName,
        required this.arrivalLocationId,
        required this.arrivalLocationName,
        required this.ticketType,
        required this.numberOfTickets,
        required this.ticketPrice,
        required this.totalAmount,
        required this.buyerNames,
        required this.buyerPhone,
        required this.buyerEmail,
        required this.clientId,
        required this.clientUsername,
        required this.clientEmail,
        required this.createdAt,
        required this.paymentStatus,
        required this.paymentAccount,
        required this.paymentAmount,
        required this.paymentWallet,
        required this.paymentMemo});

  factory TransactionModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map;
    return TransactionModel(
        transactionId: snapshot.id,
        companyId: data['companyId'] ?? "",
        companyName: data['companyName'] ?? "",
        tripId: data['tripId'] ?? "",
        tripNumber: data['tripNumber'] ?? "",
        arrivalLocationId: data['arrivalLocationId'] ?? "",
        arrivalLocationName: data['arrivalLocationName'] ?? "",
        departureLocationId: data['departureLocationId'] ?? "",
        departureLocationName: data['departureLocationName'] ?? "",
        ticketType: data['ticketType'] ?? "",
        ticketPrice: data['ticketPrice'] == null ? ""  : data['ticketPrice'] .toString(),
        numberOfTickets: data['numberOfTickets'] == null ? ""  : data['numberOfTickets'] .toString(),
        totalAmount: data['totalAmount'] == null ? ""  : data['totalAmount'] .toString(),
        buyerNames: data['buyerNames'] ?? "",
        buyerPhone: data['buyerPhone'] ?? "",
        buyerEmail: data['buyerEmail'] ?? "",
        clientId: data['clientId'] ?? "",
        clientUsername: data['clientUsername'] ?? "",
        clientEmail: data['clientEmail'] ?? "",
        paymentStatus: data['paymentStatus'] ?? "PENDING",
        paymentAccount: data['paymentAccount'] ?? "",
        paymentAmount: data['paymentAmount'] == null ? ""  : data['paymentAmount'] .toString(),
        paymentWallet: data['paymentWallet'] ?? "",
        paymentMemo: data['paymentMemo'] ?? "",
        createdAt: DateTime.parse(data['createdAt']));
  }


  static Future<List<TransactionModel>> getClientTransactions(
      {required String clientId}) async {
    try {
      var results = await AppCollections.transactionsRef
          .where('clientId', isEqualTo: clientId)
          .orderBy('createdAt', descending: true)
          .get();

      return results.docs.map((doc) => TransactionModel.fromSnapshot(doc)).toList();
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }
}

Future<PaymentModel> buyTripTicket({
  required Trip trip,
  required String ticketType,
  required int ticketPrice,
  required int numberOfTickets,
  required int totalAmount,
  required String buyerNames,
  required String buyerPhone,
  required String buyerEmail,
  required Client client,
  required bool isTestMode,
  String paymentStatus = "PENDING",
  required String paymentAccount,
  required int paymentAmount,
  required String paymentWallet,
  required String paymentMemo,
}) async {
  try {

    final transactionData = {
      'companyId': trip.companyId,
      'companyName': trip.companyName,
      'tripId': trip.id,
      'tripNumber': trip.tripNumber,
      'arrivalLocationId': trip.arrivalLocationId,
      'arrivalLocationName': trip.arrivalLocationName,
      'departureLocationId': trip.departureLocationId,
      'departureLocationName': trip.departureLocationName,
      'ticketType': ticketType,
      'ticketPrice': ticketPrice,
      'numberOfTickets': numberOfTickets,
      'totalAmount': totalAmount,
      'buyerNames': buyerNames,
      'buyerPhone': buyerPhone,
      'buyerEmail': buyerEmail,
      'clientId': client.uid,
      'clientUsername': client.username,
      'clientEmail': client.email,
      'paymentStatus': paymentStatus,
      'paymentAccount': paymentAccount,
      'paymentAmount': paymentAmount,
      'paymentWallet': paymentWallet,
      'paymentMemo': paymentMemo,
      'createdAt': DateTime.now().toIso8601String(),
    };

    DocumentReference doc = await transactionsCollection.add(transactionData);

    PaymentModel? paymentModel = await initiateTransaction(
        isTestMode: isTestMode,
        account: paymentAccount,
        amount: paymentAmount,
        wallet: paymentWallet,
        transactionID: doc.id,
        memo: paymentMemo);

      print("Checking Payment Status!");

      PaymentModel updatedPaymentModel =
      await checkPaymentTransactionStatus(paymentModel: paymentModel);

      await transactionsCollection.doc(paymentModel.transactionId).update({
        "culipaTxId": updatedPaymentModel.culipaTxId,
        "paymentStatus": updatedPaymentModel.status
      });

      print("Done!");
      return updatedPaymentModel;
  } catch (e) {
    print(e.toString());
    throw Exception(e.toString());
  }
}


