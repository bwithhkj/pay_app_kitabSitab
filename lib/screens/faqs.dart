import 'package:flutter/material.dart';
import 'package:pay_app/models/User.dart';
import 'package:pay_app/widgets/titleText.dart';

import 'dashboard.dart';

class FaqsScreen extends StatefulWidget {

 User user;
  FaqsScreen(this.user);

  @override
  _FaqsScreenState createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
    Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.blue,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: TitleText(
        text:'Some FAQs',
        fontSize: 24,
        color: Colors.blue,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.check,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    const Color(0xFF7699E6),
                    const Color(0xFFDFCFFF),
                  ],
                  begin: const FractionalOffset(0.6, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          child: Column(
            children: [
              _appBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 20,
                            height:10,
                          ),
                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: ListTile(
                              dense: true,
                              leading: Icon(Icons.arrow_forward, color: Colors.white,),
                              title: TitleText(
                                text:'How to update user details?',
                              ),
                              subtitle: TitleText(
                                text: 'To update user details, you need to tap on View/Update. Then just choose the details you want to change ',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Divider(color: Colors.white,),
                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: ListTile(
                              dense: true,
                              leading: Icon(Icons.arrow_forward, color: Colors.white,),
                              title: TitleText(
                                text:'How to sell a book?',
                              ),
                              subtitle: TitleText(
                                text: 'Just tap to sell book option in dashboard. Then, fill the  details and amount to list your book.',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Divider(color: Colors.white,),
                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: ListTile(
                              dense: true,
                              leading: Icon(Icons.arrow_forward, color: Colors.white,),
                              title: TitleText(
                                text:'How to buy a book?',
                              ),
                              subtitle: TitleText(
                                text: 'Tap to the buy book option. Then, you\'ll able to see the books listed. Just contact the seller, meet and buy',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Divider(color: Colors.white,),

                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: ListTile(
                              dense: true,
                              leading: Icon(Icons.arrow_forward, color: Colors.white,),
                              title: TitleText(
                                text:'How to delete User account?',
                              ),
                              subtitle: TitleText(
                                text: 'Tap to the delete user option. Then, you\'ll able to delete the user details for the app',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Divider(color: Colors.white,),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}