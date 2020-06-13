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
  String total;

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
                                            itemCount:
                                                snapshot.data.documents.length,
                                            itemBuilder: (context, index) {
                                              DocumentSnapshot
                                                  documentSnapshot = snapshot
                                                      .data.documents[index];

                                              total = documentSnapshot[
                                                  'totalprice'];
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
                                                      documentSnapshot['amount']
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: RaisedButton(
                                              onPressed: () {
                                                x
                                                    .collection('orders')
                                                    .where('tablenumber',
                                                        isEqualTo: tablenum)
                                                    .getDocuments()
                                                    .then((snapshot) {
                                                  for (DocumentSnapshot ds
                                                      in snapshot.documents) {
                                                    ds.reference.delete();
                                                  }
                                                  Navigator.pop(context);
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
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Varela',
                                                    letterSpacing: 1,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              'Total Payment:' +
                                                  total.toString(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'Varela',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
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
