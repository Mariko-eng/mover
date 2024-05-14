import 'package:bus_stop/config/shared/constants.dart';
import 'package:dio/dio.dart';

class PaymentModel {
  String culipaTxId;
  PaymentDetails payment;
  String transactionId;
  String status;

  PaymentModel({
    required this.culipaTxId,
    required this.payment,
    required this.transactionId,
    required this.status,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      PaymentModel(
        culipaTxId: json["culipaTxID"],
        payment: PaymentDetails.fromJson(json["payment"]),
        transactionId: json["transactionID"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "culipaTxID": culipaTxId,
    "payment": payment.toJson(),
    "transactionID": transactionId,
    "status": status,
  };
}

class PaymentDetails {
  int amount;
  String wallet;
  String currency;
  String account;

  PaymentDetails({
    required this.amount,
    required this.wallet,
    required this.currency,
    required this.account,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) => PaymentDetails(
    amount: json["amount"],
    wallet: json["wallet"],
    currency: json["currency"],
    account: json["account"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "wallet": wallet,
    "currency": currency,
    "account": account,
  };
}

Future<PaymentModel> initiateTransaction({
  required bool isTestMode,
  required String account, // Phone Number
  required int amount,
  required String wallet, // 'mtnug' | 'airtelug'
  required String transactionID,
}) async {
  try {
    Dio dio = Dio();

    String url = "https://culipay.ug/initiate";
    String apiKey = prodCulipaAPIKey;

    if (isTestMode == true) {
      url = "https://test.culipay.ug/initiate";
      apiKey = devCulipaAPIKey;
    }

    // Map payload1 = {
    //   "account":"785227694",
    //   "amount":500,
    //   "currency":"UGX",
    //   "wallet":"MTN-AIRTEL-UG",
    //   "transactionID":"ticket00456",
    //   "merchant":"BusStop",
    //   "memo":"Bus Ticket Payment"
    // };

    Map payload = {
      "account": account,
      "amount":  amount,
      "currency": "UGX",
      "wallet": isTestMode == true ? wallet : "MTN-AIRTEL-UG",
      "transactionID": transactionID,
      "merchant": "BusStop",
      "memo": "Bus Ticket Payment"
    };

    print("Be4 response");
    print(payload);

    Response response = await dio.post(url, data: payload,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Connection': 'keep-alive',
            'api-key': apiKey,
            'merchant': 'BusStop'
          },
        )
    );

    PaymentModel data = PaymentModel.fromJson(response.data);

    return data;
  } on DioException catch (error) {
    print("DIO Error : " + error.toString());
    throw Exception('DIO Error: $error');
  } catch (e) {
    print(e.toString());
    throw e.toString();
  }
}

Future<PaymentModel> checkPaymentTransactionStatus({
  required PaymentModel paymentModel,
  required bool isTestMode,
}) async {
  try {
    Dio dio = Dio();

    String url = "https://culipay.ug/status/${paymentModel.culipaTxId}";
    String apiKey = prodCulipaAPIKey;

    if (isTestMode == true) {
      url = "https://test.culipay.ug/status/${paymentModel.culipaTxId}";
      apiKey = devCulipaAPIKey;
    }

    while (true) {
      Response response = await dio.get(url,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': '*/*',
              'Connection': 'keep-alive',
              'api-key': apiKey,
              'merchant': 'BusStop'
            },
          )
      );
      PaymentModel data = PaymentModel.fromJson(response.data);

      print(data.transactionId);

      if (data.status.toUpperCase() != "PENDING") {
        return data; // Transaction status is no longer "Pending", return the data
      }

      // Wait for 10 seconds before checking again
      await Future.delayed(const Duration(seconds: 5));
    }
  } on DioException catch (error) {
    print('DIO Error: $error');
    paymentModel.status = "ERROR";
    return paymentModel;
  } catch (e) {
    print('Error: $e');
    // throw e.toString();
    paymentModel.status = "ERROR";
    return paymentModel;
  }
}
