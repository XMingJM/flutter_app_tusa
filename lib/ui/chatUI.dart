import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_app_tusa/model/user_login_info.dart';
import 'package:flutter_app_tusa/ui/testgame1.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_app_tusa/ui/chatroom.dart';
// import 'package:firebase_core/firebase_core.dart'; not nessecary
import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;

class ChatUI extends StatefulWidget {
  final String userInfo;
  final String photoUrl;
  ChatUI({Key key, @required this.userInfo, @required this.photoUrl}) ;
  @override
  ChatUIState createState() =>ChatUIState(userInfo,photoUrl);

}

class ChatUIState extends State<ChatUI> {
  int isFirstTimeCount = 0;
  List<Item> items = List();
  Item item;
  DatabaseReference itemRef;
  final scrollController = ScrollController();
  // In the constructor, require a Todo.
  final String userInfo ;
  final String photoUrl ;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String textValue = 'Hello World !';
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();
  File _image;
  String _uploadedFileURL;
  ChatUIState(this.userInfo, this.photoUrl);


  @override
  void initState() {
    super.initState();
    item = Item("", "");
    final FirebaseDatabase database = FirebaseDatabase.instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference().child('chattingData');
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(platform);
    sendAndRetrieveMessage();
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showNotification("test","test");
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        showNotification("test","test");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        showNotification("test","test");
      },
    );

    var initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    var onDidReceiveLocalNotification;
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);


    //    firebaseMessaging.configure(
//      onLaunch: (Map<String, dynamic> msg) {
//        print(" onLaunch called ${(msg)}");
//      },
//      onResume: (Map<String, dynamic> msg) {
//        print(" onResume called ${(msg)}");
//      },
//      onMessage: (Map<String, dynamic> msg) {
//        showNotification(msg);
//        print(" onMessage called ${(msg)}");
//      },
//    );
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print('IOS Setting Registed');
    });
    firebaseMessaging.getToken().then((token) {
      update(token);
    });
//    scrollController.addListener(() {
//      if (scrollController.position.maxScrollExtent == scrollController.offset && notificationModelVO.isLoadMoreAvailable) {
//        if (!isLoading) {
//          setState(() {
//            isLoading = true;
//          });
//
//          loadMore();
//        }
//      }
//    });
  }
  final String serverToken = '<Server-Token>';

  Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'this is a body',
            'title': 'this is a title'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': await firebaseMessaging.getToken(),
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
    Completer<Map<String, dynamic>>();

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );

    return completer.future;
  }

  _onEntryAdded(Event event) {
    print("GOT NEW DATA0!:"+ Item.fromSnapshot(event.snapshot).body);


    if (isFirstTimeCount ==1){
      showNotification(Item.fromSnapshot(event.snapshot).title,Item.fromSnapshot(event.snapshot).body);
    }else{
      Timer(
        Duration(milliseconds: 100),
            () =>  scrollController.jumpTo(scrollController.position.maxScrollExtent),
      );
      Timer(
        Duration(milliseconds: 100),
            () =>  (isFirstTimeCount =1),
      );
    }
//    HapticFeedback.vibrate();
    setState(() {
      items.add(Item.fromSnapshot(event.snapshot));

    });

  }

  _onEntryChanged(Event event) {
    var old = items.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      items[items.indexOf(old)] = Item.fromSnapshot(event.snapshot);
    });
  }


//  showNotification(Map<String, dynamic> msg) async {
//    var android = new AndroidNotificationDetails(
//      'sdffds dsffds',
//      "CHANNLE NAME",
//      "channelDescription",
//    );
//    var iOS = new IOSNotificationDetails();
//    var platform = new NotificationDetails(android, iOS);
//    await flutterLocalNotificationsPlugin.show(
//        0, "This is title", "this is demo", platform);
//  }

  update(String token) {
    print(token);
    DatabaseReference databaseReference = new FirebaseDatabase().reference();
    databaseReference.child('fcm-token/${token}').set({"token": token});
    textValue = token;
    setState(() {});
  }
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

  void   showDevDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("OK"),
      onPressed:  () {
        userInfo=="Ham Jun Ming"?
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TestGame1()),
        ):
        Navigator.of(context).pop();

      },
    );
    Widget continueButton = FlatButton(
      child:userInfo=="Ham Jun Ming"? Text("Back") : Text("not ok you also need to be Ok"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning: Entering Dev mode"),
      content: userInfo=="Ham Jun Ming"?Text("Welcome Jun Ming"): Text("You do not have the permission to enter"),
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


  Future<void> handleSubmit() async {
    String location =await getLocation();
    checkConnection();

    if (item.body == null){
      item.body = ".";
    }
    if (_uploadedFileURL != null){
    item.imageUploadedUrl = _uploadedFileURL;
    print("_uploadedFileURL XXXXXXXXXXXXXXX:"+ _uploadedFileURL);
    }else{
      item.imageUploadedUrl = null;
    }

    item.currentPlace = location;
    item.title =userInfo;
    item.photoUrl = photoUrl;
    final FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();
      form.reset();
      itemRef.push().set(item.toJson());
      clearFileAndUrl();
      Timer(
        Duration(milliseconds: 100),
            () =>  scrollController.jumpTo(scrollController.position.maxScrollExtent),
      );
    }


//    Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => ChatRoom()),
//    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JM Chat v0.0.4'),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: new IconButton(
                icon: new Icon(Icons.developer_board, color: Colors.blueGrey),
                onPressed: () =>     showDevDialog(context),
              ),
          ),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                    Icons.more_vert
                ),
              )
          ),
        ],
      ),
      resizeToAvoidBottomPadding: true,
      body: Column(
        children: <Widget>[
          Flexible(
            child: FirebaseAnimatedList(
              controller: scrollController,
              query: itemRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return new
//                ListView.builder(
//                    physics: AlwaysScrollableScrollPhysics(),
//                    padding: EdgeInsets.only(top: 20.5),
//                  //  controller: scrollController,
//                    scrollDirection: Axis.vertical,
//                    shrinkWrap: true,
//                    itemCount: index,
//                    itemBuilder: (BuildContext context, int i) {
                //return
                Container(
                  padding: EdgeInsets.only(top: 10.5,bottom:10.5,left:10,),
                  child: Row(

                    children: <Widget>[
                      Image.network(items[index].photoUrl!=null?items[index].photoUrl: "http://www.gravatar.com/avatar/3b3be63a4c2a439b013787725dfce802?d=identicon", height: 50.0, width: 50.0,),
                      Container(
                        width: 350,
                        padding: EdgeInsets.only(top: 10.5,bottom:10.5,left:10,),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text((items[index].time) != null?items[index].time:"no data"),
                            SizedBox(
                              height:5,
                            ),
                            Container( // add this
                              child: Text(
                                items[index].currentPlace != null?items[index].currentPlace:"no data",
                                maxLines: 3, // you can change it accordingly/ and this
                              ),
                            ),
                            SizedBox(
                              height:5,
                            ),
                            Text(items[index].title != null?(items[index].title + ":"):"no data", maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold) ),
                            SizedBox(
                              height:5,
                            ),

                            Text(items[index].body != null?items[index].body:"no data", softWrap: true, ),
                            SizedBox(
                              height:5,
                            ),

                            items[index].imageUploadedUrl != null
                                ?
                            GestureDetector(
                              child: Image.network(
                                items[index].imageUploadedUrl,
                                height: 150,
                              ),
                              onTap: () {
                          //
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                      elevation: 16,

                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height,
                                        child: Hero(
                                          tag: 'imageHero',
                                          child: Image.network(
                                            items[index].imageUploadedUrl,
                                          ),
                                        ),
                                      ),


                                    );
                                  },
                                );
                              },
                            )
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),

                );
//                    }
//                    );


                /*      return new ListTile(
                  leading: Icon(Icons.message),
                  title: Text(items[index].title),
                  subtitle: Text(items[index].body),

                );*/
              },
            ),
          ),
          Flexible(
            flex: 0,
            child: Center(
              child: Form(
                key: formKey,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
//                    ListTile(
//                      leading: Icon(Icons.info),
//                      title: TextFormField(
//                        initialValue: "",
//                        onSaved: (val) => item.title = val,
//                        validator: (val) => val == "" ? val : null,
//                      ),
//                    ),
                    ListTile(
                      leading: Icon(Icons.info),
                      title: TextFormField(
                        initialValue: '',
                        onSaved: (val) => item.body = val,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        DateTime now = DateTime.now();
                        String formattedDate = DateFormat('EEE d MMM kk:mm:ss').format(now);
                        item.time = formattedDate;
                        if (_image != null){
                          print ("_imageX XXXXXXXXXXXX");
                          uploadFile();
                        } else{
                          handleSubmit();
                        }
                      },
                    ),
                     Column(
                      children: <Widget>[
                        _image != null
                            ? Image.asset(
                          _image.path,
                          height: 150,
                        )
                            : Container(height: 10),
                        _image == null
                            ? RaisedButton(
                          child: Text('Choose File'),
                          onPressed: chooseFile,
                          color: Colors.cyan,
                        )
                            : Container(),
//                        _image != null
//                            ? RaisedButton(
//                          child: Text('Upload File'),
//                          onPressed: uploadFile,
//                          color: Colors.cyan,
//                        )
 //                           : Container(),
                        _image != null
                            ? RaisedButton(
                          child: Text('Clear Selection'),
                          onPressed: clearFileAndSet,
                        )
                            : Container(),
//                        Text('Uploaded Image'),
//                        _uploadedFileURL != null
//                            ? Image.network(
//                          _uploadedFileURL,
//                          height: 150,
//                        )
//                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }
   clearFile()  {
      _image = null;
  }
  clearFileAndSet()  {
    setState(() {
      _image = null;
    });
  }
  clearFileAndUrl()  {
    setState(() {
      _image = null;
      _uploadedFileURL = null;
    });
  }
   uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance.ref().child('chats/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        clearFile();
      });
    });
  //  await    handleSubmit();
    Timer(
      Duration(milliseconds: 100),
          () =>     handleSubmit(),
    );

  }


  Future<void> showNotification(String title, String text) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    if (title!=userInfo){
      await flutterLocalNotificationsPlugin.show(
          0, 'You got new message from '+ title, text, platformChannelSpecifics,
          payload: 'item x');
    }
  }



  Future<void> onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  Future<String> getLocation() async {
    Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    var geolocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
    List<Placemark> p = await Geolocator().placemarkFromCoordinates(
        position.latitude, position.longitude);
    Placemark place = p[0];
   String currentAddress = "${place.name},${place.subThoroughfare},${place.thoroughfare},${place.subLocality} , ${place.locality}, ${place.postalCode}, ${place.country}";
    print(position == null ? 'currentAddress' : currentAddress);
    return currentAddress;
  }


}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

class Item {
  String key;
  String title;
  String body;
  String time;
  String currentPlace;
  String photoUrl;
  String imageUploadedUrl;

  Item(this.title, this.body);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value["title"],
        body = snapshot.value["body"],
        time = snapshot.value["time"],
        photoUrl = snapshot.value["photoUrl"],
        imageUploadedUrl = snapshot.value["imageUploadedUrl"],
        currentPlace = snapshot.value["currentPlace"];
  toJson() {
    return {
      "title": title,
      "body": body,
      "time" : time,
      "photoUrl" : photoUrl,
      "currentPlace" : currentPlace,
      "imageUploadedUrl" : imageUploadedUrl,
    };
  }


}
