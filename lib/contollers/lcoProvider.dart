import 'package:bus_stop/models/busCompany.dart';
import 'package:bus_stop/models/destination.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:flutter/cupertino.dart';

class LocationsProvider extends ChangeNotifier {
  List<Destination> destinations = [];
  bool isTripsLoading = false;
  bool isTripsError = false;
  List<Trip> trips = <Trip>[];
  bool isLoadingCompanies = false;
  bool isCompaniesError = false;
  List<BusCompany> companies = <BusCompany>[];
  Destination? _destinationFrom;
  Destination? _destinationTo;

  Destination? get destinationFrom => _destinationFrom;

  Destination? get destinationTo => _destinationTo;

  setDestinationFrom(Destination dest) {
    _destinationFrom = dest;
    notifyListeners();
  }

  setDestinationTo(Destination dest) {
    _destinationTo = dest;
    notifyListeners();
  }

  LocationsProvider() {
    _init();
  }

  _init() async{
    try{
      List<Destination> results = await fetchDestinations();
      destinations = results;
    }catch (err){
      print(err);
      destinations = [];
    } finally{
      print("Finally Destinations!");
      notifyListeners();
    }
  }



  // _getDestinations() {
  //   print("Here : _getDestinations");
  //   getDestinations().listen((List<Destination> results) {
  //     print("results");
  //     print(results);
  //     destinations = results;
  //     notifyListeners();
  //   }).onError((e) {
  //     print("Error : " + e.toString());
  //     destinations = [];
  //     notifyListeners();
  //   });
  // }
}
