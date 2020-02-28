import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lets_travel/widgets/city_card.dart';
import 'package:lets_travel/widgets/content_title.dart';

import 'constant/values.dart';
import 'model/city_model.dart';
import 'model/icon_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage())));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset('assets/images/boeing.png'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: AppBar().preferredSize.height * 1.5),
              Text('What you would like to find??', style: headerStyle),
              SizedBox(height: 32),
              buildIconRow(),
              ContentTitle('Top Destinations'),
              buildCityList(),
              ContentTitle('Exclusive Hotels'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomAppBar(),
    );
  }

  BottomAppBar buildBottomAppBar() {
    return BottomAppBar(
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('Search')),
          BottomNavigationBarItem(icon: Icon(Icons.flight), title: Text('Flight')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Profile')),
        ],
      ),
    );
  }

  Widget buildIconRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List<Widget>.generate(
        icons.length,
        (int index) {
          return ChoiceChip(
            label: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icons[index].icon,
                color: _value == index ? Colors.red : Colors.black,
              ),
            ),
            selected: _value == index,
            onSelected: (bool selected) {
              setState(() {
                _value = selected ? index : null;
              });
            },
          );
        },
      ).toList(),
    );
  }

  Widget buildCityList() {
    return Container(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: cities.length,
        itemBuilder: (BuildContext context, int index) {
          return CityCard(cities[index]);
        },
      ),
    );
  }
}
