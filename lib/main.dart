import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      
      body: Center(
        child: Text('Information:${user.email}'),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context){
              return AddPostPage();
            }),
          );
        },
      ),
    );
  }
}


class AddPostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Post a message'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Back'),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}