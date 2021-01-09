import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build (BuildContext context){
    
    return MaterialApp(
      title: 'startup Name Generator',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: RandomWords(),
    );
  }
}


class _RandomWordsState extends State<RandomWords> {

  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = TextStyle(fontSize: 18.0);


  // create a list
  Widget _buildSuggestions() {

    return ListView.builder(

      // list style
      padding: EdgeInsets.all(16.0),

      //create row item in list
      itemBuilder: (context, i){
        
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_suggestions[index]);
      });
  }


  // create a list row
  Widget _buildRow(WordPair pair){

    final alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing:Icon(
        alreadySaved ? Icons.favorite: Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),

      // the action is when a list row is tapped 
      onTap: () {
        setState((){
          if(alreadySaved){
            _saved.remove(pair);
          }else{
            _saved.add(pair);
          }
        });
      },
    );
  }


  void _pushSaved(){
    Navigator.of(context).push(

      // made another page
      MaterialPageRoute<void>(

        // build a page
        builder:  (BuildContext context){

          // mapping the _saved of variable
          final tiles = _saved.map(
            (WordPair pair){
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );

          // made list row from the tiles that was mapped
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          // display elements on the page
          return Scaffold(
            appBar:  AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  // call the method when change state
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),

        // the action makes executed by tap of Hamburg menu
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

}


class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();

}
