import 'package:flutter/material.dart';
import 'package:bus_stop/models/busCompany.dart';
import 'package:bus_stop/models/destination/destination.dart';
import 'package:bus_stop/models/trip.dart';


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
      notifyListeners();
    }
  }
}
