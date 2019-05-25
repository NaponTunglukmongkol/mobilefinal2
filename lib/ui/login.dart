import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController userid = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void initState() {
    Future getUserid() async{
      final prefs = await SharedPreferences.getInstance();
      final myString = prefs.getString('userid') ?? null;
      if (myString != null) {
        Navigator.pushNamed(context, "/main");
      }
    }
    getUserid();
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    UserProvider user = UserProvider();
    user.open('user.db');
    /*int checkid = 0;
    int checkpassword = 0;*/
    return Scaffold(
      body: Form(
        key: _formkey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
          children: <Widget>[
            Image.asset(
              "resources/Chino76.jpg",
            ),
            TextFormField(
              controller: userid,
              decoration: InputDecoration(
                labelText: "User id",
                hintText: "User id",
                icon: Icon(Icons.person),
              ),
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => print(value),
              validator: (value){},
            ),
            TextFormField(
              controller: password,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Password",
                icon: Icon(Icons.lock,)
              ),
              keyboardType: TextInputType.text,
              obscureText: true,
              validator: (value){},
            ),
            Builder(builder: (context) => RaisedButton(
              child: Text('Continue'),
              onPressed: () async{
                if(_formkey.currentState.validate()){
                  User result = await user.checkOnlyUser(userid.text);
                  if(result == null){
                    Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Invalid user or password'),
                    duration: Duration(seconds: 3),));
                  } else if(result.password != password.text){
                    Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Invalid user or password'),
                    duration: Duration(seconds: 3),));
                  } else {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('userid', result.userid);
                    prefs.setString('name', result.name);
                    Navigator.pushNamed(context, "/main");
                  }
                }
              }),
            ),
            FlatButton(
              child: Text('Register New Account'),
              padding: EdgeInsets.only(left: 220),
              onPressed: () {
                Navigator.pushNamed(context, "/register");
              },
              )
          ],
        ),
      ),
    );
  }
}
