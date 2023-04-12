import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CountryMap extends StatelessWidget {
  const CountryMap({super.key});
  static const routeName = '/country-map';
  @override
  Widget build(BuildContext context) {
    final country = ModalRoute.of(context)!.settings.arguments as CountryArguments;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text(country.name),
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(country.latlng[0], country.latlng[1]),

          ),
          mapType: MapType.satellite,
          minMaxZoomPreference: MinMaxZoomPreference(4, 18),
          markers: <Marker>{
            Marker(
              markerId: MarkerId('marker_1'),
              position: LatLng(country.latlng[0], country.latlng[1]),
              infoWindow: InfoWindow(title: country.name),
            ),
          },
        ));
  }
}

class CountryArguments {
  final String name;
  final List latlng;

  CountryArguments(this.name,this.latlng);
}
