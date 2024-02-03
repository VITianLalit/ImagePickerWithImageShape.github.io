import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Image/Icon"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.only(bottom: 10),
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey.shade300,
                 width: 2,
                )
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                    onPressed: (){},
                  child: ElevatedButton(
                    onPressed: (){},
                    child: Text('Choose from Device'),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
