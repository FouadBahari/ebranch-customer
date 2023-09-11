
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/components.dart';
import '../helpers/config.dart';
import '../helpers/helperfunctions.dart';
import '../models/home_models/chat_model.dart';
import '../providers/home_provider.dart';
class ChatsScreen extends StatefulWidget {
  String merchantId,merchantName;
  ChatsScreen({ Key? key,required this.merchantId,required this.merchantName}) : super(key: key);

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  TextEditingController textFieldController = TextEditingController();
  FocusNode textFieldFocus = FocusNode();
  double? width;
  double? height;
  late HomeProvider chatProvider;
  StreamController _streamController = StreamController();
  Timer? _timer;
  ChatModel? data;
  final ScrollController _controller = ScrollController();

  Future getData() async {
    await setSavedString("newMsg", "");

    data =await chatProvider.getChat(widget.merchantId.toString());

    //Add your data to stream
    _streamController.add(data);
  }

  void _scrollDown() {
    if (_controller.hasClients)
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
  }
  @override
  void initState() {
    chatProvider=Provider.of(context,listen: false);
    getData();
    //Check the server every 5 seconds
    _timer = Timer.periodic(Duration(seconds: 5), (timer) => getData());
    super.initState();

  }


  @override
  void dispose() {
    //cancel the timer
    if (_timer!.isActive) _timer!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    chatProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 247, 255, 1),
      appBar: CustomAppBar(text: widget.merchantName, leading: Container(), actions: []),
      body: Consumer<HomeProvider>(
          builder: (context, homeProvider,child) {
            //  print(snapshot.data.data.messages.toString());
            if(data != null) {
              _scrollDown();
              return Container(
                width: width,
                height: height,
                child: Column(
                  children: [
                    Flexible(
                      child: messageList(data!.data),
                    ),
                    chatControls()
                  ],
                ),
              );
            }else{
              return Center(child: CircularProgressIndicator());
            }
          }
      ),
    );
  }
  Widget messageList(msg) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Scrollbar(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemCount: msg.length,
              itemBuilder: (context, index) {
                return chatMessageItem(msg[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
  Widget chatMessageItem(message) {

    // print(_message.content);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Container(
        alignment: message.send == "user"
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: message.send == "user"
            ?receiverLayout(message): senderLayout(message)
        ,
      ),
    );
  }
  Widget receiverLayout(message) {
    Radius messageRadius = Radius.circular(10);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(top: 12,left: 10,right: 10),
          constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
          decoration: BoxDecoration(
            color: Config.mainColor,
            borderRadius: BorderRadius.only(
                topLeft: messageRadius,
                topRight: messageRadius,
                bottomLeft: messageRadius),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(message.message, style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0,right: 10),
          child: Text(message.createdAt.substring(11,18),style: TextStyle(fontSize: 12),),
        )
      ],
    );
  }
  Widget senderLayout(message) {
    Radius messageRadios = Radius.circular(10);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(top: 12,left: 10,right: 10),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.65,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomRight: messageRadios,
                  topRight: messageRadios,
                  bottomLeft: messageRadios),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(message.message, style: TextStyle(color: Colors.black),),
            )
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0,right: 10),
          child: Text(message.createdAt.substring(11,18),style: TextStyle(fontSize: 12),),
        )
      ],
    );
  }

  chatControls() {
    return Container(
        padding: EdgeInsets.all(10), width: MediaQuery.of(context).size.width,height: 60,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            Container(
                decoration: BoxDecoration(

                ),width: width!-92,
                child:CustomInput(onTap: () {  }, prefixIcon:  Icon(Icons.phone,color: Config.mainColor,), onChange: (String ) {  }, maxLines: 1,controller: textFieldController, hint: "اكتب رسالتك", textInputType: TextInputType.text, suffixIcon: Container(),)),
            const SizedBox(width: 8,),
            InkWell(
                onTap: () async {
                  Map<String,dynamic> result = await chatProvider.sendMsg({"vendorid": widget.merchantId,"message": textFieldController.text});
                  if(result['status']) {
                    textFieldController.text = "";
                    setState(() {});
                  }
                },
                child: CircleAvatar(child: Icon(Icons.send),)),
          ],
        )
    );
  }

}
