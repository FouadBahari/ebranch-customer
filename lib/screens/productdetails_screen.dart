import 'dart:developer';

import 'package:e_branch_customer/models/home_models/cart_model.dart';
import 'package:e_branch_customer/models/home_models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/components.dart';
import '../helpers/config.dart';
import '../helpers/helperfunctions.dart';
import '../helpers/navigations.dart';
import '../models/home_models/markets_model.dart';
import '../providers/home_provider.dart';
import '../services/firebase_auth_methods.dart';
import '../states/homes_states.dart';
import 'cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  Data product;
  int? offer;
  bool fromOrder;
  Vendors vendor;

   ProductDetailsScreen(
      {Key? key,
      required this.product,
      required this.offer,
      required this.vendor,
      required this.fromOrder})
      : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  var qty = 1;
  String size = "";
  String color = "";
  // bool showcolors = false;
  // String colortext = "أبيض";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          text: widget.product.name,
          actions: [
            //if(widget.fromOrder==null)
            IconButton(
                icon: Icon(Icons.add_shopping_cart),
                onPressed: () {
                  Navigation.mainNavigator(context, CartScreen());
                })
          ],
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                //Navigation.mainNavigator(context, CartScreen());
                Navigator.pop(context);
              })),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.product.photo!,
              width: double.infinity,
              height: 220,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomText(
              text: widget.product.name!,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              textDecoration: TextDecoration.none,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (widget.offer == null)
                            CustomText(
                              text: "${widget.product.price.toString()} SAR",
                              fontSize: 14,
                              textDecoration: TextDecoration.none,
                            )
                          else
                            Row(
                              children: [
                                CustomText(
                                  textDecoration: TextDecoration.none,
                                  text:
                                      "${double.parse(widget.product.price.toString()) - (double.parse(widget.product.price.toString()) * (double.parse(widget.offer.toString()) / 100))} SAR",
                                  fontSize: 14,
                                  color: Config.mainColor,
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                CustomText(
                                  text: "${widget.product.price} SAR",
                                  fontSize: 14,
                                  textDecoration: TextDecoration.lineThrough,
                                )
                              ],
                            ),
                          const SizedBox(
                            width: 7,
                          ),
                          CustomText(
                            text: "السعر : ",
                            fontSize: 14,
                            textDecoration: TextDecoration.none,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: Config.mainColor,
                      alignment: Alignment.center,
                      child: CustomText(
                        text: "الوصف",
                        fontSize: 18,
                        color: Colors.white,
                        textDecoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      text: widget.product.description!,
                      fontSize: 14,
                      textDecoration: TextDecoration.none,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(
                                text: "اختر الحجم",
                                fontSize: 16,
                                textDecoration: TextDecoration.none,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: List.generate(
                                widget.product.sizes!.split(",").length,
                                (index) {
                              return InkWell(
                                onTap: () {
                                  size = widget.product.sizes!
                                      .split(",")[index];
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 14),
                                  margin: EdgeInsets.symmetric(horizontal: 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: size ==
                                                widget.product.sizes!
                                                    .split(",")[index]
                                            ? 3.0
                                            : 0.2,
                                        color: size ==
                                                widget.product.sizes!
                                                    .split(",")[index]
                                            ? Config.mainColor
                                            : Colors.black),
                                    color: Config.mainColor.withOpacity(0.1),
                                  ),
                                  alignment: Alignment.center,
                                  child: CustomText(
                                      textDecoration: TextDecoration.none,
                                      text: widget.product.sizes!
                                          .split(",")[index],
                                      fontSize: 14),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(
                                text: "اختر اللون",
                                fontSize: 16,
                                textDecoration: TextDecoration.none,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: List.generate(
                          //       widget.product.colors!.split(",").length,
                          //       (index) {
                          //     return InkWell(
                          //       onTap: () {
                          //           color = widget.product.colors!.split(",")[index];
                          //         setState(() {
                          //           showcolors = true;
                          //         });
                          //       },
                          //       child: Container(
                          //         height: 45,
                          //         width: 45,
                          //         margin: EdgeInsets.symmetric(horizontal: 6),
                          //         decoration: BoxDecoration(
                          //           border: Border.all(
                          //               width: color ==
                          //                       widget.product.sizes!
                          //                           .split(",")[index]
                          //                   ? 2.0
                          //                   : 0.2,
                          //               color: color ==
                          //                       widget.product.sizes!
                          //                           .split(",")[index]
                          //                   ? Config.mainColor
                          //                   : Colors.black),
                          //           borderRadius: BorderRadius.circular(30),
                          //            color:  Color(int.parse("0xff${widget.product.colors!.split(",")[index].substring(1)}")),
                          //         ),
                          //         child: Center(child: Text(colortext)),
                          //         alignment: Alignment.center,
                          //       ),
                          //     );
                          //   }),
                          // ),
                          //   SizedBox(
                          //   height: 8,
                          // ),
                          // showcolors == false
                          //     ? SizedBox.shrink()
                          //     : Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           InkWell(
                          //             onTap: () {
                          //               setState(() {
                          //                 colortext = "أزرق";
                          //               });
                          //             },
                          //             child: Container(
                          //               margin:
                          //                   EdgeInsets.symmetric(horizontal: 5),
                          //               width: 20,
                          //               height: 20,
                          //               decoration: BoxDecoration(
                          //                   color: Colors.blue,
                          //                   shape: BoxShape.circle),
                          //             ),
                          //           ),
                          //           InkWell(
                          //             onTap: () {
                          //               setState(() {
                          //                 colortext = "أحمر";
                          //               });
                          //             },
                          //             child: Container(
                          //               margin:
                          //                   EdgeInsets.symmetric(horizontal: 5),
                          //               width: 20,
                          //               height: 20,
                          //               decoration: BoxDecoration(
                          //                   color: Colors.red,
                          //                   shape: BoxShape.circle),
                          //             ),
                          //           ),
                          //           InkWell(
                          //             onTap: () {
                          //               setState(() {
                          //                 colortext = "أخضر";
                          //               });
                          //             },
                          //             child: Container(
                          //               margin:
                          //                   EdgeInsets.symmetric(horizontal: 5),
                          //               width: 20,
                          //               height: 20,
                          //               decoration: BoxDecoration(
                          //                   color: Colors.green,
                          //                   shape: BoxShape.circle),
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: List.generate(
                                widget.product.colors!.split(",").length,
                                (index) {
                              return InkWell(
                                onTap: () {
                                  color = widget.product.colors!
                                      .split(",")[index];
                                  setState(() {});
                                },
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  margin: EdgeInsets.symmetric(horizontal: 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: color ==
                                                widget.product.colors!
                                                    .split(",")[index]
                                            ? 3.0
                                            : 0.2,
                                        color: color ==
                                                widget.product.colors!
                                                    .split(",")[index]
                                            ? Config.mainColor
                                            : Colors.black),
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color(int.parse(
                                        "0xff${widget.product.colors!.split(",")[index].substring(1)}")),
                                  ),
                                  alignment: Alignment.center,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 55,
              width: double.infinity,
              color: Config.mainColor,
              alignment: Alignment.center,
              child: CustomText(
                  text: "الكمية",
                  fontSize: 14,
                  color: Color(0xffffffff),
                  textDecoration: TextDecoration.none),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (qty != 1) {
                        qty--;
                      }
                      setState(() {});
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        Text(
                          "-",
                          style: TextStyle(fontSize: 30),
                        )
                      ],
                    ),
                  ),
                  CustomText(
                    text: qty.toString(),
                    fontSize: 25,
                    textDecoration: TextDecoration.none,
                  ),
                  InkWell(
                    onTap: () {
                      qty++;
                      setState(() {});
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "+",
                            style: TextStyle(fontSize: 30),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            widget.fromOrder == false
                ? CustomButton(
                    text: "اضف للسلة",
                    onPressed: () async {
                      log("llllllllllllllllllllllllllllllllllllllllllllll");
                      if (widget.product.sizes != "" ||
                          widget.product.colors != "") {

                        if (size == "" || color == "") {

                          // toast("من فضلك اختر الحجم واللون", context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text("من فضلك اختر الحجم واللون")),
                            dismissDirection: DismissDirection.up,
                            duration: Duration(seconds: 1),
                          ));
                          return;
                        }

                      }
                      // log(FirebaseAuth.instance.currentUser!.uid);
                      // String res = await FirebaseAuthMethods().addToCart(
                      //   uid: FirebaseAuth.instance.currentUser!.uid,
                      //   productId: widget.product!['productid'],
                      //   productPic: widget.product!['imageurl'],
                      //   productPrice: widget.product!['price'],
                      //   productTitle: widget.product!['name'],
                      //   productDescription: widget.product!['description'],
                      //   category: widget.product!['category'],
                      // );
                      // Map formData = {
                      //   "product_id": widget.product.id.toString(),
                      //   "user_id": widget.product.userId.toString(),
                      //   "size": size.toString(),
                      //   "color": color.toString(),
                      //   // "qty": qty.toString(),
                      // };

                     String msg =  context.read<HomeProvider>()
                          .addProductToCart(qty,color,size,widget.product.id!,widget.vendor,CartData(
                        id: widget.product.id,
                        price: widget.product.price,
                        name: widget.product.name,
                        amount:widget.product.amount,
                        catId: widget.product.catId,
                        colors: widget.product.colors,
                        createdAt: widget.product.createdAt,
                        description: widget.product.description,
                        offer:widget.product.offer,
                        photo: widget.product.photo,
                        sizes:widget.product.sizes,
                        updatedAt: widget.product.updatedAt,
                        userId: widget.product.userId,
                      ));




                      // await  context.read<HomeProvider>()
                      //     .addToCart(formData);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(msg)),
                        dismissDirection: DismissDirection.up,
                        duration: Duration(seconds: 1),
                      ));

                      /* if (res == 'success') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Directionality(textDirection: TextDirection.rtl,child: Text("تم اضافة النتج للسلة بنجاح"))));

                  // toast("The Item is added to the wishlist.", context);
                } else {
                  toast(res, context);
                }*/
                      // print(response);
                    },
                    color: Config.buttonColor,
                  )
                : Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}
