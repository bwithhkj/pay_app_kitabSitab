import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pay_app/models/User.dart';
import 'package:pay_app/screens/pdfReader.dart';
import 'package:pay_app/widgets/titleText.dart';

class PDFScreen extends StatefulWidget {
  User user;
  String category;
  PDFScreen(this.user, this.category);
  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: null,
      appBar: AppBar(
        title: Center(
            child: TitleText(
          text: 'AVAILABLE PDFS      ',
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        child: StreamBuilder(
          stream: Firestore.instance.collection('Pdfs').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data.documents.map<Widget>((document) {
                if(document['category'] == widget.category) {
                  return FeatureWidget(
                      document['name'],
                      document['pdfURL'],
                      document['user'],
                          document['category'],
                          () {});
                } else {
                  return SizedBox(height: 0,);
                }
              }).toList(),
            );
          },
        ),
      )),
    );
  }

  Widget FeatureWidget(
      String title,
      String pdfURL,
      String owner,
      String category,
      Function onSelected,
      ) {
    return RaisedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (cxt) => PDFreader(title, pdfURL)));
      },
      child: Container(
        margin: EdgeInsets.all(0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white.withOpacity(0.001),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical:5),
              child: TitleText(text: 'TAP TO READ'),
            ),
            TitleText(
              text: 'Title: $title',
              fontSize: MediaQuery.of(context).size.height * 0.02,
              color: Colors.white,
            ),
            TitleText(
              text: 'Uploader: $owner',
              fontSize: MediaQuery.of(context).size.height * 0.02,
              color: Colors.white,
            ),
            TitleText(
              text: 'Category: $category',
              fontSize: MediaQuery.of(context).size.height * 0.02,
              color: Colors.white,
            ),
            Divider(height: 10,),
          ],
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
