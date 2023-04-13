import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_geocoder/model.dart';
import 'package:flutter_geocoder/services/base.dart';
import 'package:flutter_geocoder/services/distant_google.dart';
import 'package:flutter_geocoder/services/local.dart';

import '../../Repository/Repository.dart';

class MapUser extends StatefulWidget {
  const MapUser({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapUser> {
  TextEditingController searchController = TextEditingController();
  String? findingPlace;

  late GoogleMapController mapController;
  Location userLocation = Location();
  late LatLng _userCoordinates = LatLng(37.7749, -122.4194);

  Set<Marker> _markers = {};
  LatLng? _selectedLocation;
  Completer<GoogleMapController> _controller = Completer();

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

  @override
  void dispose() {
    super.dispose();
    userLocation.changeSettings(interval: 0);
  }

  void _getLocation() async {
    var currentLocation = await userLocation.getLocation();
    if (mounted) {
      setState(() {
        _userCoordinates =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _goToFindedLocation(
    LatLng address,
  ) async {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: address,
          zoom: 12.0,
        ),
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                  hintText: 'Введите город',
                  suffixIcon: IconButton(
                    onPressed: () async {
                      findingPlace = searchController.text;
                      if (findingPlace != null) {
                        print(findingPlace);
                        LatLng cords =
                            await getCoordinatesFromAddress(findingPlace!);
                        _goToFindedLocation(cords);
                      }
                    },
                    icon: Icon(Icons.search),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(15, 50, 15, 15)),
            ),
            Expanded(
              child: GoogleMap(
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
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_selectedLocation != null) {
              print(getAddressFromCoordinates(
                _selectedLocation!.latitude,
                _selectedLocation!.longitude,
              ));
            }
          },
          child: const Icon(Icons.check),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  Future<LatLng> getCoordinatesFromAddress(String address) async {
    var addresses = await Geocoder.local.findAddressesFromQuery(address);
    var first = addresses.first;
    print(first.coordinates.latitude!);
    print(first.coordinates.longitude!);
    return LatLng(first.coordinates.latitude!, first.coordinates.longitude!);
  }

  Future<void> getAddressFromCoordinates(
      double latitude, double longitude) async {
    final coordinates = new Coordinates(latitude, longitude);
    List<Address> addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    Address first = addresses.first;

    if(context.read<Repository>().fromCityUser == null) {
      context.read<Repository>().setFromCityUser(first.locality);
    }
    else{
      context.read<Repository>().setToCityUser(first.locality);
    }

    // Получаем объект ModalRoute


    print('Страна: ${first.countryName}');
    print('Город: ${first.locality}');
    print('Улица: ${first.thoroughfare}');
    print('дом: ${first.subThoroughfare}');
    Navigator.of(context).pop();
  }
}
