import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MyMap extends StatelessWidget {
  const MyMap({super.key});

  @override
  Widget build(BuildContext context) {
    return  MapScreen();
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Location userLocation = Location();
  late LatLng _userCoordinates = LatLng(37.7749, -122.4194);

  Set<Marker> _markers = {};

  LatLng? _selectedLocation;

  void _onMapTap(LatLng latLng) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('selected-location'),
          position: latLng,
        ),
      );
      _selectedLocation = latLng;
    });
  }

  void _getLocation() async {
    var currentLocation = await userLocation.getLocation();
    setState(() {
      _userCoordinates = LatLng(currentLocation.latitude!, currentLocation.longitude!);
    });
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
          onTap: _onMapTap,
          markers: _markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapToolbarEnabled: true,
          padding: EdgeInsets.only(top: 200.0),
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(37.7749, -122.4194),
            zoom: 12.0,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_selectedLocation != null) {
              print('Selected location: $_selectedLocation');
            }
          },
          child: const Icon(Icons.check),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}
