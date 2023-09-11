import 'dart:convert';

import 'package:e_branch_customer/screens/pickuplocationmap_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/components.dart';
import '../helpers/config.dart';
import '../helpers/helperfunctions.dart';
import '../helpers/navigations.dart';
import '../models/authmodels/user_model.dart';
import '../providers/home_provider.dart';
import '../states/homes_states.dart';
import 'drawer_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var addressController = TextEditingController();

  // LatLng location = LatLng(20, 20);

  String type = "home";
  String address = "";
  var copounController = TextEditingController();

  var copoun = "0";

  @override
  void initState() {
    // location = Provider.of<HomeProvider>(context, listen: false).getPosition!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(text: "السلة",
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios), onPressed: () {
              Navigator.pop(context);
            }),
            actions: []),
        endDrawer: DrawerScreen(),
        body: Container(
            width: MediaQuery
                .sizeOf(context)
                .width,
            height: MediaQuery
                .sizeOf(context)
                .height,
            child:
            // StreamBuilder(
            //             stream: FirebaseFirestore.instance
            //                 .collection("customers")
            //                 .doc(FirebaseAuth.instance.currentUser!.uid)
            //                 .collection('cart')
            //                 .snapshots(),
            //             builder: (context,
            //                 AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            //               if (snapshot.connectionState == ConnectionState.waiting) {
            //                 return Center(
            //                   child: CircularProgressIndicator(
            //                     color: Colors.white,
            //                   ),
            //                 );
            //               }
            //               return snapshot.data!.docs.length==0?Center(child: CustomText(text: "لا يوجد منتجات", fontSize: 18, textDecoration: TextDecoration.none,)):ListView.builder(
            //                   itemCount:snapshot.data!.docs.length,
            //                   itemBuilder: ((context, index) {
            //                     return
            Consumer<HomeProvider>(builder: (context, homeProvider, child) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CartCard(
                            context: context,
                            index: index,
                            text: homeProvider.cartModel!.data![index].name!,
                            desc: homeProvider.cartModel!.data![index]
                                .description!,
                            // offer: homeProvider.cartModel!.data![index].offer ==
                            //     null ? homeProvider.cartModel!.data![index]
                            //     .price.toString() : (double.parse(
                            //     homeProvider.cartModel!.data![index].price
                            //         .toString()) - (double.parse(
                            //     homeProvider.cartModel!.data![index].price
                            //         .toString()) * (double.parse(
                            //     homeProvider.cartModel!.data![index].offer
                            //         .toString()) / 100)))
                            //     .toString(), /* snapshot.data!.docs[index]["postTitle"],image:snapshot.data!.docs[index]["postPic"],desc:snapshot.data!.docs[index]["postDesc"],price:snapshot.data!.docs[index]["postPrice"]*/
                            onIncrement: () {
                              if (homeProvider.quantities[index] !=
                                  homeProvider.cartModel!.data![index]
                                      .amount) {
                                homeProvider.changeQuantity(index,
                                    homeProvider.quantities[index] + 1);
                                homeProvider.addToTotal(
                                    homeProvider.cartModel!.data![index]
                                        .offer == null
                                        ? homeProvider.cartModel!.data![index]
                                        .price
                                        : (double.parse(
                                        homeProvider.cartModel!.data![index]
                                            .price.toString()) -
                                        (double.parse(homeProvider.cartModel!
                                            .data![index]
                                            .price.toString()) *
                                            (double.parse(
                                                homeProvider.cartModel!
                                                    .data![index]
                                                    .offer.toString()) /
                                                100))));
                              }
                            },
                            price: homeProvider.cartModel!.data![index].offer ==
                                null ? homeProvider.cartModel!.data![index]
                                .price! : (homeProvider.cartModel!.data![index]
                                .price! -
                                (homeProvider.cartModel!.data![index].price! *
                                    homeProvider.cartModel!.data![index]
                                        .offer! / 100)),
                            onDecrement: () {
                              if (homeProvider.quantities[index] != 1) {
                                homeProvider.changeQuantity(index,
                                    homeProvider.quantities[index] - 1);
                                homeProvider.removeFromTotal(
                                    homeProvider.cartModel!.data![index]
                                        .offer == null
                                        ? homeProvider.cartModel!.data![index]
                                        .price
                                        : (double.parse(
                                        homeProvider.cartModel!.data![index]
                                            .price.toString()) -
                                        (double.parse(homeProvider.cartModel!
                                            .data![index]
                                            .price.toString()) *
                                            (double.parse(
                                                homeProvider.cartModel!
                                                    .data![index]
                                                    .offer.toString()) /
                                                100))));
                              }
                            },
                            qty: homeProvider.quantities[index],
                            onTapDeleteItem: () async {
                              Map response = await homeProvider
                                  .removeCartItem(
                                  homeProvider.cartModel!.data![index].id);
                              toast(response['msg'], context);
                              if (response['status']) {
                                // homeProvider.getCartData();
                              }
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10,);
                        },
                        itemCount: homeProvider.cartModel!.data!.length
                    ),
                    Row(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 10),
                        //   child: CustomText(
                        //     textDecoration: TextDecoration.none,
                        //     text: "الإجمالي : ${double.parse(
                        //         snapshot.data!.docs[index]["postPrice"]) *
                        //         snapshot.data!.docs.length}",
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w600,),
                        // ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 230,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: RadioListTile(
                                  value: 0,
                                  groupValue: homeProvider.shippingType,
                                  onChanged: (value) {
                                    homeProvider.changeShippingType(value);
                                    setState(() {
                                      type = "home";
                                    });
                                  },
                                  title: CustomText(
                                      textDecoration: TextDecoration.none,
                                      text: "استلام من الفرع",
                                      fontSize: 16),
                                  activeColor: Config.mainColor,
                                  contentPadding: EdgeInsets.zero,),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              width: 230,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: RadioListTile(
                                  value: 1,
                                  groupValue: homeProvider.shippingType,
                                  onChanged: (value) {
                                    homeProvider.changeShippingType(value);
                                    setState(() {

                                    });
                                  },
                                  title: CustomText(
                                      textDecoration: TextDecoration.none,
                                      text: "توصيل للمنزل",
                                      fontSize: 16),
                                  subtitle: CustomText(
                                    text: "سعر الشحن ${(type == "driver"
                                        ? homeProvider.cartModel!.price
                                        : homeProvider.cartModel!.price2)} ر.س",
                                    fontSize: 11,
                                    color: Colors.grey,
                                    textDecoration: TextDecoration.none,),
                                  activeColor: Config.mainColor,
                                  contentPadding: EdgeInsets.zero,),
                              ),
                            ),
                          ],
                        )


                      ],
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: InkWell(
                        onTap: () async {
                          await showDialog(
                              context: context, builder: (context) {
                            return AlertDialog(
                              title: CustomText(
                                  textDecoration: TextDecoration.none,
                                  text: "اكتب كود الخصم",
                                  fontSize: 16),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: [
                                    TextField(controller: copounController,
                                      textAlign: TextAlign.right,),
                                    const SizedBox(height: 20,),
                                    CustomButton(text: "حفظ", onPressed: () {
                                      copoun = copounController.text;
                                      Navigator.pop(
                                          context);
                                    }, color: Config.buttonColor,)
                                  ],
                                ),
                              ),
                            );
                          });
                          if (copoun == null) {
                            copoun = "0";
                          }
                          setState(() {});
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomText(textDecoration: TextDecoration.none,
                              text: "استخدام كود خصم $copoun",
                              fontSize: 16,
                              color: Config.mainColor,),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    if(homeProvider.shippingType == 1)
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CustomInput(
                          controller: addressController,
                          hint: "حدد الموقع",
                          readOnly: true,
                          textInputType: TextInputType.text,
                          onTap: () async {
                            Position position = await determinePosition();
                            List result = await Navigation.mainNavigator(
                                context, PickLocationMapScreen(
                              lat: position.latitude,
                              lang: position.longitude,
                              typeScreen: '',));
                            address = result[0];
                            var location = result[1];
                            if (type == "home") {
                              double dictance = Geolocator.distanceBetween(
                                  double.parse(location.latitude.toString()),
                                  double.parse(location.longitude.toString()),
                                  double.parse(homeProvider.cartModel!.vendor!.lat!),
                                  double.parse(homeProvider.cartModel!.vendor!.lang!)
                              );

                              print('Distance---------------------------------------'+dictance.toString());

                              if (dictance >= 40 * 1000) {
                                type = "charger";
                              } else {
                                type = "driver";
                              }
                              print(
                                  'type: -------------------------------------- $type');
                              setState(() {});
                            }
                            addressController.text = address;
                            print(location);
                          },
                          suffixIcon: Icon(Icons.map),
                          prefixIcon: SizedBox.shrink(),
                          onChange: (String) {},
                          maxLines: 1,),
                      ),
                    if(type != "home" && homeProvider.getPosition != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomText(textDecoration: TextDecoration.none,
                              text: "سعر الشحن ${type == "driver"
                                  ? homeProvider.cartModel!.price ?? 0
                                  : homeProvider.cartModel!.price2 ?? 0} ر.س",
                              fontSize: 14,
                              color: Config.mainColor,),
                          ],
                        ),
                      ),
                    const SizedBox(height: 10,),
                    CustomText(
                        textDecoration: TextDecoration.none,
                        text: "المجموع النهائي:${(homeProvider.gettotalPrice() +(type =="home"?0:
                            (type == "driver"
                                ? homeProvider.cartModel!.price
                                : homeProvider.cartModel!.price2)))}ر.س",
                        fontSize: 16),
                    SizedBox(height: 10,),

                    HomeStates.makeOrderState != MakeOrderState.LOADING ?
                    Consumer<HomeProvider>(
                        builder: (context, homeprovider, _) {
                          return
                            CustomButton(text: "ارسال الطلب",
                                verticalPadding: 10,
                                color: Config.mainColor,
                                horizontalPadding: Config.responsiveWidth(
                                    context) * 0.37,
                                onPressed: () async {
                                  print(
                                      "homeProvider.shippingType  : ${homeProvider
                                          .shippingType}");
                                  if (homeProvider.shippingType == 0) {
                                    // String orderid = FirebaseAuth.instance
                                    //     .currentUser!.uid[0]
                                    //     .toLowerCase()
                                    //     .codeUnits[0] >
                                    //     snapshot.data!.docs.first["postDesc"]
                                    //         .toLowerCase()
                                    //         .codeUnits[0]
                                    //     ? "${FirebaseAuth.instance
                                    //     .currentUser!.uid}${snapshot.data!
                                    //     .docs.first["postDesc"]}"
                                    //     : "${snapshot.data!.docs
                                    //     .first["postDesc"]}${FirebaseAuth
                                    //     .instance.currentUser!.uid}";
                                    // await FirebaseFirestore.instance
                                    //     .collection("customers").doc(
                                    //     FirebaseAuth.instance.currentUser!
                                    //         .uid).
                                    // collection("orders").doc(orderid).
                                    // set({
                                    //   "type": data.shippingType,
                                    //   "image": snapshot.data!.docs
                                    //       .first["postPic"],
                                    //   "name": snapshot.data!.docs
                                    //       .first["postTitle"]
                                    // });
                                  } else {
                                    if (homeProvider.getPosition == null) {
                                      return toast(
                                          "من فضلك حدد موقعك", context);
                                    }
                                  }
                                  Map<String, dynamic> mapResponse = jsonDecode(
                                      await getSavedString("userData", ""));
                                  Data model = Data.fromJson(mapResponse);
                                  print('${homeProvider.cartModel!.vendor!.address}');
                                  Map formData = {
                                    "product_id": homeProvider.productIds
                                        .join(","),
                                    "vendor_id": homeProvider.cartModel!.vendor!.id.toString(),
                                    "amount": homeProvider.quantities.join(
                                        ","),
                                    "color": homeProvider.colors.join(
                                        ","),
                                    "size": homeProvider.sizes.join(
                                        ","),
                                    "price": homeProvider.gettotalPrice().toString(),
                                    "shipping_price": type == "driver"
                                        ? homeProvider.cartModel!.price
                                        .toString()
                                        : homeProvider.cartModel!.price2
                                        .toString(),
                                    "type": type.toString(),
                                    "address": address.toString() == "" ? homeProvider.getAddress.toString():address.toString(),
                                    'vendor_name':homeProvider.cartModel!.vendor!.name.toString(),
                                    'vendor_phone':homeProvider.cartModel!.vendor!.phone.toString(),
                                    'username':model.name.toString(),
                                    'userphone':model.phone.toString(),
                                    'vendor_address':homeProvider.cartModel!.vendor!.address.toString(),
                                    'vendor_lat':homeProvider.cartModel!.vendor!.lat.toString(),
                                    'vendor_lang':homeProvider.cartModel!.vendor!.lang.toString(),
                                    "lat": homeProvider.getPosition == null
                                        ? ""
                                        : homeProvider.getPosition!
                                        .latitude.toString(),
                                    "lang": homeProvider.getPosition == null
                                        ? ""
                                        : homeProvider.getPosition!
                                        .longitude.toString(),
                                    "coupon": copoun,
                                  };
                                  Map response = await homeProvider.makeOrder(
                                      formData);
                                  // toast(response['msg'], context);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(response['msg']),
                                    duration: Duration(seconds: 1),));
                                });
                        })
                        : const SizedBox()
                  ],
                ),
              );
            })));
    //       }));
    // }),
    //       )
    //
    //  ),
    // );
  }
}