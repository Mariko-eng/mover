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
  }

  getDestinations() async{
    try{
      List<Destination> results = await fetchDestinations();
      destinations.value = results;
    }catch (err){
      destinations.value = [];
    } finally{
    }
  }

  activeTrips() async{
    isTripsLoading.value = true;
    isTripsError.value = false;
    try{
      List<Trip> results = await fetchActiveTrips();
      trips.value = results;
    }catch (err){
      trips.value = [];
      isTripsError.value = true;
    }finally{
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
      companies.value = [];
      isCompaniesLoading.value = false;
      isCompaniesError.value = true;
    }
  }
}