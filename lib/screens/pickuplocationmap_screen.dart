import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../components/components.dart';
import '../helpers/config.dart';
import '../helpers/helperfunctions.dart';
import '../helpers/locationservices.dart';
import '../providers/home_provider.dart';

class PickLocationMapScreen extends StatefulWidget {
  double lat,lang;
  String typeScreen;
  PickLocationMapScreen({Key? key,required this.lat,required this.lang,required this.typeScreen}) : super(key: key);

  @override
  _PickLocationMapScreenState createState() => _PickLocationMapScreenState();
}

class _PickLocationMapScreenState extends State<PickLocationMapScreen> {
  late GoogleMapController googleMapController;
  late CameraPosition _initialCameraPosition;

  var searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialCameraPosition = CameraPosition(target: LatLng(widget.lat,widget.lang), zoom: 8);
    Future.delayed(Duration(seconds: 0),()async{
      if(widget.typeScreen==null) {
       Provider.of<HomeProvider>(context, listen: false).setAddress("");
       // Provider.of<HomeProvider>(context, listen: false).setPosition();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(

        child: Stack(

          alignment: AlignmentDirectional.center,

          children: [

            SizedBox.expand(

              child: _initialCameraPosition != null ?
              FutureBuilder(
                future: Future.delayed(Duration(milliseconds: 300), () => true),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return GoogleMap(
                      initialCameraPosition: _initialCameraPosition,
                      onMapCreated: (map){
                        googleMapController = map;
                      },
                      myLocationButtonEnabled: false,
                      myLocationEnabled: true,
                      onCameraMove: (CameraPosition position) {
                        Provider.of<HomeProvider>(context, listen: false).setPosition(position.target);
                      },
                    );
                  }
                  return SizedBox();
                },
              )
                  : SizedBox(),

            ),

            SizedBox.expand(
              child: Center(
                  child: Icon(Icons.location_on,color: Config.mainColor,size: 30,)
              ),
            ),

            Positioned(
              top: 60,
              right: 10,
              child: Row(
                children: [
                  Container(
                    color: Colors.white,
                    width: Config.responsiveWidth(context)*0.7,
                    child: CustomInput(controller: searchController, hint: "ابحث عن موقع", textInputType: TextInputType.text,onChange: (v) async {
                      print(v);
                      var addresses = await locationFromAddress(v);//locationFromAddress.findAddressesFromQuery(v);
                      print(addresses);
                      var first = addresses.first;
                      Provider.of<HomeProvider>(context, listen: false).setPosition(LatLng(addresses.first.latitude, addresses.first.longitude));
                      if (Provider.of<HomeProvider>(context, listen: false).getPosition != null) {
                        googleMapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                                CameraPosition(target: LatLng(Provider.of<HomeProvider>(context, listen: false).getPosition!.latitude, Provider.of<HomeProvider>(context, listen: false).getPosition!.longitude), zoom: 16)
                            )
                        );
                      }
                    //  print("${first.featureName} : ${first.coordinates}");
                    }, onTap: () {  }, prefixIcon: Container(), suffixIcon: Container(), maxLines: 1,),
                  ),
                  SizedBox(width: 15,),
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: IconButton(
                      color: Config.mainColor,
                      icon: Icon(Icons.my_location),
                      onPressed: () async {

                        Position currentLocation = await determinePosition();

                        if (currentLocation != null) {
                          googleMapController.animateCamera(
                              CameraUpdate.newCameraPosition(
                                  CameraPosition(target: LatLng(currentLocation.latitude, currentLocation.longitude), zoom: 16)
                              )
                          );
                        }

                      },
                    ),
                  ),


                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(text: context.watch<HomeProvider>().getAddress,textAlign: TextAlign.center, fontSize: 16, textDecoration: TextDecoration.none,),
                    const Spacer(),
                    CustomButton(text: "تحديد", verticalPadding: 10,color: Config.mainColor,horizontalPadding: Config.responsiveWidth(context)*0.4,onPressed: () async {
                      String address = await LocationService.getAddress(LatLng(Provider.of<HomeProvider>(context, listen: false).getPosition!.latitude, Provider.of<HomeProvider>(context, listen: false).getPosition!.longitude));
                     Provider.of<HomeProvider>(context,listen: false).setAddress(address);
                     // context.read<HomeProvider>().setPosition(_currentLocation);
                      Navigator.pop(context,[context.read<HomeProvider>().getAddress,context.read<HomeProvider>().getPosition]);
                    },)
                  ],
                ),
              ),
            )
          ],
        ),

      ),
    );
  }

}