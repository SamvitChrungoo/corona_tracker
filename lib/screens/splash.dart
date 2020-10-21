import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:corona_tracker/screens/home.dart';
import 'package:corona_tracker/stores/corona_store.dart';
import 'package:corona_tracker/utils/locator.dart';
import 'package:corona_tracker/utils/screen_ratio.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  CoronaStore coronaStore;
  List<Color> colors = [Colors.green[300], Colors.grey[200]];
  List<double> stops = [0.0, 0.7];

  @override
  void initState() {
    coronaStore = locator<CoronaStore>();
    getInitialData();
    super.initState();
  }

  getInitialData() async {
    try {
      await coronaStore.getData();
    } catch (e) {
      await coronaStore.setError();
    }
    await coronaStore.getIndiaData();

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    ScreenRatio.setScreenRatio(queryData.size.height, queryData.size.width,
        queryData.devicePixelRatio);
    double wr = ScreenRatio.widthRatio;
    double hr = ScreenRatio.heightRatio;

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          decoration: BoxDecoration(
              gradient:
                  RadialGradient(colors: colors, stops: stops, radius: 2)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(),
            Container(
              margin: EdgeInsets.only(left: 20 * wr),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100.0),
                      topLeft: Radius.circular(100.0))),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Covid Data App",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Ubuntu'),
                    ),
                    Container(
                        height: 50 * hr,
                        width: 50 * wr,
                        child: FlareActor(
                          "assets/animations/heartbeat.flr",
                          animation: "heartbeat",
                        )),
                  ],
                ),
              ),
              height: 140 * hr,
              width: double.infinity,
            ),
            SizedBox(),
            Container(
                margin: EdgeInsets.only(bottom: 30 * hr),
                height: 200 * hr,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: FlareActor(
                        "assets/animations/home.flr",
                        animation: "home",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "\"Stay",
                          style: TextStyle(fontSize: 20, fontFamily: 'Ubuntu'),
                        ),
                        SizedBox(width: 5 * wr),
                        RotateAnimatedTextKit(
                            text: ["HOME", "SAFE", "HOME", "SAFE"],
                            textStyle: TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.start,
                            alignment: AlignmentDirectional
                                .topStart // or Alignment.topLeft
                            ),
                        Text(
                          "\"",
                          style: TextStyle(fontSize: 20, fontFamily: 'Ubuntu'),
                        ),
                      ],
                    )
                  ],
                )),
          ],
        ),
      ],
    ));
  }
}
