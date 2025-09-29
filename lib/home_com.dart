import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeCom extends StatefulWidget {
  const HomeCom({super.key});

  @override
  State<HomeCom> createState() => _HomeComState();
}

class _HomeComState extends State<HomeCom> {
  TextEditingController textController = TextEditingController();
  late String resultText = '';
  var channel = const MethodChannel('flutterKotlin');

  Future<void> callNativeCode(String kotlinFlutterName) async {
    try {
      resultText = await channel.invokeMethod('kotlinFlutterName', {'username': kotlinFlutterName});
      setState(() {});
    } on PlatformException catch (e) {
      print("Failed to Invoke: ${e.message}");

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Kotlin Test"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:const EdgeInsets.all(20),
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  labelText: 'Enter userName'
                ),
              ),
            ),
            ElevatedButton(
              onPressed: (){
                String kotlinFlutterName = textController.text;

                if(kotlinFlutterName.isEmpty){
                  kotlinFlutterName = "From Flutter";
                }
                callNativeCode(kotlinFlutterName);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(20),
              ),
              child: const Text("Go to Kotlin Activity")
            ),
            SizedBox(height: 20),
            Text(resultText, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}