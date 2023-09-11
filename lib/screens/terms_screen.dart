
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/components.dart';
import '../providers/home_provider.dart';
import '../states/homes_states.dart';

class TermsScreen extends StatefulWidget {
  String type;
  TermsScreen({Key? key,required this.type}) : super(key: key);

  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(text: widget.type=="about"?"معلومات عننا":widget.type=="privcy"?"سياسة الخصوصية":"الشروط والأحكام", leading: SizedBox.shrink(), actions: [
        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(padding: EdgeInsets.all(8),
            child: Icon(Icons.arrow_forward_ios),
          ),
        )
      ]),
      body:
      StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("terms")
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return  Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(snapshot.data!.docs.first["text"]??'',style: TextStyle(
                  fontSize: 16,
                ),
                maxLines: 15,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          }),
              /*return Center(
                child: CustomText(text: provider.response['data'], fontSize: 16, textDecoration: TextDecoration.none,),
              );*/
       
    );
  }
}