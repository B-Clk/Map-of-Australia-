import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:myflutterapp/CityDetailPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MapShapeSource _shapeSource;
  late List<MapModel> _mapData;
  int _index = 8;
  bool isPressed = false;
  @override
  void initState() {
    _mapData = _getMapData();
    _shapeSource = MapShapeSource.asset(
      'assets/australia.json',
      shapeDataField:
          'STATE_NAME', // burda properities kısmındaki ile aynı olmasına dikkat et.
      dataCount: _mapData.length,
      primaryValueMapper: (int index) => _mapData[index].state,
      dataLabelMapper: (int index) => _mapData[index].stateCode,
      shapeColorValueMapper: (int index) => _mapData[index].color,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Text(
              'Australia Map',
              style: TextStyle(color: Colors.black87, fontSize: 20),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 50, 0, 0),
              child: SfMaps(
                layers: [
                  /*
                  MapTileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          //alttaki kodları dünya haritasında belli bir bölgeye zoomlanmasını sağlıyor
                          initialFocalLatLng: MapLatLng(-20,147),
                          initialZoomLevel: 3,
                          )
                          */
                  MapShapeLayer(
                    source: _shapeSource,
                    showDataLabels: true,
                    legend: MapLegend(MapElement
                        .shape), //this shows the label color for each one.
                    shapeTooltipBuilder: (BuildContext context, int index) {
                      setState(() {
                        _index = index;
                        isPressed = true;
                      });
                      return Padding(
                        padding: EdgeInsets.all(7),
                        child: Text(
                          _mapData[index].stateCode,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                    tooltipSettings:
                        MapTooltipSettings(color: Colors.blue.shade900),
                    // strokeColor: Colors.black, // bu şehirler arasındaki çizgi rengini belirliyor.
                  )
                ],
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: isPressed
                  ? ElevatedButton(
                      child: Text(_mapData[_index].stateCode),
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CityDetailPage()));
                        });
                      },
                    )
                  : Text("Şehir seçmek için tıklayın!"))
        ],
      ),
    );
  }

  static List<MapModel> _getMapData() {
    return <MapModel>[
      MapModel('Australian Capital Territory', 'ACT', Colors.amber),
      MapModel('New South Wales', 'New\n South Wales', Colors.cyan),
      MapModel('Queensland', 'Queensland', Colors.amber.shade400),
      MapModel(
          'Northern Territory', 'Northern\n Territory', Colors.red.shade400),
      MapModel('Victoria', 'Victoria', Colors.purple.shade400),
      MapModel('South Australia', 'South Australia',
          Colors.lightGreenAccent.shade200),
      MapModel(
          'Western Australia', 'Western Australia', Colors.indigo.shade400),
      MapModel('Tasmania', 'Tasmania', Colors.lightBlue.shade100),
    ];
  }
}

class MapModel {
  MapModel(this.state, this.stateCode, this.color);
  String state;
  String stateCode;
  Color color;
}
