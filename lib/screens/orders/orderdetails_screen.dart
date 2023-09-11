import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../helpers/config.dart';
import '../../helpers/helperfunctions.dart';
import '../../helpers/navigations.dart';
import '../../models/home_models/orders_model.dart';
import '../../providers/home_provider.dart';
import '../../states/homes_states.dart';
import '../home_screen.dart';
import '../productdetails_screen.dart';

class OrderDetailsScreen extends StatefulWidget {
  List<Products> products;
  String? orderStatus, orderId, photo;
  String orderType;
  var rate, deliveryPrice, finalPrice;

  OrderDetailsScreen({Key? key,
    required this.products, required this.orderStatus,
    required this.orderId,
    @required this.rate,
    @required this.deliveryPrice,
    @required this.finalPrice,
    required this.photo,
    required this.orderType})
      : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late double updatedRate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.rate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          text: "تفاصيل الطلب",
          leading: SizedBox.shrink(),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_forward_ios),
              ),
            )
          ]),
      body:
      /*StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("customers")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('orders')
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Directionality(textDirection: TextDirection.rtl, child: Padding(
                      padding:  EdgeInsets.only(left: MediaQuery.sizeOf(context).width*.7),
                      child: Text("المنتجات",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Config.mainColor),),
                    )),
                    const SizedBox(
                      height: 15,
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("customers")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('cart')
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          }
                          return snapshot.data!.docs.length == 0
                              ? Center(
                                  child: CustomText(
                                  text: "لا يوجد منتجات",
                                  fontSize: 18,
                                  textDecoration: TextDecoration.none,
                                ))
                              : Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: GridView.count(
                                    shrinkWrap: true,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 1,
                                    mainAxisSpacing: 10,
                                    physics: NeverScrollableScrollPhysics(),
                                    childAspectRatio:
                                        (Config.responsiveHeight(context) *
                                            0.15 /
                                            160),
                                    children: List.generate(
                                        snapshot.data!.docs.length, (index) {
                                      return ProductCard(
                                        name: snapshot.data!.docs[index]
                                            ["postTitle"],
                                        image: snapshot.data!.docs[index]
                                            ["postPic"],
                                        price: snapshot
                                            .data!.docs[index]["postPrice"]
                                            .toString(),
                                        offer: 1
                                        /* widget.products[index].offer==0?
                          null:widget.products[index].offer.toString
                          ()*/
                                        ,
                                        onTap: () {
                                          // Navigation.mainNavigator(
                                          //     context,
                                          //     ProductDetailsScreen(
                                          //         product: snapshot
                                          //             .data!.docs[index],
                                          //         offer: 10
                                          //         // widget.products[index].offer==0?null:true
                                          //         ,
                                          //         fromOrder: true));
                                        },
                                        catName: snapshot.data!
                                            .docs[index]["category"],
                                      );
                                    }), /*
                        ),
                      ),*/

                                    /* const SizedBox(
                          height: 25,
                          ),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          if (widget.deliveryPrice.toString() != "0")
                          Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                          CustomText(
                          textDecoration: TextDecoration.none,
                          text: widget.deliveryPrice.toString(),
                          fontSize: 16),
                          CustomText(
                          textDecoration: TextDecoration.none,
                          text: "قيمة التوصيل : ".toString(),
                          fontSize: 16),
                          ],
                          ),
                          const SizedBox(
                          width: 25,
                          ),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                          CustomText(
                          textDecoration: TextDecoration.none,
                          text:
                          "${int.parse(widget.finalPrice.toString())}",
                          fontSize: 16),
                          CustomText(
                          textDecoration: TextDecoration.none,
                          text: "سعر الطلبات : ",
                          fontSize: 16),
                          ],
                          ),
                          ],
                          ),
                          const SizedBox(
                          height: 15,
                          ),
                          widget.photo != null
                          ? Column(
                          children: [
                          CustomText(
                          textDecoration: TextDecoration.none,
                          text: "الفاتورة",
                          fontSize: 16),
                          const SizedBox(
                          height: 15,
                          ),
                          FadeInImage(
                          placeholder:
                          AssetImage("images/homeBanner.png"),
                          imageErrorBuilder:
                          (context, builder, stackTrace) =>
                          Image.asset("images/logo.png"),
                          image: NetworkImage(widget.photo),
                          height: 180,
                          width: Config.responsiveWidth(context) * 0.9,
                          fit: BoxFit.fill,
                          )
                          ],
                          )
                              : const SizedBox(),
                          const SizedBox(
                          height: 75,
                          ),*/
                                    //  if (widget.orderType != "home")
                                  ));
                        }),
                    const SizedBox(
                      height: 75,
                    ),
                    FadeInImage(
                      placeholder:
                      AssetImage("images/homeBanner.png"),
                      imageErrorBuilder:
                          (context, builder, stackTrace) =>
                          Image.asset("images/logo.png"),
                      image:AssetImage("images/homeBanner.png"), //NetworkImage(widget.photo),
                      height: 180,
                      width: Config.responsiveWidth(context) * 0.9,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "بانتظار موافقة المتجر",
                              fontSize: 16,
                              color: widget.orderStatus == "جديد" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text:
                                  "بانتظار موافقة المتجر علي طلبك رقم ${widget.orderId}",
                              fontSize: 14,
                              color: widget.orderStatus == "جديد" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            const SizedBox(
                              height: 65,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "المتجر قبل طلبك",
                              fontSize: 16,
                              color: widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "المتجر قبل طلبك وبانتظار موافقة السائق",
                              fontSize: 14,
                              color: widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            const SizedBox(
                              height: 65,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "السائق قبل طلبك",
                              fontSize: 16,
                              color: widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            Container(
                                width: Config.responsiveWidth(context) * 0.65,
                                child: CustomText(
                                  textDecoration: TextDecoration.none,
                                  text:
                                      "السائق قبل طلبك رقم ${widget.orderId} وجاري استلام الطلب من المتجر",
                                  fontSize: 14,
                                  color: widget.orderStatus ==
                                              "تم الموافقة من السائق" ||
                                          widget.orderStatus == "تم التوصيل" ||
                                          widget.orderStatus == "الطلب منتهي" ||
                                          widget.orderStatus == "الطلب ملغي" ||
                                          widget.orderStatus == "الطلب متعثر" ||
                                          widget.orderStatus == "الطلب مرتجع" ||
                                          widget.orderStatus == "مخالصة" ||
                                          widget.orderStatus ==
                                              "تم الاستلام من المتجر"
                                      ? Config.mainColor
                                      : Config.buttonColor,
                                )),
                            const SizedBox(
                              height: 55,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "تم تسليم الطلب بنجاح",
                              fontSize: 16,
                              color: widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "مخالصة"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "نحن سعداء لخدمتك",
                              fontSize: 14,
                              color: widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "مخالصة"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            const SizedBox(
                              height: 65,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            DecoratedContainer(
                                height: 60,
                                width: 60,
                                radius: 30,
                                borderColor: widget.orderStatus == "جديد" ||
                                        widget.orderStatus ==
                                            "تم الموافقة من المتجر" ||
                                        widget.orderStatus ==
                                            "تم الموافقة من السائق" ||
                                        widget.orderStatus == "تم التوصيل" ||
                                        widget.orderStatus == "الطلب منتهي" ||
                                        widget.orderStatus == "الطلب ملغي" ||
                                        widget.orderStatus == "الطلب متعثر" ||
                                        widget.orderStatus == "الطلب مرتجع" ||
                                        widget.orderStatus == "مخالصة" ||
                                        widget.orderStatus ==
                                            "تم الاستلام من المتجر"
                                    ? Config.mainColor
                                    : Config.buttonColor,
                                borderWidth: 0.5,
                                child: Icon(
                                  Icons.check,
                                  size: 30,
                                  color: widget.orderStatus == "جديد" ||
                                          widget.orderStatus ==
                                              "تم الموافقة من المتجر" ||
                                          widget.orderStatus ==
                                              "تم الموافقة من السائق" ||
                                          widget.orderStatus == "تم التوصيل" ||
                                          widget.orderStatus == "الطلب منتهي" ||
                                          widget.orderStatus == "الطلب ملغي" ||
                                          widget.orderStatus == "الطلب متعثر" ||
                                          widget.orderStatus == "الطلب مرتجع" ||
                                          widget.orderStatus == "مخالصة" ||
                                          widget.orderStatus ==
                                              "تم الاستلام من المتجر"
                                      ? Config.mainColor
                                      : Config.buttonColor,
                                )),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus == "جديد" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus == "جديد" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus == "جديد" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus == "جديد" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus == "جديد" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            DecoratedContainer(
                                height: 60,
                                width: 60,
                                radius: 30,
                                borderColor: widget.orderStatus ==
                                            "تم الموافقة من المتجر" ||
                                        widget.orderStatus ==
                                            "تم الموافقة من السائق" ||
                                        widget.orderStatus == "تم التوصيل" ||
                                        widget.orderStatus == "الطلب منتهي" ||
                                        widget.orderStatus == "الطلب ملغي" ||
                                        widget.orderStatus == "الطلب متعثر" ||
                                        widget.orderStatus == "الطلب مرتجع" ||
                                        widget.orderStatus == "مخالصة" ||
                                        widget.orderStatus ==
                                            "تم الاستلام من المتجر"
                                    ? Config.mainColor
                                    : Config.buttonColor,
                                borderWidth: 0.5,
                                child: Icon(
                                  Icons.assignment,
                                  size: 30,
                                  color: widget.orderStatus ==
                                              "تم الموافقة من المتجر" ||
                                          widget.orderStatus ==
                                              "تم الموافقة من السائق" ||
                                          widget.orderStatus == "تم التوصيل" ||
                                          widget.orderStatus == "الطلب منتهي" ||
                                          widget.orderStatus == "الطلب ملغي" ||
                                          widget.orderStatus == "الطلب متعثر" ||
                                          widget.orderStatus == "الطلب مرتجع" ||
                                          widget.orderStatus == "مخالصة" ||
                                          widget.orderStatus ==
                                              "تم الاستلام من المتجر"
                                      ? Config.mainColor
                                      : Config.buttonColor,
                                )),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            DecoratedContainer(
                                height: 60,
                                width: 60,
                                radius: 30,
                                borderColor: widget.orderStatus ==
                                            "تم الموافقة من السائق" ||
                                        widget.orderStatus == "تم التوصيل" ||
                                        widget.orderStatus == "الطلب منتهي" ||
                                        widget.orderStatus == "الطلب ملغي" ||
                                        widget.orderStatus == "الطلب متعثر" ||
                                        widget.orderStatus == "الطلب مرتجع" ||
                                        widget.orderStatus == "مخالصة" ||
                                        widget.orderStatus ==
                                            "تم الاستلام من المتجر"
                                    ? Config.mainColor
                                    : Config.buttonColor,
                                borderWidth: 0.5,
                                child: Icon(
                                  Icons.car_repair,
                                  size: 30,
                                  color: widget.orderStatus ==
                                              "تم الموافقة من السائق" ||
                                          widget.orderStatus == "تم التوصيل" ||
                                          widget.orderStatus == "الطلب منتهي" ||
                                          widget.orderStatus == "الطلب ملغي" ||
                                          widget.orderStatus == "الطلب متعثر" ||
                                          widget.orderStatus == "الطلب مرتجع" ||
                                          widget.orderStatus == "مخالصة" ||
                                          widget.orderStatus ==
                                              "تم الاستلام من المتجر"
                                      ? Config.mainColor
                                      : Config.buttonColor,
                                )),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 2,
                              color: widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            DecoratedContainer(
                                height: 60,
                                width: 60,
                                radius: 30,
                                borderColor: widget.orderStatus ==
                                            "تم التوصيل" ||
                                        widget.orderStatus == "الطلب منتهي" ||
                                        widget.orderStatus == "مخالصة"
                                    ? Config.mainColor
                                    : Config.buttonColor,
                                borderWidth: 0.5,
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 30,
                                  color: widget.orderStatus == "تم التوصيل" ||
                                          widget.orderStatus == "الطلب منتهي" ||
                                          widget.orderStatus == "مخالصة"
                                      ? Config.mainColor
                                      : Config.buttonColor,
                                )),
                          ],
                        ),
                      ],
                    ),
                    //    else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "بانتظار تجهيز طلبك المتجر",
                              fontSize: 16,
                              color: widget.orderStatus == "جديد" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "بانتظار تجهيز طلبك رقم ${widget.orderId}",
                              fontSize: 14,
                              color: widget.orderStatus == "جديد" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            const SizedBox(
                              height: 65,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "طلبك جاهز للاستلام من المتجر",
                              fontSize: 16,
                              color: widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "المتجر جهز طلبك وبانتظار الاستلام",
                              fontSize: 14,
                              color: widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            const SizedBox(
                              height: 65,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "لقد استلمت طلبك",
                              fontSize: 16,
                              color: widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "مخالصة"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "لقد استلمت طلبك رقم ${widget.orderId}",
                              fontSize: 14,
                              color: widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "مخالصة"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            const SizedBox(
                              height: 65,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            DecoratedContainer(
                                height: 60,
                                width: 60,
                                radius: 30,
                                borderColor: widget.orderStatus == "جديد" ||
                                        widget.orderStatus ==
                                            "تم الموافقة من المتجر" ||
                                        widget.orderStatus ==
                                            "تم الموافقة من السائق" ||
                                        widget.orderStatus == "تم التوصيل" ||
                                        widget.orderStatus == "الطلب منتهي" ||
                                        widget.orderStatus == "الطلب ملغي" ||
                                        widget.orderStatus == "الطلب متعثر" ||
                                        widget.orderStatus == "الطلب مرتجع" ||
                                        widget.orderStatus == "مخالصة" ||
                                        widget.orderStatus ==
                                            "تم الاستلام من المتجر"
                                    ? Config.mainColor
                                    : Config.buttonColor,
                                borderWidth: 0.5,
                                child: Icon(
                                  Icons.check,
                                  size: 30,
                                  color: widget.orderStatus == "جديد" ||
                                          widget.orderStatus ==
                                              "تم الموافقة من المتجر" ||
                                          widget.orderStatus ==
                                              "تم الموافقة من السائق" ||
                                          widget.orderStatus == "تم التوصيل" ||
                                          widget.orderStatus == "الطلب منتهي" ||
                                          widget.orderStatus == "الطلب ملغي" ||
                                          widget.orderStatus == "الطلب متعثر" ||
                                          widget.orderStatus == "الطلب مرتجع" ||
                                          widget.orderStatus == "مخالصة" ||
                                          widget.orderStatus ==
                                              "تم الاستلام من المتجر"
                                      ? Config.mainColor
                                      : Config.buttonColor,
                                )),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus == "جديد" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus == "جديد" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus == "جديد" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus == "جديد" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus == "جديد" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            DecoratedContainer(
                                height: 60,
                                width: 60,
                                radius: 30,
                                borderColor: widget.orderStatus ==
                                            "تم الموافقة من المتجر" ||
                                        widget.orderStatus ==
                                            "تم الموافقة من السائق" ||
                                        widget.orderStatus == "تم التوصيل" ||
                                        widget.orderStatus == "الطلب منتهي" ||
                                        widget.orderStatus == "الطلب ملغي" ||
                                        widget.orderStatus == "الطلب متعثر" ||
                                        widget.orderStatus == "الطلب مرتجع" ||
                                        widget.orderStatus == "مخالصة" ||
                                        widget.orderStatus ==
                                            "تم الاستلام من المتجر"
                                    ? Config.mainColor
                                    : Config.buttonColor,
                                borderWidth: 0.5,
                                child: Icon(
                                  Icons.assignment,
                                  size: 30,
                                  color: widget.orderStatus ==
                                              "تم الموافقة من المتجر" ||
                                          widget.orderStatus ==
                                              "تم الموافقة من السائق" ||
                                          widget.orderStatus == "تم التوصيل" ||
                                          widget.orderStatus == "الطلب منتهي" ||
                                          widget.orderStatus == "الطلب ملغي" ||
                                          widget.orderStatus == "الطلب متعثر" ||
                                          widget.orderStatus == "الطلب مرتجع" ||
                                          widget.orderStatus == "مخالصة" ||
                                          widget.orderStatus ==
                                              "تم الاستلام من المتجر"
                                      ? Config.mainColor
                                      : Config.buttonColor,
                                )),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            CustomText(
                              textDecoration: TextDecoration.none,
                              text: "|",
                              fontSize: 7,
                              color: widget.orderStatus ==
                                          "تم الموافقة من المتجر" ||
                                      widget.orderStatus ==
                                          "تم الموافقة من السائق" ||
                                      widget.orderStatus == "تم التوصيل" ||
                                      widget.orderStatus == "الطلب منتهي" ||
                                      widget.orderStatus == "الطلب ملغي" ||
                                      widget.orderStatus == "الطلب متعثر" ||
                                      widget.orderStatus == "الطلب مرتجع" ||
                                      widget.orderStatus == "مخالصة" ||
                                      widget.orderStatus ==
                                          "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,
                            ),
                            DecoratedContainer(
                                height: 60,
                                width: 60,
                                radius: 30,
                                borderColor: widget.orderStatus ==
                                            "تم التوصيل" ||
                                        widget.orderStatus == "الطلب منتهي" ||
                                        widget.orderStatus == "مخالصة"
                                    ? Config.mainColor
                                    : Config.buttonColor,
                                borderWidth: 0.5,
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 30,
                                  color: widget.orderStatus == "تم التوصيل" ||
                                          widget.orderStatus == "الطلب منتهي" ||
                                          widget.orderStatus == "مخالصة"
                                      ? Config.mainColor
                                      : Config.buttonColor,
                                )),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    widget.orderStatus == "تم التوصيل" ||
                            widget.orderStatus == "الطلب منتهي" ||
                            widget.orderStatus == "مخالصة"
                        ? widget.rate.toString() == "0" || widget.rate == null
                            ? Column(
                                children: [
                                  CustomText(
                                    text: "تقييم السائق",
                                    fontSize: 16,
                                    textDecoration: TextDecoration.none,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  RatingBar.builder(
                                    initialRating: 0.0,
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (double value) {
                                      updatedRate = value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Consumer<HomeProvider>(
                                      builder: (context, provider, child) {
                                    return HomeStates.makeOrderState !=
                                            MakeOrderState.LOADING
                                        ? CustomButton(
                                            text: "ارسال",
                                            onPressed: () async {
                                              if (updatedRate == null) {
                                                toast("من فضلك ضع تقييمك",
                                                    context);
                                                return;
                                              }
                                              /* Map response = await provider.rateOrder({
                                  "orderid": widget.orderId,
                                  "rate": updatedRate.toString()
                                });
                                toast(response['msg'], context);
                                if (response['status']) {
                                  Navigation.removeUntilNavigator(
                                      context, HomeScreen());
                                }*/
                                            },
                                            color: Config.mainColor,
                                            horizontalPadding:
                                                Config.responsiveWidth(
                                                        context) *
                                                    0.22,
                                          )
                                        : Center(
                                            child: CircularProgressIndicator());
                                  })
                                ],
                              )
                            : SizedBox()
                        : SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          }),*/

      Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 75,),
              if(widget.products.isEmpty)
                CustomText(textDecoration: TextDecoration.none,
                    text: "لا يوجد منتجات لعرضها",
                    fontSize: 16)
              else
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 10,
                    childAspectRatio: (Config.responsiveHeight(context) * 0.15 /
                        160),
                    children: List.generate(widget.products.length, (index) {
                      return ProductCard(name: widget.products[index].name!,
                          image: widget.products[index].photo!,
                          price: widget.products[index].price.toString(),
                          catName: '',
                          offer:
                          widget.products[index].offer==0?
                          null:widget.products[index].offer!,onTap: (){
                      // Navigation.mainNavigator(context, ProductDetailsScreen(product: widget.products[index],offer:
                      // widget.products[index].offer==0?null:widget.products[index].offer
                      // ,fromOrder: true));
                      },
                      );
                    }),
                  ),
                ),

              const SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(widget.deliveryPrice.toString() != "0")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomText(textDecoration: TextDecoration.none,
                            text: Provider.of<HomeProvider>(context).cartModel!.price.toString(),
                            fontSize: 16),
                        CustomText(textDecoration: TextDecoration.none,
                            text: "قيمة التوصيل : ".toString(),
                            fontSize: 16),
                      ],
                    ),
                  const SizedBox(width: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText(textDecoration: TextDecoration.none,
                          text: "${double.parse(widget.finalPrice.toString())}",
                          fontSize: 16),
                      CustomText(textDecoration: TextDecoration.none,
                          text: "سعر الطلبات : ",
                          fontSize: 16),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 15,),
              widget.photo != null ? Column(
                children: [
                  CustomText(textDecoration: TextDecoration.none,
                      text: "الفاتورة",
                      fontSize: 16),
                  const SizedBox(height: 15,),
                  FadeInImage(
                    placeholder: AssetImage("images/homeBanner.png"),
                    imageErrorBuilder: (context, builder, stackTrace) =>
                        Image.asset("images/logo.png"),
                    image: NetworkImage(widget.photo!),
                    height: 180,
                    width: Config.responsiveWidth(context) * 0.9,
                    fit: BoxFit.fill,)
                ],
              ) : const SizedBox(),
              const SizedBox(height: 75,),
              if(widget.orderType != "home")
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(textDecoration: TextDecoration.none,
                          text: "بانتظار موافقة المتجر",
                          fontSize: 16,
                          color: widget.orderStatus == "جديد" ||
                              widget.orderStatus == "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "بانتظار موافقة المتجر علي طلبك رقم ${widget
                              .orderId}",
                          fontSize: 14,
                          color: widget.orderStatus == "جديد" ||
                              widget.orderStatus == "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        const SizedBox(height: 65,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "المتجر قبل طلبك",
                          fontSize: 16,
                          color: widget.orderStatus ==
                              "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "المتجر قبل طلبك وبانتظار موافقة السائق",
                          fontSize: 14,
                          color: widget.orderStatus ==
                              "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        const SizedBox(height: 65,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "السائق قبل طلبك",
                          fontSize: 16,
                          color: widget.orderStatus ==
                              "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        Container(width: Config.responsiveWidth(context) * 0.65,
                            child: CustomText(
                              textDecoration: TextDecoration.none,
                              text: "السائق قبل طلبك رقم ${widget
                                  .orderId} وجاري استلام الطلب من المتجر",
                              fontSize: 14,
                              color: widget.orderStatus ==
                                  "تم الموافقة من السائق" ||
                                  widget.orderStatus == "تم التوصيل" ||
                                  widget.orderStatus == "الطلب منتهي" ||
                                  widget.orderStatus == "الطلب ملغي" ||
                                  widget.orderStatus == "الطلب متعثر" ||
                                  widget.orderStatus == "الطلب مرتجع" ||
                                  widget.orderStatus == "مخالصة" || widget
                                  .orderStatus == "تم الاستلام من المتجر"
                                  ? Config.mainColor
                                  : Config.buttonColor,)),
                        const SizedBox(height: 55,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "تم تسليم الطلب بنجاح",
                          fontSize: 16,
                          color: widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" ||
                              widget.orderStatus == "مخالصة"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "نحن سعداء لخدمتك",
                          fontSize: 14,
                          color: widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" ||
                              widget.orderStatus == "مخالصة"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        const SizedBox(height: 65,),

                      ],
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      children: [
                        DecoratedContainer(height: 60,
                            width: 60,
                            radius: 30,
                            borderColor: widget.orderStatus == "جديد" ||
                                widget.orderStatus == "تم الموافقة من المتجر" ||
                                widget.orderStatus == "تم الموافقة من السائق" ||
                                widget.orderStatus == "تم التوصيل" ||
                                widget.orderStatus == "الطلب منتهي" || widget
                                .orderStatus == "الطلب ملغي" || widget
                                .orderStatus == "الطلب متعثر" ||
                                widget.orderStatus == "الطلب مرتجع" ||
                                widget.orderStatus == "مخالصة" ||
                                widget.orderStatus == "تم الاستلام من المتجر"
                                ? Config.mainColor
                                : Config.buttonColor,
                            borderWidth: 0.5,
                            child: Icon(Icons.check, size: 30, color: widget
                                .orderStatus == "جديد" ||
                                widget.orderStatus == "تم الموافقة من المتجر" ||
                                widget.orderStatus == "تم الموافقة من السائق" ||
                                widget.orderStatus == "تم التوصيل" ||
                                widget.orderStatus == "الطلب منتهي" ||
                                widget.orderStatus == "الطلب ملغي" ||
                                widget.orderStatus == "الطلب متعثر" ||
                                widget.orderStatus == "الطلب مرتجع" ||
                                widget.orderStatus == "مخالصة" || widget
                                .orderStatus == "تم الاستلام من المتجر" ? Config
                                .mainColor : Config.buttonColor,)),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus == "جديد" ||
                              widget.orderStatus == "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus == "جديد" ||
                              widget.orderStatus == "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus == "جديد" ||
                              widget.orderStatus == "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus == "جديد" ||
                              widget.orderStatus == "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus == "جديد" ||
                              widget.orderStatus == "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),

                        DecoratedContainer(height: 60,
                            width: 60,
                            radius: 30,
                            borderColor: widget.orderStatus ==
                                "تم الموافقة من المتجر" ||
                                widget.orderStatus == "تم الموافقة من السائق" ||
                                widget.orderStatus == "تم التوصيل" ||
                                widget.orderStatus == "الطلب منتهي" || widget
                                .orderStatus == "الطلب ملغي" || widget
                                .orderStatus == "الطلب متعثر" ||
                                widget.orderStatus == "الطلب مرتجع" ||
                                widget.orderStatus == "مخالصة" ||
                                widget.orderStatus == "تم الاستلام من المتجر"
                                ? Config.mainColor
                                : Config.buttonColor,
                            borderWidth: 0.5,
                            child: Icon(
                              Icons.assignment, size: 30, color: widget
                                .orderStatus == "تم الموافقة من المتجر" ||
                                widget.orderStatus == "تم الموافقة من السائق" ||
                                widget.orderStatus == "تم التوصيل" ||
                                widget.orderStatus == "الطلب منتهي" ||
                                widget.orderStatus == "الطلب ملغي" ||
                                widget.orderStatus == "الطلب متعثر" ||
                                widget.orderStatus == "الطلب مرتجع" ||
                                widget.orderStatus == "مخالصة" || widget
                                .orderStatus == "تم الاستلام من المتجر" ? Config
                                .mainColor : Config.buttonColor,)),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus ==
                              "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus ==
                              "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus ==
                              "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus ==
                              "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus ==
                              "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),

                        DecoratedContainer(height: 60,
                            width: 60,
                            radius: 30,
                            borderColor: widget.orderStatus ==
                                "تم الموافقة من السائق" ||
                                widget.orderStatus == "تم التوصيل" ||
                                widget.orderStatus == "الطلب منتهي" || widget
                                .orderStatus == "الطلب ملغي" || widget
                                .orderStatus == "الطلب متعثر" ||
                                widget.orderStatus == "الطلب مرتجع" ||
                                widget.orderStatus == "مخالصة" ||
                                widget.orderStatus == "تم الاستلام من المتجر"
                                ? Config.mainColor
                                : Config.buttonColor,
                            borderWidth: 0.5,
                            child: Icon(
                              Icons.car_repair, size: 30, color: widget
                                .orderStatus == "تم الموافقة من السائق" ||
                                widget.orderStatus == "تم التوصيل" ||
                                widget.orderStatus == "الطلب منتهي" ||
                                widget.orderStatus == "الطلب ملغي" ||
                                widget.orderStatus == "الطلب متعثر" ||
                                widget.orderStatus == "الطلب مرتجع" ||
                                widget.orderStatus == "مخالصة" || widget
                                .orderStatus == "تم الاستلام من المتجر" ? Config
                                .mainColor : Config.buttonColor,)),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus ==
                              "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus ==
                              "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus ==
                              "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus ==
                              "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 2,
                          color: widget.orderStatus ==
                              "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        DecoratedContainer(height: 60,
                            width: 60,
                            radius: 30,
                            borderColor: widget.orderStatus == "تم التوصيل" ||
                                widget.orderStatus == "الطلب منتهي" ||
                                widget.orderStatus == "مخالصة" ? Config
                                .mainColor : Config.buttonColor,
                            borderWidth: 0.5,
                            child: Icon(
                              Icons.favorite_border, size: 30, color: widget
                                .orderStatus == "تم التوصيل" ||
                                widget.orderStatus == "الطلب منتهي" || widget
                                .orderStatus == "مخالصة"
                                ? Config.mainColor
                                : Config.buttonColor,)),

                      ],
                    ),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(textDecoration: TextDecoration.none,
                          text: "بانتظار تجهيز طلبك المتجر",
                          fontSize: 16,
                          color: widget.orderStatus == "جديد" ||
                              widget.orderStatus == "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "بانتظار تجهيز طلبك رقم ${widget.orderId}",
                          fontSize: 14,
                          color: widget.orderStatus == "جديد" ||
                              widget.orderStatus == "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        const SizedBox(height: 65,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "طلبك جاهز للاستلام من المتجر",
                          fontSize: 16,
                          color: widget.orderStatus ==
                              "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "المتجر جهز طلبك وبانتظار الاستلام",
                          fontSize: 14,
                          color: widget.orderStatus ==
                              "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        const SizedBox(height: 65,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "لقد استلمت طلبك",
                          fontSize: 16,
                          color: widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" ||
                              widget.orderStatus == "مخالصة"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "لقد استلمت طلبك رقم ${widget.orderId}",
                          fontSize: 14,
                          color: widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" ||
                              widget.orderStatus == "مخالصة"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        const SizedBox(height: 65,),

                      ],
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      children: [
                        DecoratedContainer(height: 60,
                            width: 60,
                            radius: 30,
                            borderColor: widget.orderStatus == "جديد" ||
                                widget.orderStatus == "تم الموافقة من المتجر" ||
                                widget.orderStatus == "تم الموافقة من السائق" ||
                                widget.orderStatus == "تم التوصيل" ||
                                widget.orderStatus == "الطلب منتهي" || widget
                                .orderStatus == "الطلب ملغي" || widget
                                .orderStatus == "الطلب متعثر" ||
                                widget.orderStatus == "الطلب مرتجع" ||
                                widget.orderStatus == "مخالصة" ||
                                widget.orderStatus == "تم الاستلام من المتجر"
                                ? Config.mainColor
                                : Config.buttonColor,
                            borderWidth: 0.5,
                            child: Icon(Icons.check, size: 30, color: widget
                                .orderStatus == "جديد" ||
                                widget.orderStatus == "تم الموافقة من المتجر" ||
                                widget.orderStatus == "تم الموافقة من السائق" ||
                                widget.orderStatus == "تم التوصيل" ||
                                widget.orderStatus == "الطلب منتهي" ||
                                widget.orderStatus == "الطلب ملغي" ||
                                widget.orderStatus == "الطلب متعثر" ||
                                widget.orderStatus == "الطلب مرتجع" ||
                                widget.orderStatus == "مخالصة" || widget
                                .orderStatus == "تم الاستلام من المتجر" ? Config
                                .mainColor : Config.buttonColor,)),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus == "جديد" ||
                              widget.orderStatus == "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus == "جديد" ||
                              widget.orderStatus == "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus == "جديد" ||
                              widget.orderStatus == "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus == "جديد" ||
                              widget.orderStatus == "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus == "جديد" ||
                              widget.orderStatus == "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),

                        DecoratedContainer(height: 60,
                            width: 60,
                            radius: 30,
                            borderColor: widget.orderStatus ==
                                "تم الموافقة من المتجر" ||
                                widget.orderStatus == "تم الموافقة من السائق" ||
                                widget.orderStatus == "تم التوصيل" ||
                                widget.orderStatus == "الطلب منتهي" || widget
                                .orderStatus == "الطلب ملغي" || widget
                                .orderStatus == "الطلب متعثر" ||
                                widget.orderStatus == "الطلب مرتجع" ||
                                widget.orderStatus == "مخالصة" ||
                                widget.orderStatus == "تم الاستلام من المتجر"
                                ? Config.mainColor
                                : Config.buttonColor,
                            borderWidth: 0.5,
                            child: Icon(
                              Icons.assignment, size: 30, color: widget
                                .orderStatus == "تم الموافقة من المتجر" ||
                                widget.orderStatus == "تم الموافقة من السائق" ||
                                widget.orderStatus == "تم التوصيل" ||
                                widget.orderStatus == "الطلب منتهي" ||
                                widget.orderStatus == "الطلب ملغي" ||
                                widget.orderStatus == "الطلب متعثر" ||
                                widget.orderStatus == "الطلب مرتجع" ||
                                widget.orderStatus == "مخالصة" || widget
                                .orderStatus == "تم الاستلام من المتجر" ? Config
                                .mainColor : Config.buttonColor,)),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus ==
                              "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus ==
                              "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus ==
                              "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus ==
                              "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),
                        CustomText(textDecoration: TextDecoration.none,
                          text: "|",
                          fontSize: 7,
                          color: widget.orderStatus ==
                              "تم الموافقة من المتجر" ||
                              widget.orderStatus == "تم الموافقة من السائق" ||
                              widget.orderStatus == "تم التوصيل" ||
                              widget.orderStatus == "الطلب منتهي" || widget
                              .orderStatus == "الطلب ملغي" || widget
                              .orderStatus == "الطلب متعثر" ||
                              widget.orderStatus == "الطلب مرتجع" ||
                              widget.orderStatus == "مخالصة" ||
                              widget.orderStatus == "تم الاستلام من المتجر"
                              ? Config.mainColor
                              : Config.buttonColor,),

                        DecoratedContainer(height: 60,
                            width: 60,
                            radius: 30,
                            borderColor: widget.orderStatus == "تم التوصيل" ||
                                widget.orderStatus == "الطلب منتهي" ||
                                widget.orderStatus == "مخالصة" ? Config
                                .mainColor : Config.buttonColor,
                            borderWidth: 0.5,
                            child: Icon(
                              Icons.favorite_border, size: 30, color: widget
                                .orderStatus == "تم التوصيل" ||
                                widget.orderStatus == "الطلب منتهي" || widget
                                .orderStatus == "مخالصة"
                                ? Config.mainColor
                                : Config.buttonColor,)),

                      ],
                    ),
                  ],
                ),
              const SizedBox(height: 10,),
              widget.orderStatus == "تم التوصيل" ||
                  widget.orderStatus == "الطلب منتهي" ||
                  widget.orderStatus == "مخالصة" ? widget.rate.toString() ==
                  "0" || widget.rate == null ? Column(
                children: [
                  CustomText(text: "تقييم السائق",
                    fontSize: 16,
                    textDecoration: TextDecoration.none,),
                  const SizedBox(height: 10,),
                  RatingBar.builder(
                    initialRating: 0.0,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) =>
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (double value) {
                      updatedRate = value;
                    },
                  ),
                  const SizedBox(height: 10,),
                  Consumer<HomeProvider>(
                      builder: (context, provider, child) {
                        return HomeStates.makeOrderState !=
                            MakeOrderState.LOADING ? CustomButton(
                          text: "ارسال", onPressed: () async {
                          if (updatedRate == null) {
                            toast("من فضلك ضع تقييمك", context);
                            return;
                          }
                          Map response = await provider.rateOrder({
                            "orderid": widget.orderId,
                            "rate": updatedRate.toString()
                          });
                          toast(response['msg'], context);
                          if (response['status']) {
                            Navigation.removeUntilNavigator(
                                context, HomeScreen());
                          }
                        }, color: Config.mainColor, horizontalPadding: Config
                            .responsiveWidth(context) * 0.22,) : Center(
                            child: CircularProgressIndicator());
                      }
                  )
                ],
              ) : SizedBox() : SizedBox(),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
