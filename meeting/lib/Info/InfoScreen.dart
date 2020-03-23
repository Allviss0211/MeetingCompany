import 'dart:math';

import 'package:number_display/number_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';


final display = createDisplay(decimal: 2);

class InfoScreen extends StatefulWidget {
  final PDFDocument document;
  InfoScreen({Key key, this.document}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("file PDF"),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: Container(
                    height: 100,
                    child: Center(
                      child: PDFViewer(document: widget.document),
                    )))
          ],
        ));
  }
}

class InfoWebViewScreen extends StatefulWidget {
  String url;

  InfoWebViewScreen({Key key, this.url}) : super(key: key);
  @override
  _InfoWebViewScreenState createState() => _InfoWebViewScreenState();
}

class _InfoWebViewScreenState extends State<InfoWebViewScreen> {
  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        key: _key,
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: widget.url,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: ZoomableWidget(
                  child: SfCircularChart(
                    borderColor: Colors.black,
                    title: ChartTitle(text: "Pie Chart", textStyle: ChartTextStyle(fontSize: 20)),
            legend: Legend(isVisible: true,textStyle: ChartTextStyle(fontSize: 17),position: LegendPosition.bottom, itemPadding: 20),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CircularSeries<SalesData, String>>[
              DoughnutSeries<SalesData, String>(explode: true,
              explodeIndex: 0,
              explodeOffset: '13%',
              dataSource: <SalesData>[
                        SalesData('Jan', 35),
                        SalesData('Feb', 28),
                        SalesData('Mar', 34),
                        SalesData('Apr', 32),
                        SalesData('May', 40)
                      ],
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales,
              dataLabelSettings: DataLabelSettings(isVisible: true,textStyle: ChartTextStyle(fontSize: 17),),
              )
            ],
          ),
        ));
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class ZoomableWidget extends StatefulWidget {
  final Widget child;

  const ZoomableWidget({Key key, this.child}) : super(key: key);
  @override
  _ZoomableWidgetState createState() => _ZoomableWidgetState();
}

class _ZoomableWidgetState extends State<ZoomableWidget> {
  Matrix4 matrix = Matrix4.identity();

  @override
  Widget build(BuildContext context) {
    return MatrixGestureDetector(
      onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm) {
        setState(() {
          // print(m);
          print(tm);
          // print(sm);
          // print(rm);
          matrix = m;
        });
      },
      child: Transform(
        transform: matrix,
        child: widget.child,
      ),
    );
  }
}