import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:task/Database/database_helper.dart';
import 'package:task/Models/user_model.dart';
import 'package:task/Screens/home_screen.dart';
import 'package:task/Screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email, pass = '';
  // DatabaseHelper db;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  8.0,
                  18.0,
                  8.0,
                  8.0,
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 25, color: Colors.green),
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
              SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                    onTap: () async {
                      var dbv = new DatabaseHelper();
                      var ss = await dbv.selectUser(email);
                      if (ss != null) {
                        Map news = Map<String, dynamic>.from(ss);
                        print(news['fname']);

                        print('inside UI');
                        if (pass == news['password']) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                  news['fname'],
                                  news['lname'],
                                  news['username'],
                                  news['password'],
                                  news['phone'],
                                  news['address'],
                                  news['gender'],
                                  news['dob'],
                                  news['picture'],
                                ),
                              ));
                        } else {
                          print('incorrect pass');
                          showMessage('incorrect pass');
                        }
                      } else {
                        print('Nothing found');
                        showMessage('No Record Found');
                      }
                    },
                    child: Chip(
                        elevation: 2,
                        shadowColor: Colors.amber,
                        backgroundColor: Colors.green[300],
                        label: Text(
                          "Login",
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text("Register")),
              ),
              // RaisedButton(
              //   onPressed: () {

              //   },
              //   child: Text("Register"),
              // ),
            ],
          ),
        ),
      )),
    );
  }
}
