import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      // delete a debug tag on left top
      debugShowCheckedModeBanner: false,

      // name of this app
      title: 'ToDo App',

      //using theme
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      // display a widget
      home: TodoListPage(),
    );
  }
}


// the widget display todo list
class TodoListPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Text('リスト一覧画面')
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return TodoAddPage();
            }),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoAddPage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: FlatButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: Text('リスト追加画面画面(タップで戻る)'),
        ),
      ),
    );
  }
}
