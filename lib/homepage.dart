import 'package:flutter/material.dart';
import 'orderpage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                'Fast Food',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 43.0,
                    color: Color(0xFFC88067)),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        body: Column(children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Color(0xFFC88067),
              isScrollable: true,
              labelPadding: EdgeInsets.symmetric(horizontal: 250.0),
              unselectedLabelColor: Color(0xFFCDCDCD),
              tabs: <Widget>[
                Tab(
                  child: Text(
                    'Orders',
                    style: TextStyle(fontFamily: 'Varela', fontSize: 37.0),
                  ),
                ),
              ]),
          Container(
            height: 500,
            width: double.infinity,
            child: TabBarView(controller: _tabController, children: [
              OrdersPage(),
            ]),
          )
        ]));
  }
}
