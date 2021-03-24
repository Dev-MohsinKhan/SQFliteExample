import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final String pass;
  final String fname;
  final String lname;
  final String phone;
  final String address;
  final String gender;
  final String dob;
  final String pic;
  HomeScreen(
    this.fname,
    this.lname,
    this.username,
    this.pass,
    this.phone,
    this.address,
    this.gender,
    this.dob,
    this.pic,
  );
  // HomeScreen({Key key, @required this.user}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Uint8List image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    decriptImage();
  }

  void decriptImage() {
    image = base64Decode(widget.pic);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              Text('First Name : '),
              Text(widget.fname.toString()),
            ],
          ),
          Row(
            children: [
              Text('Last Name : '),
              Text(widget.lname.toString()),
            ],
          ),
          Row(
            children: [
              Text('email : '),
              Text(widget.username.toString()),
            ],
          ),
          Row(
            children: [
              Text('password : '),
              Text(widget.pass.toString()),
            ],
          ),
          Row(
            children: [
              Text('phone : '),
              Text(widget.phone.toString()),
            ],
          ),
          Row(
            children: [
              Text('address : '),
              Text(widget.address.toString()),
            ],
          ),
          Row(
            children: [
              Text('gender : '),
              Text(widget.gender.toString()),
            ],
          ),
          Row(
            children: [
              Text('dob : '),
              Text(widget.dob.toString()),
            ],
          ),
          Row(
            children: [
              Text('pic : '),
              image == null
                  ? Text(widget.pic.toString())
                  : Container(
                      width: 200, height: 200, child: Image.memory(image)),
            ],
          ),
        ],
      )),
    );
  }
}
