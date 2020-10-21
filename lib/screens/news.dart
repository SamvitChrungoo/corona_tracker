import 'dart:async';

import 'package:corona_tracker/screens/common_components/custom_container.dart';
import 'package:corona_tracker/stores/corona_store.dart';
import 'package:corona_tracker/utils/locator.dart';
import 'package:corona_tracker/utils/screen_ratio.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  CoronaStore coronaStore;
  double wr = ScreenRatio.widthRatio;
  double hr = ScreenRatio.heightRatio;
  @override
  void initState() {
    coronaStore = locator<CoronaStore>();
    coronaStore.setNewsLoading(true);
    getNews();
    super.initState();
  }

  getNews() async {
    await coronaStore.getNews();
    coronaStore.setNewsLoading(false);
    Timer(const Duration(seconds: 2), () {
      print('Closing WebView after 2 seconds...');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Latest News on COVID-19"),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Image.asset(
              "assets/images/background.jpg",
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: (!coronaStore.isNewsLoading)
                ? Column(
                    children: <Widget>[
                      CustomContainer(
                        text: "News",
                        width: 100,
                      ),
                      Container(
                        height: 900,
                        child: ListView.builder(
                          itemCount: coronaStore.newsData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () async {
                                await launch(coronaStore.newsData[index].url);
                              },
                              child: Card(
                                elevation: 2,
                                margin: EdgeInsets.all(10),
                                child: Container(
                                    height: 130 * hr,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 4,
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    height: 100 * hr,
                                                    child: (coronaStore
                                                                .newsData[index]
                                                                .urlToImage ==
                                                            "")
                                                        ? Image.asset(
                                                            "assets/images/noImage.png")
                                                        : Image.network(
                                                            coronaStore
                                                                .newsData[index]
                                                                .urlToImage,
                                                            fit: BoxFit.cover,
                                                          ),
                                                  )),
                                              Container(
                                                  width: 0.5,
                                                  color: Colors.grey[300]),
                                              Expanded(
                                                  flex: 6,
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 3,
                                                            horizontal: 8),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        Text(
                                                          "${coronaStore.newsData[index].title}",
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        SizedBox(height: 15),
                                                        Container(
                                                          child: Text(
                                                            "${coronaStore.newsData[index].description}",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 3,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 0.5,
                                          color: Colors.grey[300],
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  "Published: ${coronaStore.newsData[index].publishedAt.substring(0, 10)}",
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                Text(
                                                  "Source: ${coronaStore.newsData[index].source.name}",
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )
                : Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 225 * hr,
                        ),
                        Container(
                            height: 70,
                            width: 70,
                            child: FlareActor(
                              "assets/animations/loading.flr",
                              animation: "Alarm",
                            )),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
