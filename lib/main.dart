import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_app_tusa/ui/chatroom.dart';
// import 'package:firebase_core/firebase_core.dart'; not nessecary
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'model/user_login_info.dart';
import 'ui/chatUI.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData.light(),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  final UserLoginInfo userInfo;

  const Home({Key key, this.userInfo}) : super(key: key);
  @override
  HomeState createState() => HomeState(userInfo);

}

class HomeState extends State<Home> {
  DatabaseReference itemRef;
  bool _isLoggedIn = false;
 
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var userInfo;

  HomeState(this.userInfo);

  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase.instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference().child('controlPanel');
    itemRef.onChildAdded.listen(_onEntryAdded);
  //  itemRef.onChildChanged.listen(_onEntryChanged);


  }
  _onEntryAdded(Event event) {
  //  print("TEST STATUS: !:"+ Status.fromSnapshot(event.snapshot).isAble);

  }

//  _onEntryChanged(Event event) {
//    var old = items.singleWhere((entry) {
//      return entry.key == event.snapshot.key;
//    });
//    setState(() {
//      items[items.indexOf(old)] = Item.fromSnapshot(event.snapshot);
//    });
//  }
  Future<void> checkConnection() async {
    try {
   //   Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      showAlertDialog(context);
    }
  }
void   showAlertDialog(BuildContext context) {

  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("OK"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text("not ok you also need to be Ok"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Oi No Internet connection lah "),
    content: Text("Msg kamu akan hantar once your phone reconnect to internet"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
  void goChatUI() {
    UserLoginInfo(userName:"Test Name");
    checkConnection();
    final FormState form = formKey.currentState;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatUI(userInfo: _googleSignIn.currentUser.displayName,photoUrl:_googleSignIn.currentUser.photoUrl)),
    );
  }

  _login() async{
    try{
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
      });
    } catch (err){
      print(err);
    }
  }

  _logout(){
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: _isLoggedIn
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(_googleSignIn.currentUser.photoUrl, height: 50.0, width: 50.0,),
                Text(_googleSignIn.currentUser.displayName),
                OutlineButton( child: Text("Logout"), onPressed: (){
                  _logout();
                },),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    goChatUI();
                  },
                ),
              ],
            )
                : Center(
              child: OutlineButton(
                child: Text("Login with Google"),
                onPressed: () {
                  _login();
                },
              ),
            )),
      ),
    );
  }
}
//class Status {
//  String key;
//  String isAble;
//
//  Status(this.isAble);
//
//  Status.fromSnapshot(DataSnapshot snapshot)
//      : key = snapshot.key,
//        isAble = snapshot.value["isAble"];
//  toJson() {
//    return {
//      "isAble": isAble,
//    };
//  }
//
//
//}
