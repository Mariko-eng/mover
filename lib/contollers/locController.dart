import 'package:get/get.dart';
import 'package:bus_stop/models/busCompany.dart';
import 'package:bus_stop/models/destination/destination.dart';
import 'package:bus_stop/models/trip.dart';

class LocationController extends GetxController {
  RxString error = "".obs;
  RxBool isTripsLoading = false.obs;
  RxBool isTripsError = false.obs;
  RxBool isCompaniesLoading = false.obs;
  RxBool isCompaniesError = false.obs;

  RxList<Trip> trips = <Trip>[].obs;
  RxList<Destination> destinations = <Destination>[].obs;
  RxList<BusCompany> companies = <BusCompany>[].obs;


  @override
  void onReady () {
    // _fetchDestinations();
  }

  getDestinations() async{
    try{
      List<Destination> results = await fetchDestinations();
      destinations.value = results;
      // print("destinations");
      // print(destinations);
    }catch (err){
      print(err);
      destinations.value = [];
    } finally{
      print("Finally Destinations!");
    }
  }

  activeTrips() async{
    isTripsLoading.value = true;
    isTripsError.value = false;
    try{
      List<Trip> results = await fetchActiveTrips();
      trips.value = results;
    }catch (err){
      print( err.toString());
      trips.value = [];
      isTripsError.value = true;
    }finally{
      print("Finally Trips!");
      isTripsLoading.value = false;
    }
  }

  busCompanies() async{
    isCompaniesLoading.value = true;
    isCompaniesError.value = false;
    try{
      List<BusCompany> results = await fetchBusCompanies();
      companies.value = results;
      isCompaniesLoading.value = false;
    }catch (err){
      print( err.toString());
      companies.value = [];
      isCompaniesLoading.value = false;
      isCompaniesError.value = true;
    }
  }

}