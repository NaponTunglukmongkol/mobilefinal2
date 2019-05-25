import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    int checkid = 0;
    int checkpassword = 0;
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
              decoration: InputDecoration(
                labelText: "User id",
                hintText: "User id",
                icon: Icon(Icons.person),
              ),
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => print(value),
              validator: (value){
                if(value.isEmpty){
                  checkid = 1;
                  return "";
                }else if(value != 'admin'){
                  checkid = 2;
                  return "";
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Password",
                icon: Icon(Icons.lock,)
              ),
              keyboardType: TextInputType.text,
              obscureText: true,
              validator: (value){
                if(value.isEmpty){
                  checkpassword = 1;
                  return "";
                }else if(value != 'admin'){
                  checkpassword = 2;
                  return "";
                }
              },
            ),
            Builder(builder: (context) => RaisedButton(
              child: Text('Continue'),
              onPressed: () {
                if(_formkey.currentState.validate()){
                  checkid = 0;
                  checkpassword = 0;
                  Navigator.pushNamed(context, "/main");
                }else if(checkid == 1 || checkpassword == 1){
                  Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('กรุณาระบุ user or password'),
                  duration: Duration(seconds: 3),));
                }
                else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('user or password ไม่ถูกต้อง'),
                  duration: Duration(seconds: 3),));
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
