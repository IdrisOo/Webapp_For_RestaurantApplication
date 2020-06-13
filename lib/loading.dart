import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Color(0xFFCC8053),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: SpinKitFoldingCube(
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: Text(
                    'Logging in..',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,
                        fontFamily: 'Varela'),
                  ),
                ),
                SizedBox(height: 20),
              ])),
    );
  }
}
