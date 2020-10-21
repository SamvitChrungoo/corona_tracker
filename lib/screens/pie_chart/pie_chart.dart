import 'package:corona_tracker/screens/pie_chart/indicator.dart';
import 'package:corona_tracker/utils/screen_ratio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPieChart extends StatefulWidget {
  final double recovered;
  final double deaths;
  final double active;
  // final double value4;
  final String legend1;
  final String legend2;
  final String legend3;
  final Color color;
  // final String legend4;
  CustomPieChart({
    this.legend1,
    this.legend2,
    this.legend3,
    // this.legend4,
    this.recovered,
    this.deaths,
    this.active,
    this.color = Colors.white,
    // this.value4,
  });

  @override
  CustomPieChartState createState() => CustomPieChartState();
}

class CustomPieChartState extends State<CustomPieChart> {
  final double wr = ScreenRatio.widthRatio;
  final double hr = ScreenRatio.heightRatio;
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    print(widget.recovered);
    return Card(
      elevation: (widget.color == Colors.white) ? 0 : 2,
      margin: EdgeInsets.symmetric(horizontal: 12 * wr, vertical: 10 * hr),
      color: widget.color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 190 * wr,
            margin: EdgeInsets.symmetric(horizontal: 10 * wr),
            child: Stack(
              children: <Widget>[
                PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd ||
                              pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 5,
                      centerSpaceRadius: 40,
                      sections: showingSections()),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 1 * wr),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50),
                Indicator(
                  color: Colors.green,
                  text: widget.legend1,
                  size: touchedIndex == 0 ? 16 : 14,
                  textColor: touchedIndex == 0 ? Colors.black : Colors.grey,
                  isSquare: touchedIndex == 0 ? true : false,
                ),
                const SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.red,
                  text: widget.legend2,
                  isSquare: touchedIndex == 1 ? true : false,
                  size: touchedIndex == 1 ? 16 : 14,
                  textColor: touchedIndex == 1 ? Colors.black : Colors.grey,
                ),
                const SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.orange,
                  text: widget.legend3,
                  size: touchedIndex == 2 ? 16 : 14,
                  isSquare: touchedIndex == 2 ? true : false,
                  textColor: touchedIndex == 2 ? Colors.black : Colors.grey,
                ),
                const SizedBox(
                  height: 4,
                ),
                // Indicator(
                //   color: const Color(0xff13d38e),
                //   text: widget.legend4,
                //   size: touchedIndex == 3 ? 16 : 14,
                //   textColor: touchedIndex == 3 ? Colors.black : Colors.grey,
                //   isSquare: touchedIndex == 3 ? true : false,
                // ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    String text1 = (widget.recovered).toStringAsFixed(2).toString();
    String text2 = (widget.deaths).toStringAsFixed(2).toString();
    String text3 = (widget.active).toStringAsFixed(2).toString();
    // String text4 = (widget.value4).toInt().toString();
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 14;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: touchedIndex == 0
                ? Colors.green[600].withOpacity(0.85)
                : Colors.green[400].withOpacity(0.85),
            value: widget.recovered,
            title: "$text1 %",
            titlePositionPercentageOffset: 0.5,
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          );
        case 1:
          return PieChartSectionData(
            color: touchedIndex == 1
                ? Colors.red[600].withOpacity(0.85)
                : Colors.red[400].withOpacity(0.85),
            titlePositionPercentageOffset: 0.5,
            value: widget.deaths,
            title: "$text2 %",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          );
        case 2:
          return PieChartSectionData(
            color: touchedIndex == 2
                ? Colors.orange[600].withOpacity(0.85)
                : Colors.orange[200].withOpacity(0.85),
            value: widget.active,
            title: "$text3 %",
            radius: radius,
            titlePositionPercentageOffset: 0.4,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          );

        default:
          return null;
      }
    });
  }
}
