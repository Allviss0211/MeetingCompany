import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:meeting/Home/HomeScreenModel.dart';
import 'package:meeting/Info/InfoScreen.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> listFile = [
    "DeLy",
    "DeToan",
    "Eric_Windmill_Flutter_in_Action",
  ];
  List<String> listDemo = List.generate(10, (index) => "Event thu $index");
  String assetPDFPath = '';
  String urlPDFPath = '';
  PDFDocument document;
  bool _isLoading = false, _isInit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Thông tin cảnh báo",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontFamily: 'Roboto Thin',
              ),
            ),
          ),
          flexibleSpace: null,
        ),
        body: SafeArea(
          top: true,
          bottom: true,
          child: ScopedModel(
            model: HomeScreenModel(),
            child: ScopedModelDescendant<HomeScreenModel>(
                builder: (build, child, model) {
              return ListView.builder(
                  itemCount: listDemo.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      child: GestureDetector(
                        onTap: () async {
                          await loadFromAsset(index < 3 ? listFile[index] : listFile[index % 3]);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  InfoScreen(document: document)));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, bottom: 10),
                                child: Container(
                                  child: Image(
                                    image: AssetImage('image/file.png'),
                                  ),
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(listDemo[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 5, bottom: 10, left: 10),
                                    child: Text('Ngay len su kien'),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }),
          ),
        ));
  }

  void loadFromAsset(String name) async {
    setState(() {
      _isLoading = true;
    });
    document = await PDFDocument.fromAsset("assets/$name.pdf");
    setState(() {
      _isLoading = false;
    });
  }
}
