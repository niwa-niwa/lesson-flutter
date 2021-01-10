import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter-Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}


class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  String infoText = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: 
        AppBar(
          title:Text('Login')
        ),

      body:
        Center(
          child: Container(
            padding: EdgeInsets.all(24),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'E-mail'),
                    onChanged: (String value){
                      setState((){
                        email = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onChanged: (String value){
                      setState((){
                        password = value;
                      });
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Text(infoText),
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text('Sign up'),
                      // Create account
                      onPressed: () async {
                        try{
                          final FirebaseAuth auth = FirebaseAuth.instance;

                          // get result of authentication
                          final AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);
                          
                          // get  authed user from result 
                          final FirebaseUser user = result.user;

                          // move to chat page with the user
                          await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                            return ChatPage(user);
                          }));

                        }catch (e) {
                          setState((){
                            infoText = "Failed sign up : ${e.message}";
                          });
                        }
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child:
                      OutlineButton(
                        textColor: Colors.blue,
                        child: Text('Login'),
                        // Login account
                        onPressed: () async {
                          try{
                            final FirebaseAuth auth = FirebaseAuth.instance;
                          
                            final AuthResult result = await auth.signInWithEmailAndPassword(
                              email: email,
                              password: password,
                            );

                            final FirebaseUser user = result.user;
                            await Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context){
                                return ChatPage(user);
                              }),
                            );
                          }catch (e) {
                            setState((){
                              infoText = "Failed login : ${e.message}";
                            });
                          }
                        },
                      )
                  )
                ],
            ),
          ),

        ),
    );
  }
}


class ChatPage extends StatelessWidget{

  //Constructor
  ChatPage(this.user);

  // variable
  final FirebaseUser user;

  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(
        title: Text('Chat'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () async{
              //logout
              await FirebaseAuth.instance.signOut();
              
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context){
                  return LoginPage();
                }),
              );
            },
          ),
        ],
      ),
      
      body: Column(
        children:<Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: Text('Login information:${user.email}'),
          ),
          
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                .collection('posts')
                .orderBy('date')
                .getDocuments(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  final List<DocumentSnapshot> documents = snapshot.data.documents;
                  return ListView(
                    children: documents.map((document){
                      return Card(
                        child: ListTile(
                          title: Text(document['text']),
                          subtitle: Text(document['email']),
                        ),
                      );
                    }).toList(),
                  );
                }
                return Center(
                  child: Text('Loading...'),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context){
              return AddPostPage(user);
            }),
          );
        },
      ),
    );
  }
}


class AddPostPage extends StatefulWidget {

  AddPostPage(this.user);

  final FirebaseUser user;

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage>{

  String messageText = '';

  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(
        title: Text('Post a message'),
      ),

      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Send Message'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onChanged: (String value){
                  setState((){
                    messageText = value;
                  });
                },
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text('Post'),
                  onPressed: () async {
                    final date = DateTime.now().toLocal().toIso8601String();
                    final email = widget.user.email;
                    await Firestore.instance
                      .collection('posts')
                      .document()
                      .setData({
                        'text': messageText,
                        'email': email,
                        'date': date,
                      });
                      Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}