import 'package:flutter/material.dart';
import 'package:pay_app/models/User.dart';
import 'package:pay_app/screens/buyScreen.dart';
import 'package:pay_app/screens/pdfReader.dart';
import 'package:pay_app/screens/pdfscreen.dart';
import 'package:pay_app/widgets/titleText.dart';

class PDFcategory extends StatefulWidget {
  User user;
  List<String> categoryLists;
  bool book;
  PDFcategory(this.user, this.categoryLists, this.book);
  @override
  _PDFcategoryState createState() => _PDFcategoryState();
}

class _PDFcategoryState extends State<PDFcategory> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: null,
      appBar: AppBar(
        title: Center(
            child: TitleText(
              text: 'CHOOSE CATEGORY      ',
              fontSize: 30,
              color: Colors.blue,
            )),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFFDDE1EC),
                  const Color(0xFFE0EBEE),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
      ),
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    const Color(0xFF5681DF),
                    const Color(0xFFDFCFFF),
                  ],
                  begin: const FractionalOffset(0.6, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,

            child: ListView.builder
              (
                itemCount: widget.categoryLists.length,
                itemBuilder: (BuildContext context, int index) {
                  return FeatureWidget(widget.categoryLists[index]);
                }
            ),
          )),
    );
  }
    Widget FeatureWidget(
        String title,
        ) {
      return RaisedButton(
        onPressed: () {
          if(widget.book) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (cxt) => PDFScreen(widget.user, title)));} else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (cxt) => BookScreen(widget.user, title)));

          }
        },
        child: Container(
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white.withOpacity(0.001),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TitleText(
                  text: ' $title',
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(12),
        color: Colors.white.withOpacity(0.2),
        //onPressed: onSelected,
      );
    }
  }