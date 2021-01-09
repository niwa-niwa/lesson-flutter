import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter layout demo'),
        ),
          // Horizontally
        // body: Center(child: buildRow()),
          // Vertically
        body: Center(child: buildColumn()),
      ),
    );
  }

  // Horizontal
  Widget buildRow() =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset('images/pic1.jpg'),
        Image.asset('images/pic2.jpg'),
        Image.asset('images/pic3.jpg'),
      ],
    );

  // Vertical
  Widget buildColumn() =>
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('aaaaa'),
        Image.asset('images/pic1.jpg'),
        Image.asset('images/pic2.jpg'),
        Image.asset('images/pic3.jpg'),
      ],
    );
}
