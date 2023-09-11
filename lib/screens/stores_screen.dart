
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/components.dart';
import '../helpers/config.dart';
import '../helpers/navigations.dart';
import '../models/home_models/markets_model.dart';
import '../providers/home_provider.dart';
import '../states/homes_states.dart';
import 'drawer_screen.dart';
import 'merchant_screen.dart';
class StoresScreen extends StatefulWidget {
 int catId;
  String catName;
  List<Vendors>? vendors;
  StoresScreen({Key? key, required this.catId,required this.catName,this.vendors}) : super(key: key);

  @override
  _StoresScreenState createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  MarketsModel? marketsModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.catId!=null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        marketsModel =
        await context.read<HomeProvider>().getMarkets(widget.catId);
      });
    }else{
      marketsModel = MarketsModel(vendors: widget.vendors);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text:"المتاجر",leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios)), actions: []),
      endDrawer: DrawerScreen(),
      body:
      Consumer<HomeProvider>(
              builder: (context, homeProvider, child
                  ) {
                if (HomeStates.marketsState == MarketsState.LOADING || marketsModel == null) {
                  return  Center(
                    child: CircularProgressIndicator(),
                  );

                }

                return marketsModel!.vendors!.isEmpty
                    ? Center(child: CustomText(textDecoration: TextDecoration.none,text: "لا يوجد متاجر", fontSize: 18))
                    :Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [

                  const SizedBox(height: 15,),
                  Expanded(
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
                                  Expanded(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
                                        child:FadeInImage(
                                          placeholder: AssetImage("images/logo.png",),
                                          imageErrorBuilder: (context, builder, stackTrace) =>
                                              Image.asset("images/logo.png",fit: BoxFit.fill, ),
                                          image: NetworkImage(marketsModel!.vendors![index].photo!),
                                          height: 170,
                                          width: double.infinity,
                                          fit: BoxFit.cover,

                                        )),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }, separatorBuilder: (context,index){
                      return const SizedBox(height: 15,);
                    }, itemCount: marketsModel!.vendors!.length),
                  )
                ],
              ),
            );
              },
            )

    );
  }
}