import 'package:flutter/material.dart';

class CityDetailPage extends StatefulWidget {
  const CityDetailPage({super.key});

  @override
  State<CityDetailPage> createState() => _CityDetailPageState();
}

class _CityDetailPageState extends State<CityDetailPage> {
  @override
  void initState() {
    super.initState();
    print("yeni sayfa");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "yeni sayfa",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
