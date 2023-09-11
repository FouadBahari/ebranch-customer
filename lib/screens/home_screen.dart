import 'package:another_flushbar/flushbar.dart';
import 'package:e_branch_customer/models/home_models/chat_model.dart';
import 'package:e_branch_customer/screens/merchant_screen.dart';
import 'package:e_branch_customer/screens/productdetails_screen.dart';
import 'package:e_branch_customer/screens/stores_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../components/components.dart';
import '../helpers/config.dart';
import '../helpers/helperfunctions.dart';
import '../helpers/navigations.dart';
import '../models/home_models/categories_model.dart';
import '../models/home_models/markets_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/home_models/products_model.dart';
import '../providers/home_provider.dart';
import '../states/homes_states.dart';
import 'cart_screen.dart';
import 'drawer_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var msgController = TextEditingController();
  var searchController = TextEditingController();
  late GoogleMapController mapController;
  var _formState = GlobalKey<FormState>();

  CategoriesModel? catModel;
  late Position currentPosition;
  ProductsModel? productsModel;
  MarketsModel? marketsModel;
  Set<Marker> _markers = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDataWithinNotification();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      currentPosition = await determinePosition();
      Provider.of<HomeProvider>(context, listen: false).setCurrentPosition(currentPosition);
      Provider.of<HomeProvider>(context, listen: false).getShippingPrices();
      marketsModel = await Provider.of<HomeProvider>(context, listen: false)
          .getMarketsWithLocation(
              currentPosition.latitude, currentPosition.longitude);
      mapController.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(currentPosition.latitude, currentPosition.longitude),
            zoom: 16),
      ));
      for (var element in marketsModel!.vendors!) {
        _markers.add(Marker(

            markerId: MarkerId(element.id.toString()),
            onTap: () async {
              Navigation.mainNavigator(
                  context,
                  MerchantScreen(
                    vendor: element,
                    imageurl: element.photo!,
                    name: element.name!,
                    id: element.id!.toString(),
                  ));
            },
            position: LatLng(double.parse("${element.lat.toString()}"),
                double.parse("${element.lang.toString()}")),
            icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(size: Size(25,25)), "images/logo2.png",
            )));
      }
      setState(() {});
      for(var i in _markers){
        print("_markers ${i.position}");

      }
    });
  }

  // List<String> cats=[
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          text: pageIndex == 0
              ? "ابحث عن متجر"
              : pageIndex == 1
                  ? "الأقسام"
                  : pageIndex == 2
                      ? "منتجات"
                      : "تواصل معنا",
          leading: IconButton(
              icon: Icon(
                Icons.add_shopping_cart,
                color: Color(0xffffffff),
                size: 35,
              ),
              onPressed: () {
                Navigation.mainNavigator(context, CartScreen());
              }),
          actions: []),
      endDrawer: DrawerScreen(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 190.0,
              width: double.infinity,
              child: GoogleMap(
                onMapCreated: onMapCreated,
                initialCameraPosition: CameraPosition(target: LatLng(30, 29)),
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                markers: _markers,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.email,
                        color: pageIndex != 3
                            ? Config.buttonColor
                            : Config.mainColor,
                        size: 30,
                      ),
                      onPressed: () {
                        pageIndex = 3;
                        setState(() {});
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: pageIndex != 2
                            ? Config.buttonColor
                            : Config.mainColor,
                        size: 30,
                      ),
                      onPressed: () async {
                        pageIndex = 2;
                        setState(() {});
                        if (productsModel == null)
                          productsModel = await context
                              .read<HomeProvider>()
                              .getRandomProducts();
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.grid_view,
                        color: pageIndex != 1
                            ? Config.buttonColor
                            : Config.mainColor,
                        size: 30,
                      ),
                      onPressed: () async {
                        pageIndex = 1;
                        setState(() {});
                        if (catModel == null)
                          catModel = await context
                              .read<HomeProvider>()
                              .getCategories();
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.search,
                        color: pageIndex != 0
                            ? Config.buttonColor
                            : Config.mainColor,
                        size: 30,
                      ),
                      onPressed: () {
                        pageIndex = 0;
                        setState(() {});
                      }),
                ],
              ),
            ),
            Container(
              color: Config.buttonColor.withOpacity(0.07),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: Config.responsiveHeight(context) - 380,
                  child: pageIndex == 1
                      ? Consumer<HomeProvider>(
                          builder: (context, homeProvider, child) {
                          if (HomeStates.catState == CatState.LOADING) {
                            return Center(child: CircularProgressIndicator());
                          } else if (catModel!.services!.isEmpty) {
                            return CustomText(
                              text: "لا يوجد أقسام الان",
                              fontSize: 18,
                              textDecoration: TextDecoration.none,
                            );
                          }
                          if (HomeStates.catState == CatState.ERROR) {
                            return Center(
                                child: CustomText(
                              text: "حدث خطأ",
                              fontSize: 16,
                              textDecoration: TextDecoration.none,
                            ));
                          }

                          return Directionality(
                            textDirection: TextDirection.rtl,
                            child: GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              crossAxisSpacing: 30,
                              mainAxisSpacing: 25,
                              childAspectRatio: (150 / 43),
                              children: List.generate(
                                  catModel!.services!.length, (index) {
                                return InkWell(
                                  onTap: () {
                                    Navigation.mainNavigator(
                                        context,
                                        StoresScreen(
                                            catId:
                                                catModel!.services![index].id!,
                                            catName: catModel!
                                                .services![index].name!));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 43,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Color(0xffffffff),
                                        border: Border.all(
                                            color: Config.buttonColor
                                                .withOpacity(0.6),
                                            width: 2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: CustomText(
                                      text: catModel!.services![index].name!,
                                      fontSize: 14,
                                      color: Config.mainColor,
                                      textDecoration: TextDecoration.none,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          );
                        })
                      : pageIndex == 0
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomInput(
                                  controller: searchController,
                                  hint: "اكتب اسم المتجر",
                                  textInputType: TextInputType.text,
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.search,
                                        size: 37,
                                        color: Config.mainColor,
                                      ),
                                      onPressed: () {}),
                                  onTap: () {},
                                  prefixIcon: SizedBox.shrink(),
                                  onChange: (value) async{
                                    if(value.isEmpty || value == null){
                                      marketsModel = await Provider.of<HomeProvider>(context, listen: false)
                                          .getMarketsWithLocation(
                                          currentPosition.latitude, currentPosition.longitude);
                                    }else{
                                      marketsModel = await context.read<HomeProvider>().searchvendors(value);
                                    }
                                  },
                                  maxLines: 1,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),

                                Consumer<HomeProvider>(
                                    builder: (context,  homeProvider, child) {
                                      if (HomeStates.marketsState ==
                                          MarketsState.LOADING || marketsModel == null) {
                                        return  Center(
                                          child: CircularProgressIndicator(),
                                        );

                                      }
                                      else if(HomeStates.marketsState ==
                                          MarketsState.LOADED){
                                        if(marketsModel == null || marketsModel!.vendors!.isEmpty){
                                          toast("لا يوجد فرع بهذا الاسم حاول مرة أخرى", context);
                                          return SizedBox();
                                        }
                                          else{
                                          return Expanded(
                                            child: ListView.separated(
                                                shrinkWrap: true,
                                                itemBuilder: (context,index){
                                                  return InkWell(
                                                    onTap: (){
                                                      Navigation.mainNavigator(context, MerchantScreen(imageurl:marketsModel!.vendors![index].photo! ,name: marketsModel!.vendors![index].name!,id: marketsModel!.vendors![index].id.toString(),vendor: marketsModel!.vendors![index]));
                                                    },
                                                    child: Container(
                                                      height: 200,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(25),
                                                          color: Config.buttonColor
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            height: 30,
                                                            padding: EdgeInsets.symmetric(horizontal: 15),
                                                            alignment: Alignment.centerRight,
                                                            child: CustomText(textDecoration: TextDecoration.none,text: marketsModel!.vendors![index].name!, fontSize: 12,color: Colors.white,),
                                                          ),
                                                          ClipRRect(
                                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
                                                              child: FadeInImage(
                                                                placeholder: AssetImage("images/logo.png"),
                                                                imageErrorBuilder: (context, builder, stackTrace) =>
                                                                    Image.asset("images/logo.png",height: 170,),
                                                                image: NetworkImage(marketsModel!.vendors![index].photo!),
                                                                height: 170,
                                                                width: double.infinity,
                                                                fit: BoxFit.fill,
                                                              ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }, separatorBuilder: (context,index){
                                              return const SizedBox(height: 15,);
                                            }, itemCount: marketsModel!.vendors!.length),
                                          );
                                        }
                                      }
                                      else return SizedBox();
                                    }),
                                // StreamBuilder(
                                //   stream: FirebaseFirestore.instance
                                //       .collection("stores").where("name",isEqualTo:searchController.text.toString()).snapshots(),
                                //   builder: (context,
                                //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                                //     if (snapshot.connectionState == ConnectionState.waiting) {
                                //       return  Center(
                                //         child: CircularProgressIndicator(),
                                //       );
                                //
                                //     }else if( snapshot.data!.docs.length == 0){
                                //        toast("لا يوجد فرع بهذا الاسم حاول مرة أخرى", context);
                                //     }
                                //
                                //     return  CustomButton(text: "بحث",onPressed: (){
                                //
                                //       Navigation.mainNavigator(context, MerchantScreen(imageurl: snapshot.data!.docs.first["imageurl"], name: snapshot.data!.docs.first["name"],));
                                //
                                //     }, color: Colors.transparent,);
                                //   },
                                // ),
                              ],
                            )
                          : pageIndex == 2
                              ?
                              // StreamBuilder(
                              //   stream: FirebaseFirestore.instance
                              //       .collection("specialproducts")
                              //   // .orderBy(
                              //   //   "datePublished",
                              //   //   descending: true,
                              //   // )
                              //       .snapshots(),
                              //   builder: (context,
                              //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                              //     if (snapshot.connectionState == ConnectionState.waiting) {
                              //       return  Center(
                              //         child: CircularProgressIndicator(),
                              //       );
                              //
                              //     }
                              //
                              //     return snapshot.data!.docs.length == 0
                              //         ? CustomText(text: "لا يوجد منتجات الان", fontSize: 18, textDecoration: TextDecoration.none,)
                              //         : Padding(
                              //       padding: const EdgeInsets.all(18.0),
                              //       child: Directionality(
                              //         textDirection: TextDirection.rtl,
                              //         child: GridView.count(
                              //           shrinkWrap: true,
                              //           crossAxisCount: 2,
                              //           crossAxisSpacing: 10,
                              //           mainAxisSpacing: 15,
                              //           childAspectRatio: (Config.responsiveHeight(context)*0.131 / 150),
                              //           children: List.generate(snapshot.data!.docs.length, (index) {
                              //             return ProductCard(name: snapshot.data!.docs[index]["name"],price: snapshot.data!.docs[index]["price"].toString(),image: snapshot.data!.docs[index]["imageurl"],onTap: (){
                              //               Navigation.mainNavigator(context, ProductDetailsScreen(product:snapshot.data!.docs[index], offer: true, fromOrder: false,));
                              //             }, catName:snapshot.data!.docs[index]["category"] , offer: '',);
                              //           }),
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // )
                              Consumer<HomeProvider>(
                                  builder: (context, homeProvider, child) {
                                  if (productsModel == null || marketsModel == null) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (productsModel!.data!.length == 0) {
                                    return CustomText(
                                      text: "لا يوجد منتجات الان",
                                      fontSize: 18,
                                      textDecoration: TextDecoration.none,
                                    );
                                  }
                                  if (HomeStates.marketOffersState ==
                                      MarketOffersState.ERROR) {
                                    return CustomText(
                                      text: "حدث خطأ",
                                      fontSize: 16,
                                      textDecoration: TextDecoration.none,
                                    );
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: GridView.count(
                                        shrinkWrap: true,
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 15,
                                        childAspectRatio:
                                            (Config.responsiveHeight(context) *
                                                0.131 /
                                                160),
                                        children: List.generate(
                                            productsModel!.data!.length,
                                            (index) {
                                              late Vendors vendor;
                                              try{
                                                vendor = marketsModel!.vendors!.firstWhere((element) => element.id == productsModel!.data![index]);

                                              }catch(e){
                                                vendor = marketsModel!.vendors![0];
                                              }

                                          return ProductCard(
                                            name: productsModel!
                                                .data![index].name!,
                                            price: productsModel!
                                                .data![index].price
                                                .toString(),
                                            image: productsModel!
                                                .data![index].photo!,
                                            onTap: () {
                                              Navigation.mainNavigator(
                                                  context,
                                                  ProductDetailsScreen(
                                                    product: productsModel!
                                                        .data![index],
                                                    offer: productsModel!
                                                        .data![index].offer,
                                                    fromOrder: false,
                                                    vendor: vendor,
                                                  ));
                                            },
                                            catName: 'ملابس',
                                            offer: productsModel!
                                                .data![index].offer!,
                                          );
                                        }),
                                      ),
                                    ),
                                  );
                                })
                              : Form(
                                  key: _formState,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        CustomInput(
                                          onTap: () {},
                                          prefixIcon: SizedBox.shrink(),
                                          onChange: (String) {},
                                          maxLines: 1,
                                          controller: nameController,
                                          hint: "الاسم بالكامل",
                                          textInputType: TextInputType.text,
                                          suffixIcon: Icon(
                                            Icons.person,
                                            color: Config.mainColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        CustomInput(
                                          onTap: () {},
                                          prefixIcon: SizedBox.shrink(),
                                          onChange: (String) {},
                                          maxLines: 1,
                                          controller: emailController,
                                          hint: "البريد الإلكتروني",
                                          textInputType:
                                              TextInputType.emailAddress,
                                          suffixIcon: Icon(
                                            Icons.email,
                                            color: Config.mainColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        CustomInput(
                                          onTap: () {},
                                          prefixIcon: SizedBox.shrink(),
                                          onChange: (String) {},
                                          maxLines: 1,
                                          controller: phoneNumberController,
                                          hint: "رقم الهاتف",
                                          textInputType: TextInputType.phone,
                                          suffixIcon: Icon(
                                            Icons.phone,
                                            color: Config.mainColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        CustomInput(
                                            onTap: () {},
                                            prefixIcon: SizedBox.shrink(),
                                            onChange: (String) {},
                                            maxLines: 1,
                                            controller: msgController,
                                            hint: "الرسالة",
                                            textInputType: TextInputType.text,
                                            suffixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 85),
                                              child: Icon(
                                                Icons.chat,
                                                color: Config.mainColor,
                                              ),
                                            )),
                                        const SizedBox(
                                          height: 50,
                                        ),
                                        CustomButton(
                                          text: "ارسال",
                                          onPressed: () async {
                                            // toast("تم الارسال بنجاح", context);
                                            // await FirebaseFirestore.instance
                                            //     .collection("messages")
                                            //     .doc()
                                            //     .set({
                                            //   "sentby": nameController.text,
                                            //   "email": emailController.text,
                                            //   "phoneNo":
                                            //       phoneNumberController.text,
                                            //   "text": msgController.text
                                            // });
                                            // toast("تم الارسال بنجاح", context);
                                            // setState(() {
                                            //   emailController.clear();
                                            //   msgController.clear();
                                            //   phoneNumberController.clear();
                                            //   nameController.clear();
                                            // });
                                            if (_formState.currentState!
                                                .validate()) {
                                              Map response = await context
                                                  .read<HomeProvider>()
                                                  .contactUs({
                                                "name": nameController.text,
                                                "email": emailController.text,
                                                "phone":
                                                    phoneNumberController.text,
                                                "messages": msgController.text
                                              });
                                              toast(response['msg'], context);
                                              if (response['status']) {
                                                nameController.clear();
                                                emailController.clear();
                                                phoneNumberController.clear();
                                                msgController.clear();
                                              }
                                            }
                                          },
                                          color: Colors.transparent,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  fetchDataWithinNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.requestPermission();
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((event) async {
      Flushbar(
        message: event.notification!.body,
        title: event.notification!.title,
        messageColor: Colors.white,
        titleColor: Colors.white,
        textDirection: TextDirection.rtl,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        // maxWidth: double.infinity,
        isDismissible: true,
        duration: const Duration(seconds: 5),
        flushbarPosition: FlushbarPosition.TOP,
        barBlur: .1,
        backgroundColor: Config.mainColor,
        borderColor: Colors.white,
        margin: const EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
      ).show(context);

      catModel = await context.read<HomeProvider>().getCategories();
      productsModel = await context.read<HomeProvider>().getRandomProducts();
      Provider.of<HomeProvider>(context, listen: false).getChatsList();
      Provider.of<HomeProvider>(context, listen: false)
          .getCurrentOrder("current-orders");
      Provider.of<HomeProvider>(context, listen: false)
          .getPreviousOrder("old-orders");
      setState(() {});
    });
  }
}
