import 'dart:async';

import 'package:blood_bank_fyp/utils/toastMassage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Google_Map_Location extends StatefulWidget {
  double src_latitude;
  double src_longitude;
   Google_Map_Location({Key? key,required this.src_latitude,required this.src_longitude}) : super(key: key);

  @override
  State<Google_Map_Location> createState() => _Google_Map_LocationState();
}

class _Google_Map_LocationState extends State<Google_Map_Location> {
  // double? lititudecon;
  // double? longitudecon;
  final Completer<GoogleMapController> _controller = Completer();
  // LocationData? currentlocation;
// We will get User Current Location through this function

  // Future<Position> _getLocation() async {
  //   await Geolocator.requestPermission()
  //       .then((value) {})
  //       .onError((error, stackTrace) async {
  //     await Geolocator.requestPermission();
  //     print("Error" + error.toString());
  //   });
  //   return Geolocator.getCurrentPosition();
  //
  // }

  // void _getployPoint() async{
  //   PolylinePoints ploylinePoint = PolylinePoints();
  //   PolylineResult result = await ploylinePoint.getRouteBetweenCoordinates(
  //       'AIzaSyA5rZaNY__Vs62yoWqdxoorMbn-8mqlkT0',
  //       PointLatLng(widget.src_latitude,widget.src_longitude),
  //       // PointLatLng(_destination.latitude,_destination.longitude),
  //       PointLatLng(lititudecon!.toDouble(),longitudecon!.toDouble())
  //   );
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach((PointLatLng pointLatLng) =>
  //         _ployCoordinates.add(
  //             LatLng(pointLatLng.latitude, pointLatLng.longitude)
  //         )
  //     );
  //     setState(() {
  //
  //     });
  //   }
  // }
  // final Set<Polyline> _polyline = {};
  // List<LatLng> _polyCoordinates = [];
  // GoogleMapPolyline _googleMapPolyline = GoogleMapPolyline(apiKey: 'AIzaSyA5rZaNY__Vs62yoWqdxoorMbn-8mqlkT0');
  //
  // _getPoints() async{
  //   _polyCoordinates = (await _googleMapPolyline.getCoordinatesWithLocation(
  //       origin: LatLng(widget.src_latitude, widget.src_longitude),
  //       destination:LatLng((lititudecon,longitudecon)),
  //       mode: RouteMode.driving))!;
  // }
  //
  //
  // void _mapcreated(GoogleMapController controller)async{
  //   setState(() {
  //     _controller.complete(controller);
  //     _polyline.add(
  //         Polyline(
  //             polylineId: PolylineId('route1'),
  //             points: _polyCoordinates,
  //             visible: true,
  //             width: 3,
  //             color: Colors.blue,
  //             startCap: Cap.roundCap,
  //             endCap: Cap.buttCap
  //         )
  //     );
  //   });
  // }
  // void getuserlocation(){
  //   Location location = Location();
  //   location.getLocation().then((location) {
  //     currentlocation = location;
  //   });
  // }
  // static const String google_api_key = 'AIzaSyA5rZaNY__Vs62yoWqdxoorMbn-8mqlkT0';
  static const String google_api_key = 'AIzaSyDw9decax7nCHHPqCP4Xgzre6yvu9Tm_nU';
  List<LatLng> _ployCoordinates = [];
  LocationData? currentlocation;


  void _getployPoint() async{
    PolylinePoints ploylinePoint = PolylinePoints();
    PolylineResult result = await ploylinePoint.getRouteBetweenCoordinates(
        google_api_key,
        PointLatLng(widget.src_latitude, widget.src_longitude),
        PointLatLng(currentlocation!.latitude!,currentlocation!.longitude!)
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng pointLatLng) =>
          _ployCoordinates.add(
              LatLng(pointLatLng.latitude, pointLatLng.longitude)
          )
      );
      setState(() {

      });
    }
  }

  void getcurrentlocation ()async{
    Location location = Location();
    location.getLocation().then((location){
      setState(() {
        currentlocation = location;
      });
    });
    // GoogleMapController googleMapController = await _controller.future;
    // location.onLocationChanged.listen((newLoc) {
      // currentlocation = newLoc;
      // googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      //     CameraPosition(target: LatLng(newLoc.latitude!, newLoc.longitude!),zoom: 14)
      // ));
    // });
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcurrentlocation();
    _getployPoint();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:currentlocation==null? Center(child: CircularProgressIndicator(),):
     GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(25.5065, 69.0136),zoom: 14),
       polylines: {
         Polyline(
             polylineId: PolylineId('route'),
             points: _ployCoordinates,
         )
       },
        markers: {
          Marker(
            markerId: MarkerId('Source'),
            infoWindow: InfoWindow(title: 'Destination'),
            position:LatLng(widget.src_latitude, widget.src_longitude),
            icon: BitmapDescriptor.defaultMarker
          ),
          Marker(
          markerId: MarkerId('current'),
          infoWindow: InfoWindow(title: 'your Location'),
          position: LatLng(currentlocation!.latitude!,currentlocation!.longitude!)
          ,icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue
          )
          )
        },
        onMapCreated: ((controller) {
          _controller.complete(controller);
        }),
      ),
    );
  }
}
