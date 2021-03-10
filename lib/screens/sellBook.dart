import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pay_app/helpers/FirestoreHelper.dart';
import 'package:pay_app/models/Book.dart';
import 'package:pay_app/models/User.dart';
import 'package:pay_app/screens/dashboard.dart';
import 'package:pay_app/widgets/titleText.dart';

class PaymentScreen extends StatefulWidget {
  User user;
  PaymentScreen(this.user);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  User _registeringUser;
  Card card = Card();
  Book book = Book.empty();
  String imagePath;
  String downloadURL;
  String _defaultvalue;
  final List<String> categories = ['Primary', 'Secondary', 'Bachelors'];

  String tempValue = '0';

  // Image Picker
  // List<File> _images = [];
  File _image; // Used only if you need a single picture
  DocumentReference sightingRef =
      Firestore.instance.collection('booksImage').document();

  @override
  void initState() {
    super.initState();
    _registeringUser = widget.user;
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // datetime => age controller
  TextEditingController _bookTitleFieldController;
  TextEditingController _bookCategoryFieldController;
  TextEditingController _bookAmountFieldController;

  // phone number field focus node
  // book title, ani price, ani category, aru chai user ko bata tanna milne.(user email, phone no. location)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDFCFFF),
      appBar: AppBar(
        title: TitleText(
          text: 'Upload Book',
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
         // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
              SizedBox(height: 30),

              RaisedButton(
                onPressed: () {getImage(true);},
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: imagePath == null
                      ? Image.asset(
                          'assets/tap_to_upload.jpg',
                        )
                      : Image.asset(imagePath),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: _bookTitleFieldController,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        onChanged: (String title){
                          book.name = title;
                          print('amount is $title');
                        },
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.black38),
                          hintText: 'Book title',
                          icon: Icon(Icons.book, color: Colors.black87),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: DropdownButton(
                                hint: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(' Please select the categories          ', style: TextStyle( fontWeight: FontWeight.bold, color: Colors.grey)),
                                ), // Not necessary for Option 1
                                value: _defaultvalue,
                                onChanged: (newValue) {
                                  setState(() {
                                    book.category = newValue;
                                    _defaultvalue = newValue;
                                  });
                                },
                                items: categories.map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        //


                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: _bookAmountFieldController,
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        onChanged: (String value) {
                          tempValue = value;
                          book.amount = int.parse(tempValue);
                          print('amount is $tempValue');
                        },
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.black38),
                          hintText: 'Amount',
                          icon: Icon(Icons.attach_money, color: Colors.black87),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.0),
              Container(
                height: 60,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  onPressed: () async {
                    setState(() {
                      /*_registeringUser.balance = _registeringUser.balance +
                          int.parse(tempValue);*/
                    //  print(' getImage function runned successfully');
                    });
                    book.user = _registeringUser.name;
                   // book.name = _bookTitleFieldController.text;
                   // book.category = _bookCategoryFieldController.text;
                   // book.amount = int.parse(_bookAmountFieldController.text) ;
                    book.location = _registeringUser.address;
                    book.contact = _registeringUser.phone;
                    book.uploadDate = DateTime.now();
                   saveImages(_image, sightingRef);
                    print('Redirecting to home');
                  },
                  padding: EdgeInsets.all(2),
                  color: Colors.blue.withOpacity(0.6),
                  child: TitleText(
                    text: 'UPLOAD BOOK NOW',
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                width: MediaQuery.of(context).size.width,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;
    // Let user select photo from gallery
    if (gallery) {
      pickedFile = await picker.getImage(
        source: ImageSource.gallery,
      );
      print('Images picked');
      setState(() {});
      ({});
    }
    // Otherwise open camera to get new photo
    else {
      pickedFile = await picker.getImage(
        source: ImageSource.camera,
      );
    }

    setState(() {
      if (pickedFile != null) {
        imagePath = pickedFile.path;
        _image = File(pickedFile.path);
        print('added to path');
        _image = File(pickedFile.path); // Use if you only need a single picture
      } else {
        print('No image selected.');
      }
    });
  }

  String validatorPhoneField(String value) {
    if (value != null && value.length > 0) {
      if (value.length != 16) {
        return 'Enter 16 digits number';
      } else {
        return null;
      }
    } else {
      return 'CreditCard number couldn\'t be empty';
    }
  }

  Future<String> saveImages(File _image, DocumentReference ref) async {
    String imageURL;
   uploadFile(_image).then((img) {
      imageURL =  img;
    });
    // waitonesecond();
   // });

    debugPrint(' This is your image url $imageURL');
    //ref.update({"images": FieldValue.arrayUnion([imageURL])});
   return imageURL;
  }

  Future<String> uploadFile(File _image) async {
    String returnUrl = '';
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference ref =
        storage.ref().child("bookImage " + DateTime.now().toString());
    StorageUploadTask uploadTask = ref.putFile(_image);
    if (uploadTask.isInProgress == true) {}
    if (await uploadTask.onComplete != null) {
      ref.getDownloadURL().then((fileUrl) async {
        returnUrl = fileUrl;
        print(' ..........$returnUrl');
        FirestoreHelper.createNewBook(_registeringUser, book, returnUrl, () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DashboardScreen(_registeringUser)));
        });
      });
      return returnUrl;
    }
  }

}
