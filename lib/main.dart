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
      home: MainWebView(),
    );
  }
}


class MainWebView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MainWebViewState();
}

class _MainWebViewState extends State<MainWebView>{

  String homeUrl = 'https://ja.wikipedia.org/wiki/Flutter';
  WebViewController _controller;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _key,
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
                leading:Icon(Icons.home),
                title: Text('Home'),
                onTap: (){
                  _controller.loadUrl(homeUrl);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading:Icon(Icons.restaurant),
                title: Text('Resturants'),
              ),
              ListTile(
                leading:Icon(Icons.museum),
                title: Text('Museums'),
              ),
              ListTile(
                leading:Icon(Icons.business),
                title: Text('Facilities'),
              ),
              ListTile(
                leading:Icon(Icons.train),
                title: Text('Access'),
              ),

            ],
          ),
        ),

      body:
        WebView(
          initialUrl: homeUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController controller){
            _controller = controller;
          },
        ),

      bottomNavigationBar:
        BottomNavigationBar(
          items:[
            BottomNavigationBarItem(
              label: 'MENU',
              icon: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => _key.currentState.openDrawer(),
              ),
            ),
            BottomNavigationBarItem(
              label: 'LIKE',
              icon: IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {},
              ),
            ),
            BottomNavigationBarItem(
              label: 'Bookmark',
              icon: IconButton(
                icon: Icon(Icons.bookmark),
                onPressed: () {},
              ),
            ),
          ],
        ),
    );
  }
}
