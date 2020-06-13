import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:firebase/firebase.dart' as fb;
import 'loading.dart';
import 'auth.dart';

void main() {
  runApp(MyApp());
  if (fb.apps.isEmpty) {
    fb.initializeApp(
        apiKey: "AIzaSyCKxA2ViOcQnD2n1h5A-VoAiX2a8jcsY2Q",
        authDomain: "restaurant-5dc6b.firebaseapp.com",
        databaseURL: "https://restaurant-5dc6b.firebaseio.com",
        projectId: "restaurant-5dc6b",
        storageBucket: "restaurant-5dc6b.appspot.com");
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestaurantWebApp',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  final AuthService _auth = AuthService();
  String email = '';
  String pass = '';
  String error = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 100,
                          fontFamily: 'Pacifico',
                          color: Color(0xFFCC8053)),
                    ),
                    Form(
                      key: _formKey,
                      child: Expanded(
                        child: Container(
                          child: Padding(
                              padding: EdgeInsets.all(60),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            Colors.grey[200]))),
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              decoration: InputDecoration(
                                                  labelText: 'Email',
                                                  labelStyle: TextStyle(
                                                      color: Color(0xFFCC8053),
                                                      fontFamily: 'Varela',
                                                      fontSize: 30)),
                                              onSaved: (val) {
                                                email = val;
                                              },
                                              onChanged: (val) {
                                                setState(() {
                                                  email = val;
                                                });
                                              },
                                              validator: (val) => val.isEmpty
                                                  ? 'Enter an email'
                                                  : null,
                                              style: TextStyle(
                                                color: Color(0xFF575E67),
                                                fontFamily: 'Varela',
                                                fontSize: 30,
                                              ),
                                            )),
                                        Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            Colors.grey[200]))),
                                            child: TextFormField(
                                              validator: (val) => val.isEmpty
                                                  ? 'Enter the password'
                                                  : null,
                                              style: TextStyle(
                                                color: Color(0xFF575E67),
                                                fontFamily: 'Varela',
                                                fontSize: 30,
                                              ),
                                              onChanged: (val) {
                                                setState(() {
                                                  pass = val;
                                                });
                                              },
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                  labelText: 'Password',
                                                  labelStyle: TextStyle(
                                                      color: Color(0xFFCC8053),
                                                      fontFamily: 'Varela',
                                                      fontSize: 30),
                                                  border: InputBorder.none),
                                            )),
                                        Container(
                                          color: Colors.blue,
                                        ),
                                        SizedBox(height: 20),
                                        GestureDetector(
                                            onTap: () async {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                setState(() => loading = true);
                                                dynamic result = await _auth
                                                    .signInWithEmailAndPassword(
                                                        email.trim(),
                                                        pass.trim());
                                                if (result == null) {
                                                  setState(() {
                                                    error = 'Could not signin';
                                                    loading = false;
                                                  });
                                                } else {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomePage()));
                                                }
                                              }
                                            },
                                            child: Container(
                                                width: 200,
                                                height: 44,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 50),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Color(0xFFF17532)),
                                                child: Center(
                                                    child: Text(
                                                  "Login",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Varela',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ))))
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
