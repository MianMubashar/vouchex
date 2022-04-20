import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

class PickLocationFromMap extends StatelessWidget {
   PickLocationFromMap({Key? key}) : super(key: key);

   final PickLocationController _controller = Get.find();
   final homeScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Location",
              showLeadingIcon: true,
              leadingIconPressed: () {Get.back();} ,
            ),
            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: _controller.initialCameraPosition,
                    markers: _controller.markers,
                    mapType: MapType.normal,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.googleMapController = controller;
                    },
                    onTap: (latlng){
                      if(kDebugMode) {
                        print('${latlng.latitude} +"  "+${latlng.longitude}');
                      }
                      _controller.lat.value=latlng.latitude;
                      _controller.long.value=latlng.longitude;
                    },
                  ),
                  InkWell(
                    onTap: () async {
                      await handlePressButton();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 1,
                              color: const Color.fromRGBO(0, 0, 0, 0.1)
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.search),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: smallText('Search places...'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

   Future<void> handlePressButton() async {
     Prediction? p = await PlacesAutocomplete.show(
         context: Get.context!,
         apiKey: _controller.kGoogleApiKey,
         onError: onError,
         mode: _controller.mode,
         language: 'en',
         strictbounds: false,
         types: [""],
         decoration: InputDecoration(
             hintText: 'Search',
             focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white))),
         components: [Component(Component.country,"pk"),Component(Component.country,"usa")]);


      displayPrediction(p!,homeScaffoldKey.currentState);
   }

   void onError(PlacesAutocompleteResponse response){
      homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!)));
   }

   Future<void> displayPrediction(Prediction p, ScaffoldState? currentState) async {

     GoogleMapsPlaces places = GoogleMapsPlaces(
         apiKey: _controller.kGoogleApiKey,
         apiHeaders: await const GoogleApiHeaders().getHeaders()
     );

     PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

     final lat = detail.result.geometry!.location.lat;
     final lng = detail.result.geometry!.location.lng;

     _controller.markers.clear();
     _controller.markers.add(Marker(markerId: const MarkerId("newLocation"),position: LatLng(lat, lng),infoWindow: InfoWindow(title: detail.result.name)));


     _controller.googleMapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));

   }
}
