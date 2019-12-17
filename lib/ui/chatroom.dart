
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app_tusa/ui/m_appbar.dart';
import 'package:flutter_app_tusa/ui/m_colors.dart';
import 'package:flutter_app_tusa/ui/m_text_styles.dart';


class ChatRoom extends StatefulWidget {
  @override
 // NotificationModelVO notificationModelVO;

 // Chatroom(this.notificationModelVO);

  @override
  ChatRoomState createState() => ChatRoomState();
}

//isLoadMoreAvailable
class ChatRoomState extends State<ChatRoom> {

  final DatabaseReference database = FirebaseDatabase.instance.reference().child("chatHistory");


  final db =FirebaseDatabase.instance.reference().child("chatHistory");

  TextEditingController editingController = TextEditingController();
  sendData(String text){
    database.push().set({
      'name':'Swain',
      'message': text

    });
  }
//-------------------------
  ///Retrive data

  ///




  //-----------------------------
  final scrollController = ScrollController();
  bool isLoading = false;
  int pagingNo = 1;
  int newMessage = 0;
 // NotificationModelVO notificationModelVO;
  void initState() {
    super.initState();
  //  notificationModelVO = widget.notificationModelVO;
//isLoadMoreAvailable
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset ) {
        if (!isLoading) {
          setState(() {
            isLoading = true;
          });

       //   loadMore();
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    newMessage = 0;
//
//    if (widget.notificationModelVO != null && widget.notificationModelVO.notificationList.length > 0) {
//      for (int i = 0; i < notificationModelVO.notificationList.length; i++) {
//        if (notificationModelVO.notificationList[i].isNew == true) {
//          newMessage++;
//        }
//      }
//    }
    return RefreshIndicator(
      child: Scaffold(
//        appBar: MAppBar.forOthersWithCloseButton(
//          context: context,
//        ),
      appBar:AppBar(
        title: const Text('Next page'),
      ),
        body: Center(
   child: Container(

     child: Column(
       children: <Widget>[
         Container (
           padding: new EdgeInsets.only(top: 20.0, bottom: 5.0,left: 20,right:20),
           child:   Container(
             padding: new EdgeInsets.only(top: 12.0, bottom: 14.0,left: 14,right:26),
             decoration: new BoxDecoration(color: MColors.brown, borderRadius: new BorderRadius.all(Radius.circular(6.0))),

             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 new Container(
                   child: Container(
                     child: new Text(
                       "Test",
                       style: MTextStyles.headerTextStyle,
                     ),
                   ),
                 ),
//                 new Container(
//
//                   padding: EdgeInsets.fromLTRB(0.0, 5, 0, 0),
//
//                   child: Container(
//                     child: new Text(
//                       "firebase",
//                       style: MTextStyles.headerTextStyle,
//                     ),
//                   ),
//
//                 ),


               ],
             ),
           ),

         ),
         Expanded(

           child: Container(
             color: MColors.flamingo,
             margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
             child: Column(
               children: <Widget>[
                 Expanded(
                   child: Container(
                    // height: 100,
                     color: MColors.white,
                     margin: EdgeInsets.fromLTRB(10, 10, 10, 10),



                   ),
                 ),

              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 100,
                     color: MColors.ivory,
                     margin: EdgeInsets.fromLTRB(10, 10, 10, 10),

                      child: TextField(
                        autofocus: true,
                         controller: editingController,
                        onChanged: (value) {
                          //  filterSearchResults(value);
                        },

                      ),


             ),



                  ),      Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: RaisedButton(
                      //    splashColor: SSColors.rippleEffectColor,
                      child: Text("Send", style: MTextStyles.headerTextStyle),
                 //     onPressed: () => sendData(),
                      onPressed: ()  {
                        print("Test:"+ editingController.text);
                        sendData(editingController.text);





                        db.once().then((DataSnapshot snapshot){
                          Map<dynamic, dynamic> values=snapshot.value;
                          print("values"+values['name']);
                        });









                        editingController.clear();
                        //send to firebase
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(builder: (context) => ChatRoom()),
//                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: MColors.asher,
                    ),
                  ),
                ],
              ),
               ],
             ),


           ),

         ),

       ],
     ),
   ),
        ),
      ),
      onRefresh: () async {
        setState(() {

        });
      // _requestGetNotification(context);
      },
    );
  }

//  loadMore() async {
//    NotificationModelVO notificationModelVO = new NotificationModelVO();
//    notificationModelVO.itemsPerPage = Constants.NOTIFICATION_LIST_ITEMS_PER_PAGE;
//    notificationModelVO.pagingNo = this.notificationModelVO.pagingNo + 1;
//
//
//    try {
//      await NotificationModel().getNotificationList(context, notificationModelVO).then((result) {
//        this.notificationModelVO.notificationList.addAll(result.notificationList);
//        this.notificationModelVO.isLoadMoreAvailable = result.isLoadMoreAvailable;
//        this.notificationModelVO.pagingNo = result.pagingNo;
//        isLoading = false;
//
//        setState(() {
//          makeAnimation();
//        });
//      });
//    } on SSError catch (err) {
//      isLoading = false;
//
//      if ((err.type == SSErrorType.SSErrorTypeApplication && NotificationModel().isApplicationErrorShouldHandleByCaller) || err.type == SSErrorType.SSErrorTypeBusiness) {
//        showDialog<SSDialogResult>(
//          context: context,
//          builder: (BuildContext context) => SSDialog(
//            dialogTag: 187,
//            title: SSString.APP_NAME,
//            description: NotificationModel().constructAnyErrorMessageWithCode(err),
//            okButtonText: SSString.ALERT_BTN_OK,
//            cancelButtonText: "",
//          ),
//        ).then((dialogResult) {});
//      }
//    }
//
//  }

//  makeAnimation() async {
//    final offsetFromBottom = scrollController.position.maxScrollExtent - scrollController.offset;
//    if (offsetFromBottom < 50) {
//      await scrollController.animateTo(
//        scrollController.offset - (50 - offsetFromBottom),
//        duration: Duration(milliseconds: 500),
//        curve: Curves.easeOut,
//      );
//    }
//  }

//  Future<void> _requestGetNotification(BuildContext context) async {
//    LoadingView().startLoading(context);
//
//    pagingNo = 1;
//    NotificationModelVO notificationModelVO = new NotificationModelVO();
//    notificationModelVO.itemsPerPage = 10;
//    notificationModelVO.pagingNo = 1;
//
//    try {
//      // set isBackgroundService = true so that ApplicationError will be prompt here instead.
//      await NotificationModel().getNotificationList(context, notificationModelVO).then((result) {
//        LoadingView().stopLoading();
//        this.notificationModelVO = new NotificationModelVO();
//        this.notificationModelVO = result;
//        newMessage = 0;
//
//        setState(() {});
//      });
//    } on SSError catch (err) {
//      LoadingView().stopLoading();
//
//      if ((err.type == SSErrorType.SSErrorTypeApplication && NotificationModel().isApplicationErrorShouldHandleByCaller) || err.type == SSErrorType.SSErrorTypeBusiness) {
//        showDialog<SSDialogResult>(
//          context: context,
//          builder: (BuildContext context) => SSDialog(
//            dialogTag: 187,
//            title: SSString.APP_NAME,
//            description: NotificationModel().constructAnyErrorMessageWithCode(err),
//            okButtonText: SSString.ALERT_BTN_OK,
//            cancelButtonText: "",
//          ),
//        ).then((dialogResult) {});
//      }
//    }
//  }
}
