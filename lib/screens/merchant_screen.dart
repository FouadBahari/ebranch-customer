import 'dart:io';
import 'package:e_branch_customer/screens/productdetails_screen.dart';
import 'package:e_branch_customer/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../components/components.dart';
import '../helpers/config.dart';
import '../helpers/navigations.dart';
import '../models/home_models/categories_model.dart';
import '../models/home_models/markets_model.dart';
import '../models/home_models/products_model.dart';
import '../models/home_models/sliders_model.dart';
import '../providers/home_provider.dart';
import '../states/homes_states.dart';
import 'chats_screen.dart';
import 'home_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';

class MerchantScreen extends StatefulWidget {
  final String id,name;
  final String imageurl;
  final Vendors vendor;
  MerchantScreen({Key? key, required this.imageurl, required this.name,required this.id,required this.vendor}) : super(key: key);
  @override
  _MerchantScreenState createState() => _MerchantScreenState();
}

class _MerchantScreenState extends State<MerchantScreen> {
  int currentPage = 0;
  PageController _pageController = PageController();

  List<Widget>? images = [];
  ProductsModel? productsModel;
  CategoriesModel? categoriesModel;
  SlidersModel? slidersModel;
  ProductsModel? bestSeller;
  @override
  void initState() {
    _pageController = PageController(initialPage: currentPage);

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SlidersModel slidersModel = await Provider.of<HomeProvider>(context,listen: false).getMarketSliders(widget.id);
      images = [];
      slidersModel.data!.forEach((element) {
        images!.add(Image.network(element.image!,width: double.infinity,fit: BoxFit.fill,height: 170,));
      });
      productsModel = await Provider.of<HomeProvider>(context,listen: false).getMarketOffers(widget.id);
      categoriesModel = await Provider.of<HomeProvider>(context,listen: false).getMarketCategories(widget.id);
      bestSeller = await Provider.of<HomeProvider>(context,listen: false).getBestSeller(widget.id);
    });
  }
  @override
  Widget build(BuildContext context) {
    _dotsindicator(int? dotsindex) {
      return DotsIndicator(
        dotsCount: images!.length,
        position: dotsindex!,
        decorator: DotsDecorator(color: Colors.white, activeColor: Colors.blue),
      );
    }
    return Scaffold(
      appBar: CustomAppBar(text: " ${widget.name}",leading: IconButton(onPressed: (){
        Navigation.removeUntilNavigator(context, HomeScreen());
      }, icon: Icon(Icons.close,color: Colors.red,)),actions: [
        // IconButton(onPressed: (){
        //  Navigation.mainNavigator(context, ChatsScreen(merchantId: widget.id,merchantName: widget.name));
        // }, icon: Icon(Icons.chat))
      ]),
      body: Stack(
        children: [
          Container(height: double.infinity,width: double.infinity,color: Config.buttonColor.withOpacity(0.3),),
          SingleChildScrollView(
            child: Column(
              children: [
                Consumer<HomeProvider>(
                    builder: (context, sliders,child) {
                      if(HomeStates.marketSlidersState == MarketSlidersState.LOADING){
                        return Center(child: CircularProgressIndicator());
                      }
                      if(HomeStates.marketSlidersState == MarketSlidersState.LOADED){
                        return Container(
                          height: 170,
                            width: double.infinity,
                            child: Image.network(widget.imageurl,fit: BoxFit.fill,),);

                      }
                        return SizedBox();
                   }
               ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          CustomText(text: "العروض", fontSize: 22,color: const Color(0xff000000), textDecoration: TextDecoration.none,),
                          Container(height: 30,width: 3,color: Config.buttonColor,),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18,),
                // Center(child: CustomText(textDecoration: TextDecoration.none,text: "لا يوجد منتجات لعرضها", fontSize: 18)),
                Consumer<HomeProvider>(
                    builder: (context, homeProvider,child) {
                      if(HomeStates.marketSlidersState == MarketSlidersState.LOADING || productsModel == null){
                        return const Center(child: CircularProgressIndicator());
                      }else if( HomeStates.marketSlidersState == MarketSlidersState.LOADED && productsModel!.data!.isEmpty){
                        return Center(child: CustomText(textDecoration: TextDecoration.none,text: "لا يوجد منتجات", fontSize: 18));
                      }

                      if(HomeStates.marketOffersState==MarketOffersState.ERROR){
                        return CustomText(textDecoration: TextDecoration.none,text: "حدث خطأ", fontSize: 16);
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 5,),
                          Padding(
                            padding: const EdgeInsets.only(top:65,),
                            child: Icon(Platform.isAndroid?Icons.arrow_back:Icons.arrow_back_ios,size: 20,),
                          ),
                          Expanded(
                            child: Container(
                              height: 216,
                              width:  Config.responsiveWidth(context)*0.88,
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  reverse: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context,index){
                                    return ProductCard(name: productsModel!.data![index].name!,rate:0.0,price: productsModel!.data![index].price.toString(), catName: "".toString(),image: productsModel!.data![index].photo!,onTap: (){
                                     Navigation.mainNavigator(context, ProductDetailsScreen(product: productsModel!.data![index],offer: productsModel!.data![index].offer, fromOrder: false,vendor: widget.vendor,));
                                    },offer: productsModel!.data![index].offer!);
                                  }, separatorBuilder: (context,index){
                                return const SizedBox(width: 10,);
                              }, itemCount: productsModel!.data!.length),
                            ),
                          ),
                          const SizedBox(width: 5,),
                          Padding(
                            padding: const EdgeInsets.only(top:65,),
                            child: Icon(Icons.arrow_forward_ios,size: 20,),
                          ),
                        ],
                      );
                    }
                ),
                const SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          CustomText(text: "الاقسام", fontSize: 22,color: Color(0xff000000),textDecoration: TextDecoration.none),
                          Container(height: 30,width: 3,color: Config.buttonColor,),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15)),
                      ),
                    ),
                  ],
                ),
                // StreamBuilder(
                //   stream: FirebaseFirestore.instance
                //       .collection("categories")
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
                //         ? Center(child: CustomText(textDecoration: TextDecoration.none,text: "حدث خطأ", fontSize: 16))
                //         :Padding(
                //       padding: const EdgeInsets.all(18.0),
                //       child: Directionality(
                //         textDirection: TextDirection.rtl,
                //         child: GridView.count(
                //           shrinkWrap: true,
                //           physics: NeverScrollableScrollPhysics(),
                //           crossAxisCount: 2,
                //           crossAxisSpacing: 10,
                //           mainAxisSpacing: 15,
                //           childAspectRatio: (150 / 100),
                //           children: List.generate(snapshot.data!.docs.length, (index) {
                //             return CategoriesCard(name: snapshot.data!.docs[index]["name"],image: snapshot.data!.docs[index]["imageurl"],onTap: (){
                //                 Navigation.mainNavigator(context, ProductsScreen(name: categoriesModel.services[index].name,id: categoriesModel.services![index].id.toString()));
                //             },);
                //           }),
                //         ),
                //       ),
                //     );
                //   },
                // ),
                Consumer<HomeProvider>(
                    builder: (context, homeProvider,child) {
                      if(HomeStates.marketCategoriesState == MarketCategoriesState.LOADING || categoriesModel == null){
                        return Center(child: CircularProgressIndicator());
                      }
                      if(HomeStates.marketCategoriesState == MarketCategoriesState.ERROR){
                        return Center(child: CustomText(text: "حدث خطأ", fontSize: 16,textDecoration: TextDecoration.none));
                      }
                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 15,
                            childAspectRatio: (150 / 100),
                            children: List.generate(categoriesModel!.services!.length, (index) {
                              return CategoriesCard(name: categoriesModel!.services![index].name!,image: Config.url+'/'+categoriesModel!.services![index].photo!,onTap: (){
                               Navigation.mainNavigator(context, ProductsScreen(name: widget.name,id: categoriesModel!.services![index].id.toString(), vendor: widget.vendor));
                              },);
                            }),
                          ),
                        ),
                      );
                    }
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          CustomText(text: "الاكثر مبيعا", fontSize: 19,color: Color(0xff000000),textDecoration: TextDecoration.none),
                          Container(height: 30,width: 3,color: Config.buttonColor,),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15)),
                      ),
                    ),
                  ],
                ),
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
                //         ? Center(child: CustomText(text: "لا يوجد منتجات ", fontSize: 16, textDecoration: TextDecoration.none,))
                //         : Padding(
                //       padding: const EdgeInsets.all(18.0),
                //       child: Directionality(
                //         textDirection: TextDirection.rtl,
                //         child: GridView.count(
                //           shrinkWrap: true,
                //           physics: NeverScrollableScrollPhysics(),
                //           crossAxisCount: 2,
                //           childAspectRatio: (Config.responsiveHeight(context)*0.15 / 160),
                //           children: List.generate(snapshot.data!.docs.length, (index) {
                //             return ProductCard(name:snapshot.data!.docs[index]["name"],rate:0.0,price: snapshot.data!.docs[index]["price"].toString(), catName:snapshot.data!.docs[index]["category"],image:snapshot.data!.docs[index]["imageurl"],onTap: (){
                //                 Navigation.mainNavigator(context, ProductDetailsScreen(product:snapshot.data!.docs[index], offer: 10, fromOrder: false,));
                //             }, offer: 10,);
                //           }),
                //         ),
                //       ),
                //     );
                //   },
                // ),
                Consumer<HomeProvider>(builder: (context, homeProvider,child){
                  if(HomeStates.marketOffersState == MarketOffersState.LOADING || bestSeller == null){
                    return Center(child: CircularProgressIndicator());
                  }
                  if(HomeStates.marketOffersState == MarketOffersState.LOADED && bestSeller!.data!.isEmpty){
                    return Center(child: CustomText(text: "لا يوجد منتجات", fontSize: 16,textDecoration: TextDecoration.none));
                  }
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: (Config.responsiveHeight(context)*0.15 / 160),
                        children: List.generate(bestSeller!.data!.length, (index) {
                          return ProductCard(name: bestSeller!.data![index].name!,rate:0.0,price: bestSeller!.data![index].price.toString(), catName: "".toString(),image: bestSeller!.data![index].photo!,onTap: (){
                            Navigation.mainNavigator(context, ProductDetailsScreen(product: bestSeller!.data![index], offer: bestSeller!.data![index].offer!, fromOrder: false,vendor:widget.vendor));
                          }, offer: bestSeller!.data![index].offer!,);
                        }),
                      ),
                    ),
                  );
                }),

              ],
            ),
          ),
        ],
      ),
    );
  }
}