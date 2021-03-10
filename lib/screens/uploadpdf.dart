
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pay_app/helpers/FirestoreHelper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pay_app/models/PDF.dart';
import 'package:pay_app/models/User.dart';
import 'package:pay_app/screens/dashboard.dart';
import 'package:pay_app/widgets/titleText.dart';

class UploadPDF extends StatefulWidget {
  User user;
  UploadPDF(this.user);

  @override
  _UploadPDFState createState() => _UploadPDFState();
}

class _UploadPDFState extends State<UploadPDF> {
  User _registeringUser;
  
  PDFs pdf = PDFs.empty();
  String imagePath;
  String downloadURL;
  String _defaultvalue;
  
  String fileName;
  final List<String> categories = ['COURSE', 'STORY', 'NOVEL','BIOGRAPHY'];
  String tempValue = '0';

  // Image Picker
  // List<File> _images = [];
  File _file; // Used only if you need a single picture
  DocumentReference sightingRef =
      Firestore.instance.collection('pdfs').document();
  @override
  void initState() {
    super.initState();
    _registeringUser = widget.user;
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // datetime => age controller
  TextEditingController _bookTitleFieldController;
  TextEditingController _bookCategoryFieldController;

  // phone number field focus node
  // book title, ani price, ani category, aru chai user ko bata tanna milne.(user email, phone no. location)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDFCFFF),
      appBar: AppBar(
        title: TitleText(
          text: 'Upload PDF',
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TitleText(
                    text: 'Upload PDF HERE',
                    fontSize: 22,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () { getPdfAndUpload();},
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: imagePath == null
                      ? Image.asset(
                          'assets/tap_to_upload.jpg',
                        )
                      : TitleText(text: 'PDF SELECTED\n NOW,\N FILL IN THE \N DETAILS ', color: Colors.white,),
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
                          pdf.name = title;
                          print('amount is $title');
                        },
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.black38),
                          hintText: 'PDF title',
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
                                  child: Text(' Please select the categories      ', style: TextStyle( fontWeight: FontWeight.bold, color: Colors.grey)),
                                ), // Not necessary for Option 1
                                value: _defaultvalue,
                                onChanged: (newValue) {
                                  setState(() {
                                    pdf.category = newValue;
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
                      ],
                    ),
                    SizedBox(height: 20),
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
                    pdf.user = _registeringUser.name;
                    pdf.uploadDate = DateTime.now();
                    savePdf(_file.readAsBytesSync(), fileName);
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

  Future getPdfAndUpload() async{

 FilePickerResult fileresult = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
 if(fileresult != null) {
 _file = File(fileresult.files.first.path);
}
fileName = 'PFD' + DateTime.now().toString();
  print(fileName);
  print('${_file.readAsBytesSync()}');

}

Future savePdf(List<int> asset, String name) async {
 setState(() {
    CircularProgressIndicator();
 });
 
  StorageReference reference = FirebaseStorage.instance.ref().child(name);
  StorageUploadTask uploadTask = reference.putData(asset);
  String url = await (await uploadTask.onComplete).ref.getDownloadURL();
  print(url);
  pdf.pdfURL = url;

  FirestoreHelper.createNewPDF(_registeringUser, pdf, () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DashboardScreen(_registeringUser)));
        });
  return  url;
}

  }