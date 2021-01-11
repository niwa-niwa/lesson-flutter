import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: 
        Scaffold(
          appBar:
            PreferredSize(
              preferredSize: Size.fromHeight(0.0),
              child: AppBar(
                  backgroundColor: Colors.black87,
              )
            ),
          drawer:
            Drawer(
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    child: Text("Categories"),
                  ),
                  ListTile(
                    leading:Icon(Icons.restaurant),
                    title: Text('Resturant'),
                  ),
                ],
              ),
            ),
          body:
            WebView(
              initialUrl: 'https://ja.wikipedia.org/wiki/Flutter',
              javascriptMode: JavascriptMode.unrestricted,
            ),
          bottomNavigationBar:
            BottomNavigationBar(
              backgroundColor: Colors.blue[100],
              items:[
                BottomNavigationBarItem(
                  label: 'MENU',
                  icon: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: (){
                    },
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'LIKE',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark),
                  label: 'Bookmark',
                ),
              ],
            ),
        ),
    );
  }
}

