import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'My app',
    home: SafeArea(
      child: MyScaffold(),
    ),
  ));
}


class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Material(
      child: Column(
        children: <Widget>[
          MyAppBar(
            title: Text(
              'Example title',
              style: Theme.of(context).primaryTextTheme.headline6,
            ),
          ),
          Expanded(
            child: Center(
              child: Text('HelloHello, world'),
            ),
          ),
          Counter(),
          MyButton(),

        ],
      ),
    );
  }
}


class MyAppBar extends StatelessWidget{
  MyAppBar({this.title});

  final Widget title;

  @override
  Widget build(BuildContext context){
    return Container(
      height:56.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      child: Row(
        children:<Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            tooltip:  'Navigation menu',
            onPressed: null,
          ),

          Expanded(
            child: title,
          ),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}


class MyButton extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () {
        print('MyButton was Tapped!');
      },
      child: Container(
        height: 36.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal:8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightGreen[500],
        ),
        child: Center(
          child: Text('Engage'),
        ),
      ),
    );
  }
}


class Counter extends StatefulWidget{
  @override
  _CounterState createState() => _CounterState();
}


class _CounterState extends State<Counter>{
  int _counter = 0;

  void _increment(){
    setState((){
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context){
    return Row(
      children: <Widget>[
        ElevatedButton(
          onPressed: _increment,
          child: Text('Increment'),
        ),
        Text('Count: $_counter'),
      ],
    );
  }
}
