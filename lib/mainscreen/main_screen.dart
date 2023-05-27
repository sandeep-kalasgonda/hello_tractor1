import 'dart:async';
import 'package:driver/assistant/assis_methid.dart';
import 'package:driver/mainscreen/main_screen.dart';
import 'package:driver/authentiction/login_screen.dart';
import 'package:driver/globel/globel.dart';
import 'package:driver/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mainscreen extends StatefulWidget {

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
 final Completer<GoogleMapController> _controllerGoogleMap = Completer();
 late GoogleMapController newGoogleMapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(),
        drawer: Container(
        width: 265,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.black,
          ),
          child: MyDrawer(
            name: userModelCurrentInfo!.name,
            email: userModelCurrentInfo!.email,
          ),
        ),
      ), // or any fallback widget

      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller){
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
            },
          ),
      Positioned(
        top: 36,
        left: 22,
        child: GestureDetector(
          onTap: (){
             
          },
          child: const CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.menu,
              color: Colors.black54,
            ),
          ),
        ),
      ),
        ],
      ),
    );
  }
}