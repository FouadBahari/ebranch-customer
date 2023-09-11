import 'dart:io';
import 'package:geocoding/geocoding.dart' as geocoding;
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import 'config.dart';


class LocationService {

  static Future<LatLng> getLocationByPlaceId (String placeId) async {

    try {

      GoogleMapsPlaces googleMapsPlaces = GoogleMapsPlaces(
          apiKey: Platform.isAndroid?Config.googleApiAndroid:Config.googleApiIOS
      );

      PlacesDetailsResponse placesDetailsResponse = await googleMapsPlaces.getDetailsByPlaceId(placeId);

      Location location = placesDetailsResponse.result.geometry!.location;

      return LatLng(location.lat, location.lng,);

    }catch (e) {

      return Future.error(e);

    }

  }

  static Future<geocoding.Placemark> getPlaceMark (LatLng latLng) async {

    try {

      List<geocoding.Placemark> placeMarks = await geocoding.placemarkFromCoordinates(
        latLng.latitude, latLng.longitude,
        // localeIdentifier: 'ar_SA'
      );

      geocoding.Placemark placemark = placeMarks[0];

      return placemark;

    }catch (e) {

      return Future.error(e);

    }

  }

  static Future<String> getAddress (LatLng location) async {

    geocoding.Placemark placemark = await getPlaceMark(location);

    String place = (placemark.country!.isNotEmpty ? placemark.country! + ', ' : '') +
        (placemark.administrativeArea!.isNotEmpty ? placemark.administrativeArea! + ', ' : '') +
        (placemark.subLocality!.isNotEmpty ? placemark.subLocality! + ', ' : '') +
        (placemark.street!.isNotEmpty ? placemark.street! + ', ' : '');

    place = place.isNotEmpty ? place.replaceFirst(', ', '', place.lastIndexOf(', ')) : '';

    return place;

  }

}