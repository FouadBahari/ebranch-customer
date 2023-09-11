import 'dart:io';
import 'package:e_branch_customer/screens/productdetails_screen.dart';
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

class ProductsScreen extends StatefulWidget {
  final String id,name;
  final Vendors vendor;
  ProductsScreen({Key? key,required this.name,required this.id, required this.vendor}) : super(key: key);
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {


  List<Widget>? images = [];
  ProductsModel? productsModel;

  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      productsModel = await Provider.of<HomeProvider>(context,listen: false).getProducts(widget.id);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: " ${widget.name}",leading: IconButton(onPressed: (){
        Navigation.removeUntilNavigator(context, HomeScreen());
      }, icon: Icon(Icons.close,color: Colors.red,)),actions: [
        // IconButton(onPressed: (){
        //  Navigation.mainNavigator(context, ChatsScreen(merchantId: widget.id,merchantName: widget.name));
        // }, icon: Icon(Icons.chat))
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<HomeProvider>(builder: (context, homeProvider,child){
              if(HomeStates.marketOffersState == MarketOffersState.LOADING || productsModel == null){
                return Center(child: CircularProgressIndicator());
              }
              if(HomeStates.marketOffersState == MarketOffersState.LOADED && productsModel!.data!.isEmpty){
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
                    children: List.generate(productsModel!.data!.length, (index) {
                      return ProductCard(name: productsModel!.data![index].name!,rate:0.0,price: productsModel!.data![index].price.toString(), catName: "".toString(),image: productsModel!.data![index].photo!,onTap: (){
                        Navigation.mainNavigator(context, ProductDetailsScreen(product: productsModel!.data![index], offer: productsModel!.data![index].offer!, fromOrder: false,vendor:widget.vendor));
                      }, offer: productsModel!.data![index].offer!,);
                    }),
                  ),
                ),
              );
            }),

          ],
        ),
      ),
    );
  }
}