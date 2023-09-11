
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../components/components.dart';
import '../../helpers/config.dart';
import '../../helpers/helperfunctions.dart';
import '../../helpers/navigations.dart';
import '../../models/home_models/orders_model.dart';
import '../../providers/home_provider.dart';
import '../../states/homes_states.dart';
import 'orderdetails_screen.dart';


class CurrentOrdersPage extends StatefulWidget {
  const CurrentOrdersPage({Key? key}) : super(key: key);

  @override
  _CurrentOrdersPageState createState() => _CurrentOrdersPageState();
}

class _CurrentOrdersPageState extends State<CurrentOrdersPage> {
  OrderModel? orderModel;
  HomeProvider? provider;
  @override
  Widget build(BuildContext context) {
    return /*StreamBuilder(
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
          return snapshot.data!.docs.length==0?Center(child: CustomText(text: "لا يوجد طلبات حالية", fontSize: 18, textDecoration: TextDecoration.none,)):ListView.builder(
              itemCount:1 /*snapshot.data!.docs.length*/,
              itemBuilder: ((context, index) {
                return    SingleChildScrollView(
                    child: ListView.separated(
                        reverse: true,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          return OrderCard(orderId:"125" /*orderModel.data![index].id.toString()*/,storeName:"متجر السعادة" /*orderModel.data![index].products![0].user!.name!*/,phone: "+201016381636"/*orderModel.data![index].products![0].user!.phone!*/,onTap: (){
                           Navigation.mainNavigator(context, OrderDetailsScreen(/*products: orderModel.data![index].products!,*/orderStatus: snapshot.data!.docs[index]["type"].toString()/*orderModel.data![index].status!*/,orderId:"25" /*orderModel.data![index].id.toString()*/, rate: "5"/*orderModel.data![index].rate*/,deliveryPrice: "500"/*orderModel.data![index].deliveryPrice*/,finalPrice:700 /*int.parse(orderModel.data![index].price.toString())*/,orderType: /*orderModel.data![index].type!*/snapshot.data!.docs[index]["type"].toString(), photo: snapshot.data!.docs[index]["image"],));
                          },price: "20"/*orderModel.data![index].price.toString()*/,date: /*orderModel.data![index].createdAt!.substring(0,10)*/"${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().year}", qty: "1"/*orderModel.data![index].amount!*/,image: snapshot.data!.docs[index]["image"]/*orderModel.data![index].products![0].photo!*/,cancelOrder: () async {
                           /* Map response = await provider.removeCartItem(orderModel.data![index].id);
                            toast(response['msg'], context);
                            if(response['status']){
                              provider.getCurrentOrder("current-orders");*/
                           // }
                          },);
                        },
                        separatorBuilder: (context,index){return SizedBox(height: 15,);},
                        itemCount: snapshot.data!.docs.length
                    ),
                  );

              }));
        });*/
    Padding(
      padding: const EdgeInsets.all(15.0),
      child: ChangeNotifierProvider(
        create: (BuildContext context) => HomeProvider()..getCurrentOrder("current-orders"),
        child: Selector<HomeProvider,CurrentOrderState>(
            selector: (context,homeProvider){
              provider = homeProvider;
              orderModel = homeProvider.currentOrderModel;

              return HomeStates.currentOrderState;
            },
            builder: (context, state,child) {
              print("state :  $state");
              if(state == CurrentOrderState.LOADING|| orderModel == null) {return Center(child: CircularProgressIndicator());}
              if(orderModel!.data!.isEmpty) { return Center(child: CustomText(text: "لا يوجد طلبات حالية", fontSize: 18, textDecoration: TextDecoration.none,)); }

              return SingleChildScrollView(
                child: ListView.separated(
                    reverse: true,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      return OrderCard(orderId: orderModel!.data![index].id.toString(),storeName: orderModel!.data![index].products![0].user!.name!,phone: orderModel!.data![index].products![0].user!.phone!,onTap: (){
                        Navigation.mainNavigator(context, OrderDetailsScreen(products: orderModel!.data![index].products!,orderStatus: orderModel!.data![index].status!,orderId: orderModel!.data![index].id.toString(), rate: orderModel!.data![index].rate,deliveryPrice: orderModel!.data![index].deliveryPrice,finalPrice: double.parse(orderModel!.data![index].price.toString()),orderType: orderModel!.data![index].type!, photo: '',));
                      },price: orderModel!.data![index].price.toString(),date: orderModel!.data![index].createdAt!.substring(0,10), qty: orderModel!.data![index].amount!,image: orderModel!.data![index].products![0].photo!,cancelOrder: () async {
                        Map response = await provider!.removeCartItem(orderModel!.data![index].id);
                        toast(response['msg'], context);
                        if(response['status']){
                          provider!.getCurrentOrder("current-orders");
                        }
                      },);
                    },
                    separatorBuilder: (context,index){return SizedBox(height: 15,);},
                    itemCount: orderModel!.data!.length
                ),
              );
            }
        ),
      ),
    );
  }
}
