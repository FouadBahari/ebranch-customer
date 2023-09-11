import 'package:flutter/material.dart';


import '../../components/components.dart';
import '../../helpers/config.dart';

import 'currentorder_screen.dart';
import 'finishedorders_screen.dart';
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(text: "الطلبات", leading: Container(), actions: [
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_forward_ios),
            ),
          )
        ]),
        body: DefaultTabController(
          length: 2,
          initialIndex: 1,
          child: Column(
            children: [
              TabBar(
                  indicatorWeight: 2,
                  indicatorColor: Config.mainColor,
                  tabs: <Widget>[
                    Tab(child: Text("الطلبات المنتهية",style: TextStyle(color: Config.mainColor),),),
                    Tab(child: Text("الطلبات الحالية",style: TextStyle(color: Config.mainColor),),),
                  ]
              ),

              Expanded(
                child: TabBarView(
                    children: <Widget>[
                      FinishedOrdersPage(),
                     // CurrentOrdersPage(),
                      CurrentOrdersPage(),
                    ]),
              ),
            ],
          ),
        )
    );
  }
}
