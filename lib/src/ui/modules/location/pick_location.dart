import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

class PickLocationFromMap extends StatefulWidget {
  const PickLocationFromMap({Key? key}) : super(key: key);

  @override
  State<PickLocationFromMap> createState() => _PickLocationFromMapState();
}

class _PickLocationFromMapState extends State<PickLocationFromMap> {

  final PickLocationController _controller = Get.find();
  final homeScaffoldKey = GlobalKey<ScaffoldState>();


  getCurrentLocation() async {
    Position position = await _controller.determinePosition();
    _controller.googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 14)));
    _controller.markers.clear();
    setState(() {
      _controller.markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(position.latitude, position.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)));
      _controller.getAddressFromCurrentPosition(position);
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Map data = {
          "lat" : _controller.lat.value,
          "long" : _controller.long.value,
          "address" : _controller.address.value
        };
        Get.back(result: data);
        return true;
      },
      child: Scaffold(
        key: homeScaffoldKey,
        body: Obx(() =>
            ModalProgress(
              call: _controller.isLoading.value,
              child: SafeArea(
                child: Column(
                  children: [
                    CustomAppBar(
                      title: "Location",
                      showLeadingIcon: true,
                      leadingIconPressed: () {
                        Map data = {
                          "lat" : _controller.lat.value,
                          "long" : _controller.long.value,
                          "address" : _controller.address.value
                        };
                        Get.back(result: data);
                        } ,
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

                            onCameraIdle: (){
                              setState(() {
                                _controller.markers.add(Marker(markerId: const MarkerId('newLocation'),position: LatLng(_controller.lat.value, _controller.long.value),
                                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan)));
                                _controller.getAddressFromLatLong(_controller.lat.value, _controller.long.value);
                              });
                            },
                            onCameraMove: (latlng){
                              if(kDebugMode) {
                                print('${latlng.target.latitude} +"  "+${latlng.target.longitude}');
                              }
                              _controller.lat.value = latlng.target.latitude;
                              _controller.long.value = latlng.target.longitude;
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

                          _controller.address.value == '' ? SizedBox() : Positioned(
                            top: MediaQuery.of(context).size.height * 0.65,
                            right: 30,
                            left: 20,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0,right: 20),
                              child: Container(
                                // height: MediaQuery.of(context).size.height * 0.08,
                                width: MediaQuery.of(context).size.width ,
                                padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child:Center(child: smallText(_controller.address.value,overflow: TextOverflow.visible,size: 12,clr: Colors.white,)) ,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        )
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
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.white))),
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

    setState(() {
      _controller.lat.value = lat;
      _controller.long.value = lng;
      _controller.markers.add(Marker(markerId: const MarkerId("newLocation"),position: LatLng(lat, lng),
          infoWindow: InfoWindow(title: detail.result.name), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet)));
    });
    _controller.getAddressFromLatLong(lat, lng);
    _controller.googleMapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }
}
