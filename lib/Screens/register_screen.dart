import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/Database/database_helper.dart';
import 'package:task/Models/user_model.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email, pass, fname, lname, address, gender, pic, phone;
  File image;
  String base64;
  final picker = ImagePicker();
  DateTime dob;
  String dobString;
  void showMessage(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      title: 'Error',
      desc: message,
      btnOkColor: Colors.green[300],
      buttonsTextStyle: TextStyle(color: Colors.white),
      // showCloseIcon: true,
      // btnCancelOnPress: () {},
      btnOkOnPress: () {},
    )..show();
  }

  void showMessageTrue(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      title: 'Success',
      desc: message,
      btnOkColor: Colors.green[300],
      buttonsTextStyle: TextStyle(color: Colors.white),
      // showCloseIcon: true,
      // btnCancelOnPress: () {},
      btnOkOnPress: () {
        Navigator.pop(context);
      },
    )..show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                8.0,
                18.0,
                8.0,
                8.0,
              ),
              child: Text(
                'Registeration',
                style: TextStyle(fontSize: 25, color: Colors.green),
              ),
            ),
            InkWell(
              onTap: () async {
                final pickedFile =
                    await picker.getImage(source: ImageSource.gallery);

                // setState(() {
                if (pickedFile != null) {
                  image = File(pickedFile.path);

                  final bytes = image.readAsBytesSync();
                  base64 = base64Encode(bytes);
                  print(base64);
                  // base64 = base64Encode(); //BASE64.encode(image);
                } else {
                  print('No image selected.');
                }
                setState(() {});
              },
              child: Center(
                child: image == null
                    ? Container(
                        child: Icon(Icons.image),
                      )
                    : Container(
                        width: 200,
                        height: 200,
                        child: Image.file(image),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val) {
                  email = val;
                  print(email);
                },
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val) {
                  pass = val;
                  print(pass);
                },
                decoration: InputDecoration(
                  labelText: "Password",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val) {
                  fname = val;
                  print(fname);
                },
                decoration: InputDecoration(
                  labelText: "First Name",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val) {
                  lname = val;
                  print(lname);
                },
                decoration: InputDecoration(
                  labelText: "Last Name",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val) {
                  phone = val;
                  print(phone);
                },
                decoration: InputDecoration(
                  labelText: "Phone",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val) {
                  address = val;
                  print(address);
                },
                decoration: InputDecoration(
                  labelText: "address",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    setState(() {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1018, 3, 5),
                          maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {
                        setState(() {
                          dob = date;
                          dobString = dob.year.toString() +
                              '-' +
                              dob.month.toString() +
                              '-' +
                              dob.day.toString();
                          print('confirm $dob');
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                    });
                  },
                  child: Text(dob == null ? 'DOB' : dobString.toString())),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val) {
                  gender = val;
                  print(gender);
                },
                decoration: InputDecoration(
                  labelText: "Gender",
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: InkWell(
                  onTap: () async {
                    if (fname != null &&
                        lname != null &&
                        email != null &&
                        pass != null &&
                        phone != null &&
                        address != null &&
                        gender != null &&
                        dobString != null &&
                        base64 != null) {
                      var user = new Person(
                        fname,
                        lname,
                        email,
                        pass,
                        phone,
                        address,
                        gender,
                        dobString,
                        base64,
                      );
                      var db = new DatabaseHelper();
                      var t = await db.saveUser(user);
                      if (t != null) {
                        print("registered");
                        showMessageTrue('Registered');
                      } else {
                        print('error');
                        showMessage('Email Already registered');
                      }
                    } else {
                      showMessage('Fields cannot be empty');
                    }
                  },
                  child: Chip(
                      elevation: 2,
                      shadowColor: Colors.amber,
                      backgroundColor: Colors.green[300],
                      label: Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ))),
            ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Divider(
                thickness: 1,
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            Center(
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text("Login")),
            ),
          ],
        ),
      )),
    );
  }
}
