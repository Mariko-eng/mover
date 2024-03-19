
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService{
  // SharedPreferences _preferences;
  //
  // LocalStorageService(){
  //   _init();
  // }
  //
  // _init() async{
  //   SharedPreferences _s = await SharedPreferences.getInstance();
  //   _preferences = _s;
  // }

  saveTransData({
    required String transactionId,
    required String txRef,
    required String status,
    required String ticketType,
    required int ticketPrice,
    required int noOfTickets,
    required String amountPaid,
    required String companyName,
    required String tripNumber,} ) async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    await _preferences.setString("tripNumber", tripNumber);
    await _preferences.setString("companyName", companyName);
    await _preferences.setString("ticketType", ticketType);
    await _preferences.setInt("ticketPrice", ticketPrice);
    await _preferences.setInt("noOfTickets", noOfTickets);
    await _preferences.setString("amountPaid", amountPaid);
    await _preferences.setString("transactionId", transactionId);
    await _preferences.setString("transactionStatus", status);
    await _preferences.setString("txRef", txRef);
  }

  Future<Map> getTransData() async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();

    Map data = {
    "tripNumber" : _preferences.getString("tripNumber") ?? "",
    "companyName" : _preferences.getString("companyName") ?? "",
    "ticketType": _preferences.getString("ticketType") ?? "",
    "ticketPrice": _preferences.getInt("ticketPrice") ?? 0,
    "noOfTickets":  _preferences.getInt("noOfTickets") ?? 0,
    "amountPaid": _preferences.getString("amountPaid") ?? "",
    "transactionId": _preferences.getString("transactionId") ?? "",
    "transactionStatus": _preferences.getString("transactionStatus") ?? "",
    "txRef": _preferences.getString("txRef") ?? ""
  };
    return data;
  }
}