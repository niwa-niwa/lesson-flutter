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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      // display a widget
      home: TodoListPage(),
    );
  }
}


// the widget display todo list
class TodoListPage extends StatefulWidget{
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

// the state is for TodoListPage
class _TodoListPageState extends State<TodoListPage>{

  // variable that manage state
  final List<String> todoList = [];

  @override
  Widget build(BuildContext context){
    return Scaffold(

      // title of this page
      appBar: AppBar(
        title: Text('Todo List')
      ),

      // main display
      body: ListView.builder(

        // pass number of item to itemBuilder
        itemCount: todoList.length,

        //like for statement
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              title: Text(todoList[index]),
            )
          );
        },
      ),

      // made a float button
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // move to TodoAddPage and waiting a variable new task
          final newListText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return TodoAddPage();
            }),
          );
          // sets state of todolist. 
          //if pressed the cancel button in TodoAddPage the page returned null
          if (newListText != null){
            setState((){
              todoList.add(newListText);
            });
          }
        },
        child: Icon(Icons.add),
      ),

    );
  }
}


// the widget display add todo
class TodoAddPage extends StatefulWidget{
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {

  // the variable state
  String _text = '';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Add Todo'),
      ),

      body: Container(

        padding: EdgeInsets.all(64),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_text, style: TextStyle(color: Colors.blue)),
            TextField(
              onChanged: (String value){
                setState((){
                  _text = value;
                });
              },
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blue,
                onPressed: (){
                  Navigator.of(context).pop(_text);
                },
                child: Text('Add list', style:TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              width: double.infinity,
              child: FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text('Cancel')
              ),
            ),
          ],
        )

      )
    );
  }
}