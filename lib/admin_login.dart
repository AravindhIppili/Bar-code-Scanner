import 'package:flutter/material.dart';
import 'package:idcardscanner/loading.dart';
import 'package:idcardscanner/login_alert.dart';
import 'package:idcardscanner/auth.dart';
import 'package:idcardscanner/checkAdmin.dart';

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
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              centerTitle: true,
              title: Text("ID card Scanner"),
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xfd3cce3), Color(0xfE9E4F0)],
                ),
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
                                    fontSize: 16, color: Colors.grey.shade400),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    )),
                              ),
                            ),
                          ),
                          data: Theme.of(context)
                              .copyWith(primaryColor: Color(0xffff5f6d)),
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
                                    fontSize: 16, color: Colors.grey.shade400),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.red,
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
                              .copyWith(primaryColor: Color(0xffff5f6d)),
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
                                    await _auth.signIn(email, password);

                                if ((result != null) &&
                                    CheckAdmin().isAdmin(result)) {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => Secsuccess()));

                                  Navigator.pop(context);
                                } else {
                                  // Navigator.push(
                                  //   context,
                                  // MaterialPageRoute(
                                  //   builder: (context) => Error()));

                                  setState(() {
                                    isLoad = false;
                                  });
                                  await AlertDialogs.okDialog(
                                      context,
                                      'Incorrect Details',
                                      'Enter valid Details');
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
                                    Color(0xffff5f6d),
                                    Color(0xffff5f6d),
                                    Color(0xffffc371),
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
          );
  }
}
