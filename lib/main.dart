import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';
import 'package:toast/toast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zarrrinpal Demo',
      home: MyHomePage(title: 'Zarrrinpal Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final codecontroller = TextEditingController();

_launchURL(var cost) async {
  String url =
      'http://nitche47.infinityfreeapp.com/myzarinpal/request.php?cost=$cost';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Container(
          decoration: new BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'درگاه پرداخت تستی',
                style: TextStyle(fontSize: 40.0, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 80.0, left: 40.0, right: 40.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: codecontroller,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      enabledBorder: new UnderlineInputBorder(
                          borderSide: new BorderSide(
                        color: Colors.white,
                      )),
                      border: new UnderlineInputBorder(
                          borderSide: new BorderSide(
                        color: Colors.white,
                      )),
                      hintText: 'مبلغ مورد نظر',
                      hintStyle: TextStyle(),
                      alignLabelWithHint: true,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.0, left: 40.0, right: 40.0),
                child: MaterialButton(
                  color: Colors.purple,
                  onPressed: () async {
                    if (codecontroller.text.isEmpty) {
                      Toast.show("لطفا یک عدد وارد کنید", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                    } else {
                      int cost = int.parse(codecontroller.text);
                      if (cost <= 10000000 && cost >= 1000) {
                        await initUniLinks();
                        _launchURL(cost);
                      } else {
                        Toast.show(
                            "لطفا یک عدد وارد کنید بزرگ تر از 100 و گوچگ تر از 10000000",
                            context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.CENTER);
                      }
                    }
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: new Stack(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'پرداخت',
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ]),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  StreamSubscription _sub;
  Future<Null> initUniLinks() async {
    _sub = getLinksStream().listen((String link) async {
      String ss = link.replaceAll("zarinpaltest://nitche/", "");
      if (ss == "success") {
        Toast.show("پرداخت موفق بود", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
        return null;
      } else {
        Toast.show("پرداخت ناموفق بود ", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
        return null;
      }
    }, onError: (err) {});
  }
}
