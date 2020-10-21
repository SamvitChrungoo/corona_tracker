import 'package:corona_tracker/screens/pie_chart/pie_chart.dart';
import 'package:corona_tracker/serializers/country_data.dart';
import 'package:corona_tracker/stores/corona_store.dart';
import 'package:corona_tracker/utils/locator.dart';
import 'package:corona_tracker/utils/screen_ratio.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'common_components/custom_container.dart';

class Prevention {
  String text;
  String image;
  Prevention({@required this.text, @required this.image});
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Prevention> prevention = [
    Prevention(text: "Avoid close contact", image: "assets/images/notouch.png"),
    Prevention(text: "Clean your hands", image: "assets/images/hands.png"),
    Prevention(text: "Wear a facemask", image: "assets/images/patient.png"),
  ];
  CoronaStore coronaStore;
  double wr = ScreenRatio.widthRatio;
  double hr = ScreenRatio.heightRatio;
  double totalCases;
  double newTotalCases;
  List<CountryData> top10 = [];

  @override
  void initState() {
    coronaStore = locator<CoronaStore>();

    if (!coronaStore.dataFetched) getInitialData();
    totalCases = coronaStore.globalData.totalConfirmed.toDouble();
    newTotalCases = coronaStore.globalData.newConfirmed.toDouble();
    top10 = coronaStore.countryData;
    getTop10();
    super.initState();
  }

  getInitialData() async {
    try {
      await coronaStore.getData();
    } catch (e) {
      print("ERRRROOOOORRRR  TRYING 2ND TIME  ________     $e");
    }
  }

  getTop10() {
    print(coronaStore.countryData[0].country);
    top10.sort((a, b) => b.totalConfirmed.compareTo(a.totalConfirmed));
    top10 = top10.sublist(0, 10);
    coronaStore.countryData.sort((a, b) => a.country.compareTo(b.country));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: Image.asset(
            "assets/images/background.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Column(
          children: <Widget>[
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  coronaStore.setIsLoading(true);
                  await getInitialData();
                  coronaStore.setIsLoading(false);
                },
                child: Observer(builder: (context) {
                  return coronaStore.isError
                      ? Center(
                          child: Text("ing went wrong please restart the app"),
                        )
                      : (coronaStore.isLoading)
                          ? Center(
                              child: Container(
                                  height: 70 * hr,
                                  width: 70 * wr,
                                  child: FlareActor(
                                    "assets/animations/loading.flr",
                                    animation: "Alarm",
                                  )),
                            )
                          : ListView(
                              children: <Widget>[
                                SizedBox(height: 10 * hr),
                                Container(
                                  margin: EdgeInsets.only(left: 10 * wr),
                                  child: CustomContainer(
                                    text: "Global Data",
                                    width: 120 * wr,
                                  ),
                                ),
                                CustomPieChart(
                                  recovered: coronaStore
                                          .globalData.totalRecovered
                                          .toDouble() *
                                      100 /
                                      totalCases,
                                  deaths: coronaStore.globalData.totalDeaths
                                          .toDouble() *
                                      100 /
                                      totalCases,
                                  active: (coronaStore.globalData.totalConfirmed
                                              .toDouble() -
                                          (coronaStore.globalData.totalRecovered
                                                  .toDouble() +
                                              coronaStore.globalData.totalDeaths
                                                  .toDouble())) *
                                      100 /
                                      totalCases,
                                  legend1: "Recovered",
                                  legend2: "Deaths",
                                  legend3: "Active",
                                  color: Colors.grey[50],
                                ),
                                SizedBox(height: 10 * hr),
                                Column(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            SizedBox(width: 50 * wr),
                                            Container(
                                              width: 155 * wr,
                                              child: Text(
                                                "Total Confirmed:",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Text(
                                              " ${coronaStore.globalData.totalConfirmed.toString()}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(width: 50),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            SizedBox(width: 50),
                                            Container(
                                              width: 155 * wr,
                                              child: Text(
                                                "Total Recoverd:",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Text(
                                              " ${coronaStore.globalData.totalRecovered.toString()}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(width: 50),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            SizedBox(width: 45),
                                            Container(
                                              width: 155 * wr,
                                              child: Text(
                                                "Total Deaths:",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Text(
                                              " ${coronaStore.globalData.totalDeaths.toString()}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(width: 50),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30 * hr),
                                    Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: CustomContainer(
                                        text: "Today's Data",
                                        width: 120 * wr,
                                      ),
                                    ),
                                    CustomPieChart(
                                      recovered: coronaStore
                                              .globalData.newRecovered
                                              .toDouble() *
                                          100 /
                                          newTotalCases,
                                      deaths: coronaStore.globalData.newDeaths
                                              .toDouble() *
                                          100 /
                                          newTotalCases,
                                      active: (coronaStore
                                                  .globalData.newConfirmed
                                                  .toDouble() -
                                              (coronaStore
                                                      .globalData.newRecovered
                                                      .toDouble() +
                                                  coronaStore
                                                      .globalData.newDeaths
                                                      .toDouble())) *
                                          100 /
                                          newTotalCases,
                                      legend1: "Recovered",
                                      legend2: "Deaths",
                                      legend3: "Active",
                                      color: Colors.grey[50],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            SizedBox(width: 50),
                                            Container(
                                              width: 165 * wr,
                                              child: Text(
                                                "Confirmed Today:",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Text(
                                              " ${coronaStore.globalData.newConfirmed.toString()}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(width: 50),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            SizedBox(width: 50),
                                            Container(
                                              width: 165 * wr,
                                              child: Text(
                                                "Recoverd Today:",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Text(
                                              " ${coronaStore.globalData.newRecovered.toString()}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(width: 50),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            SizedBox(width: 43),
                                            Container(
                                              width: 165 * wr,
                                              child: Text(
                                                "Deaths Today:",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Text(
                                              " ${coronaStore.globalData.newDeaths.toString()}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(width: 50 * wr),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Container(
                                      margin: EdgeInsets.only(left: 20 * wr),
                                      child: CustomContainer(
                                        text: "Stay SAFE , Stay HOME",
                                        width: 220,
                                      ),
                                    ),
                                    SizedBox(height: 10 * hr),
                                    Column(
                                      children: <Widget>[
                                        precaution(
                                            "Clean your hands often. Use soap and water, or an alcohol-based hand rub."),
                                        precaution(
                                            "Maintain a safe distance from anyone who is coughing or sneezing."),
                                        precaution(
                                            "Don’t touch your eyes, nose or mouth."),
                                        precaution(
                                            "Cover your nose and mouth with your bent elbow or a tissue when you cough or sneeze."),
                                        precaution(
                                            "Stay home if you feel unwell."),
                                        precaution(
                                            "If you have a fever, cough and difficulty breathing, seek medical attention. Call in advance."),
                                        SizedBox(height: 15),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: prevention
                                          .map((data) => Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    height: 70,
                                                    width: 70,
                                                    child: ClipOval(
                                                        child: Image.asset(
                                                            data.image)),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                      width: 120,
                                                      child: Center(
                                                        child: Text(
                                                          data.text,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ))
                                                ],
                                              ))
                                          .toList(),
                                    ),
                                    SizedBox(height: 15),
                                    CustomContainer(
                                      text: "Top 10 Affected Countries",
                                      width: 230 * wr,
                                    ),
                                    Column(
                                        children: top10.map((data) {
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            side: BorderSide(
                                                width: 1,
                                                color: Colors.green[200])),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        elevation: 2,
                                        child: ListTile(
                                          title: Text(
                                              "${top10.indexOf(data) + 1}. ${top10[top10.indexOf(data)].country}"),
                                          subtitle: Text("Total Cases:  " +
                                              "${top10[top10.indexOf(data)].totalConfirmed}"),
                                        ),
                                      );
                                    }).toList()),
                                  ],
                                ),
                              ],
                            );
                }),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget precaution(String text) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
            ),
            Container(
              width: 320 * wr,
              child: Text(text),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
