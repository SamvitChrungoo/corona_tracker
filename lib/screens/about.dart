import 'package:corona_tracker/screens/common_components/custom_container.dart';
import 'package:corona_tracker/screens/news.dart';
import 'package:corona_tracker/stores/corona_store.dart';
import 'package:corona_tracker/utils/locator.dart';
import 'package:corona_tracker/utils/screen_ratio.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  CoronaStore coronaStore;
  double wr = ScreenRatio.widthRatio;
  double hr = ScreenRatio.heightRatio;
  bool isExpanded = false;
  @override
  void initState() {
    coronaStore = locator<CoronaStore>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
          child: Stack(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomContainer(
                    text: "Dashboard (INDIA)",
                    width: 200,
                    alignment: Alignment.center,
                  ),
                  isExpanded
                      ? Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.green),
                          child: FlareActor(
                            "assets/animations/heartbeat.flr",
                            animation: "heartbeat",
                          ),
                        )
                      : Container(),
                  Container(
                    margin: EdgeInsets.only(right: 10, top: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.green),
                          child: IconButton(
                              icon: Icon(
                                Icons.note,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                print("Clickrd");
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => News()));
                              }),
                        ),
                        SizedBox(height: 5),
                        Text("Latest News",
                            style: TextStyle(
                                color: Colors.green, letterSpacing: 1))
                      ],
                    ),
                  )
                ],
              ),
              Container(
                height: 600,
                child: ListView.builder(
                  itemCount: coronaStore.indiaData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ExpansionTile(
                      onExpansionChanged: (val) {
                        setState(() {
                          isExpanded = val;
                        });
                      },
                      title: Text(coronaStore.indiaData[index].state),
                      backgroundColor: Colors.grey[200],
                      children: <Widget>[
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
                                    width: 145 * wr,
                                    child: Text(
                                      "Total Confirmed:",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    " ${coronaStore.indiaData[index].confirmed}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
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
                                    width: 145 * wr,
                                    child: Text(
                                      "Total Recoverd:",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    " ${coronaStore.indiaData[index].recovered}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
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
                                    width: 145 * wr,
                                    child: Text(
                                      "Total Deaths:",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    " ${coronaStore.indiaData[index].deaths}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 50),
                                ],
                              ),
                              SizedBox(height: 20)
                            ],
                          ),
                        ),
                        coronaStore.indiaData[index].districtData.length != 0
                            ? Column(
                                children: <Widget>[
                                  CustomContainer(
                                      text: "District Wise", width: 120),
                                  SizedBox(height: 10),
                                  Container(
                                    color: Colors.white,
                                    child: DataTable(
                                      horizontalMargin: 40,
                                      columnSpacing: 15,
                                      dataRowHeight: 30,
                                      headingRowHeight: 35,
                                      columns: [
                                        DataColumn(
                                            label: Text(
                                          'Districts',
                                          style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'Confirmed',
                                          style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'Zone',
                                          style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ],
                                      rows: coronaStore
                                          .indiaData[index].districtData
                                          .map((data) => DataRow(cells: [
                                                DataCell(
                                                  Text(
                                                    "${data.name}",
                                                    style: TextStyle(
                                                        fontFamily: 'Ubuntu'),
                                                  ),
                                                ),
                                                DataCell(
                                                  Text(
                                                    "     ${data.confirmed}",
                                                    style: TextStyle(
                                                        fontFamily: 'Ubuntu'),
                                                  ),
                                                ),
                                                DataCell(
                                                  Text(
                                                    "${data.zone}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Ubuntu',
                                                        color: (data.zone ==
                                                                "RED")
                                                            ? Colors.red
                                                            : (data.zone ==
                                                                    "ORANGE")
                                                                ? Colors.orange
                                                                : (data.zone ==
                                                                        "GREEN")
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .grey),
                                                  ),
                                                ),
                                              ]))
                                          .toList(),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        SizedBox(height: 20)
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
