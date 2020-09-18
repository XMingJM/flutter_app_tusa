import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TestGame1 extends StatefulWidget {

  TestGame1({Key key, }) ;
  @override
  TestGame1State createState() =>TestGame1State();
}

class TestGame1State extends State<TestGame1> {
  double test1percent = 0.9;
  double test2percent= 0.8;
  double test3percent= 0.7;
  double test4percent= 0.6;
  double test5percent= 0.5;
  double test6percent = 0.5;
  double test7percent = 0.5;
  String questionText;
  String selection1;
  String selection2;
  String selection3;
  String selection4;
  int status1NoChangeA1;
  int status2NoChangeA1;
  int status3NoChangeA1;
  int status4NoChangeA1;
  int status5NoChangeA1;
  int status6NoChangeA1;
  int status7NoChangeA1;
  int status1NoChangeA2;
  int status2NoChangeA2;
  int status3NoChangeA2;
  int status4NoChangeA2;
  int status5NoChangeA2;
  int status6NoChangeA2;
  int status7NoChangeA2;
  int status1NoChangeA3;
  int status2NoChangeA3;
  int status3NoChangeA3;
  int status4NoChangeA3;
  int status5NoChangeA3;
  int status6NoChangeA3;
  int status7NoChangeA3;
  int status1NoChangeA4;
  int status2NoChangeA4;
  int status3NoChangeA4;
  int status4NoChangeA4;
  int status5NoChangeA4;
  int status6NoChangeA4;
  int status7NoChangeA4;
  List<QuestionBank> questionBank = List();

  @override
  void initState() {

    initQuestion();
    randomPickQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Linear Percent Indicators"),
      ),
      body:
          Container(

            child: Row(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: new LinearPercentIndicator(
                        width: 170.0,
                        animation: true,
                        animationDuration: 1000,
                        lineHeight: 20.0,
                        leading: new Text("國庫:"),
                        trailing:  Icon(Icons.mood),
                        percent: test1percent,
                        center: Text((test1percent*100).toString()+ "%"),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: CheckColorDisplay(test1percent),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: new LinearPercentIndicator(
                        width: 170.0,
                        animation: true,
                        animationDuration: 1000,
                        lineHeight: 20.0,
                        leading: new Text("經濟:"),
                        trailing:  Icon(Icons.mood),
                        percent: test2percent,
                        center: Text((test2percent*100).toString()+ "%"),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: CheckColorDisplay(test2percent),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: new LinearPercentIndicator(
                        width: 170.0,
                        animation: true,
                        animationDuration: 1000,
                        lineHeight: 20.0,
                        leading: new Text("衛生:"),
                        trailing:  Icon(Icons.mood),
                        percent: test3percent,
                        center: Text((test3percent*100).toString()+ "%"),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: CheckColorDisplay(test3percent),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: new LinearPercentIndicator(
                        width: 170.0,
                        animation: true,
                        animationDuration: 1000,
                        lineHeight: 20.0,
                        leading: new Text("軍隊:"),
                        trailing:  Icon(Icons.mood),
                        percent: test4percent,
                        center: Text((test4percent*100).toString()+ "%"),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: CheckColorDisplay(test4percent),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: new
                      LinearPercentIndicator(
                        width: 170.0,
                        animation: true,
                        animationDuration: 1000,
                        lineHeight: 20.0,
                        leading: new Text("種族和諧:"),
                        trailing:  Icon(Icons.mood),
                        percent:((test6percent>test7percent? ((test6percent*100)-(test7percent*100)/100):
                        test6percent<test7percent?((test7percent*100)-(test6percent*100)/100):100.0)/100),
                        center: Text(( (test6percent>test7percent? ((test6percent*100)-(test7percent*100)/100):
                        test6percent<test7percent?((test7percent*100)-(test6percent*100)/100):100.0)  ).toString()+ "%"),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: CheckColorDisplay((test6percent>test7percent? ((test6percent*100)-(test7percent*100)/100):
                        test6percent<test7percent?((test7percent*100)-(test6percent*100)/100):100.0)/100),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: new LinearPercentIndicator(
                          width: 170.0,
                          animation: true,
                          animationDuration: 1000,
                          lineHeight: 20.0,
                          leading: new Text("選票支持率:"),
                          trailing:  Icon(Icons.mood),
                          percent: (((test6percent/2*100)+(test7percent/2*100))/100)!=1.0?
                          (((test6percent/2*100)+(test7percent/2*100))/100)==0.0?0.0:
                          (((test6percent/2*100)+(test7percent/2*100))/100):1.0,
                          center: Text((((test6percent/2*100)+(test7percent/2*100))).toString()+ "%"),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: CheckColorDisplay((((test6percent/2*100)+(test7percent/2*100))/100)),
                        ),
                      ),
                    ),
Expanded(
  child: Text(
    questionText!=null?questionText:"no data",style: TextStyle(fontSize: 20) ,
    maxLines: 3, // you can change it accordingly/ and this
  ),
),
Container(
  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
  child: RaisedButton(
    onPressed: () {
          test1percent=   calculateChanged(test1percent,status1NoChangeA1);
          test2percent=   calculateChanged(test2percent,status2NoChangeA1);
          test3percent=   calculateChanged(test3percent,status3NoChangeA1);
          test4percent=   calculateChanged(test4percent,status4NoChangeA1);
          test5percent=   calculateChanged(test5percent,status5NoChangeA1);
          test6percent=   calculateChanged(test6percent,status6NoChangeA1);
          test7percent=   calculateChanged(test7percent,status7NoChangeA1);
          setState(() {
                randomPickQuestion();
          });
    },
    child:  Text(selection1!=null?selection1:'Enabled Button 1', style: TextStyle(fontSize: 16)),
  ),
),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: RaisedButton(
                        onPressed: () {
                          test1percent=   calculateChanged(test1percent,status1NoChangeA2);
                          test2percent=   calculateChanged(test2percent,status2NoChangeA2);
                          test3percent=   calculateChanged(test3percent,status3NoChangeA2);
                          test4percent=   calculateChanged(test4percent,status4NoChangeA2);
                          test5percent=   calculateChanged(test5percent,status5NoChangeA2);
                          test6percent=   calculateChanged(test6percent,status6NoChangeA2);
                          test7percent=   calculateChanged(test7percent,status7NoChangeA2);
                          setState(() {
                            randomPickQuestion();
                          });
                        },
                        child: Text(selection2!=null?selection2:'Enabled Button 2', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: RaisedButton(
                        onPressed: () {
                          test1percent=   calculateChanged(test1percent,status1NoChangeA3);
                          test2percent=   calculateChanged(test2percent,status2NoChangeA3);
                          test3percent=   calculateChanged(test3percent,status3NoChangeA3);
                          test4percent=   calculateChanged(test4percent,status4NoChangeA3);
                          test5percent=   calculateChanged(test5percent,status5NoChangeA3);
                          test6percent=   calculateChanged(test6percent,status6NoChangeA3);
                          test7percent=   calculateChanged(test7percent,status7NoChangeA3);
                          setState(() {
                            randomPickQuestion();
                          });
                        },
                        child:  Text(selection3!=null?selection3:'Enabled Button 3', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: RaisedButton(
                        onPressed: () {
                          test1percent=   calculateChanged(test1percent,status1NoChangeA4);
                          test2percent=   calculateChanged(test2percent,status2NoChangeA4);
                          test3percent=   calculateChanged(test3percent,status3NoChangeA4);
                          test4percent=   calculateChanged(test4percent,status4NoChangeA4);
                          test5percent=   calculateChanged(test5percent,status5NoChangeA4);
                          test6percent=   calculateChanged(test6percent,status6NoChangeA4);
                          test7percent=   calculateChanged(test7percent,status7NoChangeA4);
                          setState(() {
                            randomPickQuestion();
                          });
                        },
                        child: Text(selection4!=null?selection4:'Enabled Button 4', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
                Container(

                  child: new CircularPercentIndicator(
                    radius: 45.0,
                    lineWidth: 4.0,
                    header: new Text("M"),
                    percent: test6percent,
                    center: new Text((test6percent*100).toString()+ "%"),
                    progressColor: CheckColorDisplay(test6percent),
                  ),

                ),
                Container(

                  child: new CircularPercentIndicator(
                    radius: 45.0,
                    header: new Text("C"),
                    lineWidth: 4.0,
                    percent: test7percent,
                    center: new Text((test7percent*100).toString()+ "%"),
                    progressColor: CheckColorDisplay(test7percent),
                  ),

                ),
              ],
            ),
          ),

    );
  }



  MaterialColor CheckColorDisplay(double percent) {
    //Colors.green
    if (percent ==1.0){
      return Colors.green;
    }else if (percent>=0.8 &&percent <1.0) {
      return Colors.lightGreen;
    }
    else if (percent >=0.6&&percent <0.8) {
      return Colors.yellow;
    }
    else if (percent >=0.5&&percent <0.6) {
      return Colors.orange;
    }
    else if (percent >=0.3&&percent <0.5) {
      return Colors.orange;
    }
    else if (percent >=0.2&&percent <0.3) {
      return Colors.red;
    }else {
    return Colors.red;
    }

  }

  void randomPickQuestion() {

    Random rnd;
    int min = 0;
    int max = questionBank.length-1;
    rnd = new Random();
    var r = min + rnd.nextInt(max - min);
    print("$r is in the range of $min and and $max");
print(questionBank[r]._questionText);
questionText= questionBank[r]._questionText;
    selection1= questionBank[r]._ans1;
    selection2= questionBank[r]._ans2;
    selection3= questionBank[r]._ans3;
    selection4= questionBank[r]._ans4;
    status1NoChangeA1 = questionBank[r]._status1NoChangeA1;
    status2NoChangeA1 = questionBank[r]._status2NoChangeA1;
    status3NoChangeA1 = questionBank[r]._status3NoChangeA1;
    status4NoChangeA1 = questionBank[r]._status4NoChangeA1;
    status5NoChangeA1 = questionBank[r]._status5NoChangeA1;
    status6NoChangeA1 = questionBank[r]._status6NoChangeA1;
    status7NoChangeA1 = questionBank[r]._status7NoChangeA1;
    status1NoChangeA2 = questionBank[r]._status1NoChangeA2;
    status2NoChangeA2 = questionBank[r]._status2NoChangeA2;
    status3NoChangeA2 = questionBank[r]._status3NoChangeA2;
    status4NoChangeA2 = questionBank[r]._status4NoChangeA2;
    status5NoChangeA2 = questionBank[r]._status5NoChangeA2;
    status6NoChangeA2 = questionBank[r]._status6NoChangeA2;
    status7NoChangeA2 = questionBank[r]._status7NoChangeA2;
    status1NoChangeA3 = questionBank[r]._status1NoChangeA3;
    status2NoChangeA3 = questionBank[r]._status2NoChangeA3;
    status3NoChangeA3 = questionBank[r]._status3NoChangeA3;
    status4NoChangeA3 = questionBank[r]._status4NoChangeA3;
    status5NoChangeA3 = questionBank[r]._status5NoChangeA3;
    status6NoChangeA3 = questionBank[r]._status6NoChangeA3;
    status7NoChangeA3 = questionBank[r]._status7NoChangeA3;
    status1NoChangeA4 = questionBank[r]._status1NoChangeA4;
    status2NoChangeA4 = questionBank[r]._status2NoChangeA4;
    status3NoChangeA4 = questionBank[r]._status3NoChangeA4;
    status4NoChangeA4 = questionBank[r]._status4NoChangeA4;
    status5NoChangeA4 = questionBank[r]._status5NoChangeA4;
    status6NoChangeA4 = questionBank[r]._status6NoChangeA4;
    status7NoChangeA4 = questionBank[r]._status7NoChangeA4;
  }

  void initQuestion() {
    // 7

    QuestionBank thequestion1 =
    new QuestionBank('Q1 0 ', 'A1', 'A2', 'A3', 'A4',0,0,0,0,0,1,0  ,1,1,1,1,10,10,0  ,10,10,10,-10,-5,-1,0  ,-1,-20,0,0,0,0,0);
    questionBank.add(thequestion1) ;

    QuestionBank thequestion2 =
    new QuestionBank('Q2 1', 'A1', 'A2', 'A3', 'A4',1,1,1,1,1,1,1  ,1,1,1,1,1,1,1,  1,1,1,1,1,1,1,  1,1,1,1,1,1,1);
    questionBank.add(thequestion2) ;

    QuestionBank thequestion3 =
    new QuestionBank('Q3 a -1', 'A1', 'A2', 'A3', 'A4',-1,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,-1,-1,-1,-1,-1,-1,1,1,-1,-1,-1,-1,-1,-1,-1);
    questionBank.add(thequestion3) ;

    QuestionBank thequestion4 =
    new QuestionBank('Q4 -1101-1', 'A1', 'A2', 'A3', 'A4',0,0,0,0,-1,1,0,1,-1,-1,1,0,1,-1,-1,1,0,1,-1,-1,1,0,1,-1,4,4,4,4,);
    questionBank.add(thequestion4) ;

    QuestionBank thequestion5 =
    new QuestionBank('Q5 11000', 'A1', 'A2', 'A3', 'A4',1,1,0,0,0,1,1,0,0,0,0,0,0,0,1,1,0,0,0,1,1,0,0,0,1,1,9,-30);
    questionBank.add(thequestion5) ;


  }

  double calculateChanged(double oriNo, toChange) {
    double result;
    if (((oriNo *100)+ toChange) <=100 && ((oriNo *100)+toChange)>= 0){
      result = ((oriNo *100)+toChange)/100;
    }else if (((oriNo *100)+ toChange)>100){
      result =1.0;
    }else if (((oriNo *100)+ toChange)<0){
      result = 0.0;
    }
     result = double.parse(result.toStringAsFixed(2));
    //result = result - result % 0.01;
    print("RETURN:" +result.toString());
    return result;
  }
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: new AppBar(
//        title: new Text("Circular Percent Indicators"),
//      ),
//      body: Center(
//        child: ListView(
//            children: <Widget>[
//              new CircularPercentIndicator(
//                radius: 100.0,
//                lineWidth: 10.0,
//                percent: 0.8,
//                header: new Text("Icon header"),
//                center: new Icon(
//                  Icons.person_pin,
//                  size: 50.0,
//                  color: Colors.blue,
//                ),
//                backgroundColor: Colors.grey,
//                progressColor: Colors.blue,
//              ),
//              new CircularPercentIndicator(
//                radius: 130.0,
//                animation: true,
//                animationDuration: 1200,
//                lineWidth: 15.0,
//                percent: 0.4,
//                center: new Text(
//                  "40 hours",
//                  style:
//                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//                ),
//                circularStrokeCap: CircularStrokeCap.butt,
//                backgroundColor: Colors.yellow,
//                progressColor: Colors.red,
//              ),
//              new CircularPercentIndicator(
//                radius: 120.0,
//                lineWidth: 13.0,
//                animation: true,
//                percent: 0.7,
//                center: new Text(
//                  "70.0%",
//                  style:
//                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//                ),
//                footer: new Text(
//                  "Sales this week",
//                  style:
//                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
//                ),
//                circularStrokeCap: CircularStrokeCap.round,
//                progressColor: Colors.purple,
//              ),
//              Padding(
//                padding: EdgeInsets.all(15.0),
//                child: new CircularPercentIndicator(
//                  radius: 60.0,
//                  lineWidth: 5.0,
//                  percent: 1.0,
//                  center: new Text("100%"),
//                  progressColor: Colors.green,
//                ),
//              ),
//              Container(
//                padding: EdgeInsets.all(15.0),
//                child: new Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    new CircularPercentIndicator(
//                      radius: 45.0,
//                      lineWidth: 4.0,
//                      percent: 0.10,
//                      center: new Text("10%"),
//                      progressColor: Colors.red,
//                    ),
//                    new Padding(
//                      padding: EdgeInsets.symmetric(horizontal: 10.0),
//                    ),
//                    new CircularPercentIndicator(
//                      radius: 45.0,
//                      lineWidth: 4.0,
//                      percent: 0.30,
//                      center: new Text("30%"),
//                      progressColor: Colors.orange,
//                    ),
//                    new Padding(
//                      padding: EdgeInsets.symmetric(horizontal: 10.0),
//                    ),
//                    new CircularPercentIndicator(
//                      radius: 45.0,
//                      lineWidth: 4.0,
//                      percent: 0.60,
//                      center: new Text("60%"),
//                      progressColor: Colors.yellow,
//                    ),
//                    new Padding(
//                      padding: EdgeInsets.symmetric(horizontal: 10.0),
//                    ),
//                    new CircularPercentIndicator(
//                      radius: 45.0,
//                      lineWidth: 4.0,
//                      percent: 0.90,
//                      center: new Text("90%"),
//                      progressColor: Colors.green,
//                    )
//                  ],
//                ),
//              )
//            ]),
//      ),
//    );
//  }
}


class QuestionBank {
  String _questionText;
  String _ans1;
  String _ans2;
  String _ans3;
  String _ans4;
  int _status1NoChangeA1;
  int _status2NoChangeA1;
  int _status3NoChangeA1;
  int _status4NoChangeA1;
  int _status5NoChangeA1;
  int _status6NoChangeA1;
  int _status7NoChangeA1;
  int _status1NoChangeA2;
  int _status2NoChangeA2;
  int _status3NoChangeA2;
  int _status4NoChangeA2;
  int _status5NoChangeA2;
  int _status6NoChangeA2;
  int _status7NoChangeA2;
  int _status1NoChangeA3;
  int _status2NoChangeA3;
  int _status3NoChangeA3;
  int _status4NoChangeA3;
  int _status5NoChangeA3;
  int _status6NoChangeA3;
  int _status7NoChangeA3;
  int _status1NoChangeA4;
  int _status2NoChangeA4;
  int _status3NoChangeA4;
  int _status4NoChangeA4;
  int _status5NoChangeA4;
  int _status6NoChangeA4;
  int _status7NoChangeA4;

  QuestionBank(this._questionText, this._ans1,this._ans2,this._ans3,this._ans4,this._status1NoChangeA1,
      this._status2NoChangeA1,this._status3NoChangeA1,this._status4NoChangeA1,this._status5NoChangeA1,this._status6NoChangeA1,this._status7NoChangeA1
      ,this._status1NoChangeA2,
      this._status2NoChangeA2,this._status3NoChangeA2,this._status4NoChangeA2,this._status5NoChangeA2,
      this._status6NoChangeA2,this._status7NoChangeA2
      ,this._status1NoChangeA3,
      this._status2NoChangeA3,this._status3NoChangeA3,this._status4NoChangeA3,this._status5NoChangeA3,this._status6NoChangeA3,this._status7NoChangeA3
      ,this._status1NoChangeA4,
      this._status2NoChangeA4,this._status3NoChangeA4,this._status4NoChangeA4,this._status5NoChangeA4,this._status6NoChangeA4,this._status7NoChangeA4
      ,
      );

  int get status1NoChange => _status1NoChangeA1;

  set status1NoChange(int value) {
    _status1NoChangeA1 = value;
  }

  String get ans4 => _ans4;

  set ans4(String value) {
    _ans4 = value;
  }

  String get ans3 => _ans3;

  set ans3(String value) {
    _ans3 = value;
  }

  String get ans2 => _ans2;

  set ans2(String value) {
    _ans2 = value;
  }

  String get ans1 => _ans1;

  set ans1(String value) {
    _ans1 = value;
  }

  String get questionText => _questionText;

  set questionText(String value) {
    _questionText = value;
  }

  int get status2NoChange => _status2NoChangeA1;

  set status2NoChange(int value) {
    _status2NoChangeA1 = value;
  }

  int get status3NoChange => _status3NoChangeA1;

  set status3NoChange(int value) {
    _status3NoChangeA1 = value;
  }

  int get status4NoChange => _status4NoChangeA1;

  set status4NoChange(int value) {
    _status4NoChangeA1 = value;
  }

  int get status5NoChange => _status5NoChangeA1;

  set status5NoChange(int value) {
    _status5NoChangeA1 = value;
  }

}
//---------------------------------------------------------------------------------------
/*
=1 status=
Z z   - M C
J j
Env
Ar y
=2 ge=

13 state



https://pub.dev/packages/percent_indicator

* */

