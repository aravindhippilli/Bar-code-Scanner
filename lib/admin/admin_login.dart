import 'package:flutter/material.dart';
import 'package:idcardscanner/home.dart';
import 'package:idcardscanner/misc/loading.dart';
import 'package:idcardscanner/errors/login_alert.dart';
import 'package:idcardscanner/services/auth.dart';
import 'package:page_transition/page_transition.dart';

class Adminlogin extends StatefulWidget {
  @override
  _AdminloginState createState() => _AdminloginState();
}

class _AdminloginState extends State<Adminlogin> {
  final AuthService _auth = AuthService();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<FormState> formkey1 = GlobalKey<FormState>();

  String email = '', password = '';
  bool isLoad = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return isLoad
        ? Loading()
        : GestureDetector(
            onHorizontalDragUpdate: (details) {
              int sensitivity = 8;
              if (details.delta.dx > sensitivity) {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRightJoined,
                        childCurrent: Adminlogin(),
                        duration: Duration(milliseconds: 700),
                        reverseDuration: Duration(milliseconds: 700),
                        child: Homepage()));
              }
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Color(0xff34456e),
                elevation: 0,
                centerTitle: true,
                title: Text("ID card Scanner"),
              ),
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/BG.png"), fit: BoxFit.cover),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "ADMIN",
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "LOGIN",
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 5),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Column(
                        children: <Widget>[
                          Theme(
                            child: Form(
                              key: formkey,
                              child: TextFormField(
                                validator: (String name) {
                                  if (name.isEmpty) {
                                    return "Required *";
                                  } else {
                                    email = name;
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  labelText: "Email ID",
                                  labelStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade400),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(0xff34456e),
                                      )),
                                ),
                              ),
                            ),
                            data: Theme.of(context)
                                .copyWith(primaryColor: Color(0xff34456e)),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Theme(
                            child: Form(
                              key: formkey1,
                              child: TextFormField(
                                obscureText: _obscureText,
                                validator: (String name) {
                                  if (name.isEmpty) {
                                    return "Required *";
                                  } else {
                                    password = name;
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade400),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(0xff34456e),
                                      )),
                                  suffixIcon: new GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: new Icon(_obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                ),
                              ),
                            ),
                            data: Theme.of(context)
                                .copyWith(primaryColor: Color(0xff34456e)),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () async {
                                if (formkey.currentState.validate() &&
                                    formkey1.currentState.validate()) {
                                  setState(() {
                                    isLoad = true;
                                  });
                                  dynamic result =
                                      await _auth.signIn(email, password, true);
                                  if (result == null) {
                                    setState(() {
                                      isLoad = false;
                                    });
                                    await AlertDialogs.okDialog(
                                        context,
                                        'Incorrect Details',
                                        'Enter valid Details');
                                  } else {
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xff6673b4),
                                      Color(0xff5867a2),
                                      Color(0xff3f507f),
                                      Color(0xff34456e)
                                    ],
                                  ),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  constraints: BoxConstraints(
                                      maxWidth: double.infinity, minHeight: 50),
                                  child: Text(
                                    "LOGIN",
                                    style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton.extended(
                  icon: Icon(Icons.arrow_left),
                  label: Text("Security"),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.leftToRightJoined,
                            childCurrent: Adminlogin(),
                            duration: Duration(milliseconds: 700),
                            reverseDuration: Duration(milliseconds: 700),
                            child: Homepage()));
                  }),
            ),
          );
  }
}
