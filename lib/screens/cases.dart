import 'package:corona_tracker/screens/common_components/custom_container.dart';
import 'package:corona_tracker/screens/pie_chart/pie_chart.dart';
import 'package:corona_tracker/stores/corona_store.dart';
import 'package:corona_tracker/utils/locator.dart';
import 'package:corona_tracker/utils/screen_ratio.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Cases extends StatefulWidget {
  @override
  _CasesState createState() => _CasesState();
}

class _CasesState extends State<Cases> {
  bool isExpanded = false;
  CoronaStore coronaStore;
  double wr = ScreenRatio.widthRatio;
  double hr = ScreenRatio.heightRatio;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    coronaStore = locator<CoronaStore>();
    controller.addListener(() {
      _listenerToTextfield();
    });
    super.initState();
  }

  List tempList = [];
  _listenerToTextfield() {
    if (controller.text == '') {
      tempList = coronaStore.countryData;
    } else {
      tempList = [];
      coronaStore.countryData.forEach((f) {
        var splits = f.country.trim().split(" ");
        if (splits.first
                .toLowerCase()
                .startsWith(controller.text.toLowerCase().trim()) ||
            splits.last
                .toLowerCase()
                .startsWith(controller.text.toLowerCase().trim()) ||
            f.country
                .toLowerCase()
                .startsWith(controller.text.toLowerCase().trim())) {
          tempList.add(f);
        }
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(coronaStore.indiaData);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Image.asset(
              "assets/images/background.jpg",
              fit: BoxFit.cover,
            ),
          ),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: TextField(
                  autofocus: true,
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search by country ... ",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 25 * wr),
                height: 65 * hr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                            ),
                            Text("  - Highly Affected")
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 4 * wr),
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.yellow),
                            ),
                            Text("  - Slightly Affected")
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              // margin: EdgeInsets.only(top: 12 * hr),
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                            ),
                            Text("  - Lightly Affected")
                          ],
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                    isExpanded
                        ? Container(
                            height: 50,
                            margin: EdgeInsets.only(right: 20),
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green),
                            child: FlareActor(
                              "assets/animations/heartbeat.flr",
                              animation: "heartbeat",
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              Container(
                height: 400 * hr,
                child: ListView.builder(
                  itemCount: tempList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          side: BorderSide(width: 1, color: Colors.green[200])),
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      elevation: 5,
                      child: ExpansionTile(
                        onExpansionChanged: (val) {
                          setState(() {
                            isExpanded = val;
                          });
                        },
                        leading: (tempList[index].totalConfirmed > 100000)
                            ? Container(
                                margin: EdgeInsets.only(top: 13 * hr),
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.red),
                              )
                            : (tempList[index].totalConfirmed > 50000)
                                ? Container(
                                    margin: EdgeInsets.only(top: 12 * hr),
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.yellow),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(top: 12 * hr),
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green),
                                  ),
                        title: Text("${tempList[index].country}"),
                        subtitle: Text("Total Cases:  " +
                            "${tempList[index].totalConfirmed}"),
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              CustomPieChart(
                                color: Colors.white,
                                recovered:
                                    tempList[index].totalRecovered.toDouble() *
                                        100 /
                                        tempList[index].totalConfirmed,
                                deaths: tempList[index].totalDeaths.toDouble() *
                                    100 /
                                    tempList[index].totalConfirmed,
                                active:
                                    (tempList[index].totalConfirmed.toDouble() -
                                            (tempList[index]
                                                    .totalRecovered
                                                    .toDouble() +
                                                tempList[index]
                                                    .totalDeaths
                                                    .toDouble())) *
                                        100 /
                                        tempList[index].totalConfirmed,
                                legend1: "Recovered",
                                legend2: "Deaths",
                                legend3: "Active",
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 5 * wr),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        SizedBox(width: 50),
                                        Container(
                                          width: 155 * wr,
                                          child: Text(
                                            "Total Confirmed:",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          " ${tempList[index].totalConfirmed}",
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
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          " ${tempList[index].totalRecovered}",
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
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          " ${tempList[index].totalDeaths}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 50),
                                      ],
                                    ),
                                    SizedBox(height: 20)
                                  ],
                                ),
                              ),
                              CustomContainer(text: "New Cases", width: 100),
                              SizedBox(height: 20),
                              Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        SizedBox(width: 50),
                                        Container(
                                          width: 155 * wr,
                                          child: Text(
                                            "New Confirmed:",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          " ${tempList[index].newConfirmed}",
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
                                            "New Recoverd:",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          " ${tempList[index].newRecovered}",
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
                                            "New Deaths:",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          " ${tempList[index].newDeaths}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 50),
                                      ],
                                    ),
                                    SizedBox(height: 20)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
