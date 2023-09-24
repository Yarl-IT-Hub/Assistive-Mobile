import 'dart:convert';

import 'package:assistive_app/Subject/subject.dart';
import 'package:assistive_app/_helper/sharedPreference.dart';
import 'package:assistive_app/api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  final formKey = new GlobalKey<FormState>();

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  bool _validate = false;

  // loader
  bool _isLoading = false;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        //     resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Center(
              child: new Form(
                key: formKey,
                //autovalidateMode: AutovalidateMode.always,
                child: new Column(
                  children: <Widget>[
                    SizedBox(height: screenHeight * (2 / 20)),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text(
                          'உள்நுழைக',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: kPrimaryDarkColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * (1.5 / 20)),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            nameInput(),
                            SizedBox(height: screenHeight * (0.5 / 20)),
                            telephoneInput(),
                            SizedBox(height: screenHeight * (4 / 20)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: SvgPicture.asset(
                        "assets/images/arrow.svg",
                      ),
                    ),
                    // SizedBox(height: 60.0),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                      width: screenWidth * 1.0, height: 75),

                  child: ElevatedButton(
                    onPressed: () {
                      onClick();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'உள்நுழைக',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  //   ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget nameInput() {
    RegExp regex = new RegExp("([a-zA-Z',.-]+( [a-zA-Z',.-]+)*){2,30}");
    return TextFormField(
      decoration: InputDecoration(
        hintText: "பெயர்",
        hintStyle: TextStyle(
            fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
        fillColor: Colors.black12,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide.none,
        ),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.length == 0) {
          return 'பெயர் தேவை';
        } else if (!regex.hasMatch(value)) {
          return 'சரியான பெயரை உள்ளிடவும்';
        } else {
          return null;
        }
      },
      controller: _emailController,
    );
  }

  Widget telephoneInput() {
    return TextFormField(
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp("([a-zA-Z',.-]+( [a-zA-Z',.-]+)*){2,30}");
        if (value!.length == 0) {
          return 'அப்பாவின் பெயர் தேவை';
        } else if (!regex.hasMatch(value)) {
          return 'சரியான பெயரை உள்ளிடவும்';
        }
        return null;
      },
      controller: _passwordController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: "அப்பாவின் பெயர்",
        hintStyle: TextStyle(
            fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
        fillColor: Colors.black12,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  onClick() async {
    if (formKey.currentState!.validate()) {
      _handleLogin();
      // scaffoldKey.currentState!.showSnackBar(snackbar);

    } else {
      print("validate error");
      setState(() {
        _validate = true;
      });
    }
  }

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });
    try {
      MySharedPreferences.instance.removeAll();
      var data = {
        "name": _emailController.text,
        "last_name": _passwordController.text,
        "mac": "0.0.0.0",
      };

      var res = await CallApi().postData(data, 'users/register');
      var body = json.decode(res.body);
      MySharedPreferences.instance.setIntValue("userId", body['data']['id']);
      MySharedPreferences.instance
          .setStringValue("userName", body['data']['name']);
      // await MySharedPreferences.instance.getIntValue("userId");
      // await MySharedPreferences.instance.getStringValue("userName");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => SubjectPage()),
      );
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
}
