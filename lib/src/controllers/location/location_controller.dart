import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';


class PickLocationController extends GetxController {
  var isLoading = false.obs;

  var lat = 37.42796133580664.obs;
  var long = 122.085749655962.obs;

  var kGoogleApiKey = 'AIzaSyBsMhCxC7WU4S9xsJ7MGP6PeRObctNwzCc';
  var address = ''.obs;

  late GoogleMapController googleMapController;
  CameraPosition initialCameraPosition = const CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  Set<Marker> markers = {};

  final Mode mode = Mode.overlay;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();
    lat.value = position.latitude;
    long.value = position.longitude;
    return position;
  }



  Future<void> getAddressFromCurrentPosition(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    address.value = '${place.street} ${place.subLocality} ${place.locality} ${place.postalCode} ${place.country}';
   // Get.snackbar("Location", address.value, colorText: Colors.white, backgroundColor: Colors.black, snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> getAddressFromLatLong(lat, long)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    print(placemarks);
    Placemark place = placemarks[0];
    address.value = '${place.street} ${place.subLocality} ${place.locality} ${place.postalCode} ${place.country}';
   // Get.snackbar("Location", address.value, colorText: Colors.white, backgroundColor: Colors.black, snackPosition: SnackPosition.BOTTOM);
  }
}