import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrdersPage();
  }
}

class _OrdersPage extends State<OrdersPage> {
  var x = Firestore.instance;
  var y = Firestore.instance;
  var z = Firestore.instance;

  String total = "Click to show price.";

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildCard('1'),
            _buildCard('2'),
            _buildCard('3'),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildCard('4'),
            _buildCard('5'),
            _buildCard('6'),
          ],
        )
      ],
    ));
  }

  _buildCard(tablenum) {
    return Container(
        height: 200,
        width: 300,
        child: Card(
          child: StreamBuilder(
            stream: Firestore.instance
                .collection('orders')
                .where('tablenumber', isEqualTo: tablenum)
                .snapshots(),
            initialData: Container(
              child: Text('Loading...'),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data.documents.length == 0 ||
                    snapshot.data.documents.length == null) {
                  return Container(
                      child: Center(
                    child: Text(
                      ' Table ' + tablenum,
                      style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ));
                } else if (snapshot.data.documents.length > 0) {
                  return GestureDetector(
                      onTap: () {
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return AlertDialog(
                                  title: Column(
                                    children: [
                                      Center(
                                        child: Text(
                                          'Table ' + tablenum,
                                          style: TextStyle(
                                              fontFamily: 'Varela',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Card(
                                        child: Container(
                                          width: 500,
                                          height: 450,
                                          child: ListView.builder(
                                              itemCount: snapshot
                                                  .data.documents.length,
                                              itemBuilder: (context, index) {
                                                DocumentSnapshot
                                                    documentSnapshot = snapshot
                                                        .data.documents[index];
                                                // Cahnge this here later

                                                return ListTile(
                                                  title: Text(
                                                    documentSnapshot['name'],
                                                    style: TextStyle(
                                                        fontFamily: 'Varela',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                  subtitle: Text(
                                                    'Amount: ' +
                                                        documentSnapshot[
                                                                'amount']
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontFamily: 'Varela',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  trailing: Text(
                                                    documentSnapshot['price'],
                                                    style: TextStyle(
                                                        fontFamily: 'Varela',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: RaisedButton(
                                                onPressed: () {
                                                  return showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              Color(0xFFC88067),
                                                          content: Text(
                                                            'Are you sure you want to delete the items \n it will also render items as finished!',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    'Varela',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          actions: [
                                                            FlatButton(
                                                              child: Text(
                                                                  "Delete",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Varela',
                                                                      fontSize:
                                                                          30,
                                                                      color: Colors
                                                                          .white)),
                                                              onPressed: () {
                                                                x
                                                                    .collection(
                                                                        'orders')
                                                                    .where(
                                                                        'tablenumber',
                                                                        isEqualTo:
                                                                            tablenum)
                                                                    .getDocuments()
                                                                    .then(
                                                                        (snapshot) {
                                                                  for (DocumentSnapshot ds
                                                                      in snapshot
                                                                          .documents) {
                                                                    ds.reference
                                                                        .delete();

                                                                    y
                                                                        .collection(
                                                                            'waiting')
                                                                        .where(
                                                                            'tablenumber',
                                                                            isEqualTo:
                                                                                tablenum)
                                                                        .getDocuments()
                                                                        .then(
                                                                            (snapshot) {
                                                                      for (DocumentSnapshot ds
                                                                          in snapshot
                                                                              .documents) {
                                                                        ds.reference
                                                                            .delete();
                                                                      }
                                                                    });

                                                                    z
                                                                        .collection(
                                                                            'orders')
                                                                        .document(
                                                                            tablenum)
                                                                        .delete();
                                                                  }
                                                                  Navigator.pop(
                                                                      context);
                                                                  Navigator.pop(
                                                                      context);
                                                                });
                                                              },
                                                            ),
                                                            FlatButton(
                                                              child: Text(
                                                                "Cancel",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Varela',
                                                                    fontSize:
                                                                        30,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                },
                                                color: Colors.redAccent,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Varela',
                                                      letterSpacing: 1,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            Container(
                                              child: RaisedButton(
                                                onPressed: () {
                                                  y
                                                      .collection('waiting')
                                                      .where('tablenumber',
                                                          isEqualTo: tablenum)
                                                      .getDocuments()
                                                      .then((snapshot) {
                                                    for (DocumentSnapshot ds
                                                        in snapshot.documents) {
                                                      ds.reference.delete();
                                                    }
                                                  });
                                                },
                                                color: Colors.greenAccent,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(
                                                  'Finished',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Varela',
                                                      letterSpacing: 1,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 50),
                                            RaisedButton(
                                              color: Color(0xFFC88067),
                                              onPressed: () async {
                                                String price;
                                                await Firestore.instance
                                                    .collection('orders')
                                                    .document(tablenum)
                                                    .get()
                                                    .then((value) => price =
                                                        'TotalPrice: ' +
                                                            value.data[
                                                                'totalprice']);
                                                setState(() {
                                                  total = price;
                                                });
                                                return showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        backgroundColor:
                                                            Color(0xFFC88067),
                                                        content: Text(
                                                          "The Total is: " +
                                                              total,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Varela',
                                                              fontSize: 50),
                                                        ),
                                                      );
                                                    });
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Text(
                                                'Click to show price.',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'Varela',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                            });
                      },
                      child: Container(
                          color: Colors.redAccent,
                          child: Center(
                            child: Text(
                              'Table ' + tablenum,
                              style: TextStyle(
                                  fontFamily: 'Varela',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )));
                }
                return Container(
                  child: Text('nothing'),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  color: Colors.yellowAccent[100],
                  child: Center(
                      child: Text(
                    'Loading..',
                    style: TextStyle(
                        color: Color(0xFFC88067),
                        fontFamily: 'Varela',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
                );
              } else
                return Container(
                  child: Text('nothing'),
                );
            },
          ),
        ));
  }
}
