import 'package:bus_stop/models/busCompany.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  RxString error = "".obs;
  RxBool isTripsLoading = false.obs;
  RxBool isTripsError = false.obs;
  RxBool isCompaniesLoading = false.obs;
  RxBool isCompaniesError = false.obs;

  RxList<Trip> trips = <Trip>[].obs;
  RxList<BusCompany> companies = <BusCompany>[].obs;


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