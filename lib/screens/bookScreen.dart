import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pay_app/models/Book.dart';
import 'package:pay_app/models/User.dart';
import 'package:pay_app/widgets/titleText.dart';

class BookScreen extends StatefulWidget {
  User user;
  BookScreen(this.user);
  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: null,
      appBar: AppBar(
        title: Center(
            child: TitleText(
          text: 'BUY BOOKS      ',
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
          stream: Firestore.instance.collection('Books').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data.documents.map<Widget>((document) {
                return FeatureWidget(
                    document['name'],
                    document['bookURL'],
                    document['Location'],
                    document['user'],
                    document['amount'],
                    document['user'],
                        () {
               /*   Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (cxt) => PaymentScreen(widget.user)));*/
                });
              }).toList(),
            );
          },
        ),
      )),
    );
  }

  Widget FeatureWidget(

      String title,
      String imgURL,
      String location,
      String owner,
      int price,
      String contact,
      Function onSelected,
      ) {
    return RaisedButton(
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
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 1),
              child: Image.network(imgURL, height: 200, ),
            ),
            TitleText(
              text: 'Title: $title',
              fontSize: MediaQuery.of(context).size.height * 0.02,
              color: Colors.white,
            ),
            TitleText(
              text: 'Location: $location',
              fontSize: MediaQuery.of(context).size.height * 0.02,
              color: Colors.white,
            ),
            TitleText(
              text: 'Seller: $owner',
              fontSize: MediaQuery.of(context).size.height * 0.02,
              color: Colors.white,
            ),
            TitleText(
              text: 'Contact: $owner',
              fontSize: MediaQuery.of(context).size.height * 0.02,
              color: Colors.white,
            ),
            TitleText(
              text: 'Price: Rs. $price/-',
              fontSize: MediaQuery.of(context).size.height * 0.02,
              color: Colors.white,
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(12),
      color: Colors.white.withOpacity(0.2),
      onPressed: onSelected,
    );
  }
}
