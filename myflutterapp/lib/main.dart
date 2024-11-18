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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MapShapeSource _shapeSource;
  late List<MapModel> _mapData;
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
