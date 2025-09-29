import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BatteryLevel extends StatefulWidget{
  const BatteryLevel({super.key});

  @override
  State<BatteryLevel> createState() => _BatteryLevelState();
}

class _BatteryLevelState extends State<BatteryLevel>{
  static const program = MethodChannel('Battery_service');

  late String _batteryLevel = 'Battery level Unknown.';

  Future<void> _getBatteryLevel() async{
    String batteryLevel;

    try{
      final result = await program.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery Level is at $result %';

    } on PlatformException catch (e){
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    setState((){
      _batteryLevel = batteryLevel;
    });

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Battery Level"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: (){
              setState(() {
                _batteryLevel = 'Battery level Unknown.';
              });
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ElevatedButton(
            onPressed: () => _getBatteryLevel(),
            style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.all(20),
            ),
            child: Text('Get battery level'),
          ),
            SizedBox(height: 20),
          Text(_batteryLevel, 
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
          ]
        ),
      ),
    );
  }
}