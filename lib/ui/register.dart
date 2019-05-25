import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import '../model/user.dart';

class RegisterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage>{
  final _formkey = GlobalKey<FormState>();
  TextEditingController userid = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    UserProvider user = UserProvider();
    user.open("user.db");
    /*int checkid = 0;
    int checkpassword = 0;
    int checkconfirm = 0;
    String checking = '';*/
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          children: <Widget>[
            TextFormField(
              controller: userid,
              decoration: InputDecoration(
                labelText: "User id",
                hintText: "User id",
                icon: Icon(Icons.perm_identity),
              ),
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => print(value),
              validator: (value){
                if(value.length < 6){
                  return "User Id ต้องมีความยาวอยู่ในช่วง 6-12 ตัวอักษร";
                }
              },
            ),
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                labelText: "Name",
                hintText: "Name",
                icon: Icon(Icons.person),
              ),
              keyboardType: TextInputType.text,
              validator: (value){
                int checkspace = 0;
                int checkbefore = 0;
                int checkafter = 0;
                for(int v=0; v<value.length; v++){
                  if(value[v] == ' ' && checkbefore == 1){
                      if(checkspace == 1){
                        return "Name ต้องมีทั้งชื่อและนามสุกลคั่นด้วย space 1 space เท่านั้น";
                      }
                    checkspace = 1;
                  }else if(isAlpha(value[v])){
                    if(checkbefore == 1 && checkspace == 1){
                      checkafter = 1;
                    }
                    checkbefore = 1;
                  }
                }
                if(checkspace == 0 || checkbefore == 0 || checkafter == 0){
                  return "Name ต้องมีทั้งชื่อและนามสุกลคั่นด้วย space 1 space เท่านั้น";
                }
              },
            ),
            TextFormField(
              controller: age,
              decoration: InputDecoration(
                labelText: "Age",
                hintText: "Age",
                icon: Icon(Icons.perm_contact_calendar,)
              ),
              keyboardType: TextInputType.text,
              validator: (value){
                if(isAlpha(value) || int.parse(value) < 10 || int.parse(value) > 80){
                  return "Age ต้องเป็นตัวเลขและอยู่ในช่วง 10-80";
                }
              },
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
              validator: (value){
                if(value.length < 6){
                  return "Password มีความยาวมากกว่า 6";
                }
              },
            ),
            Builder(builder: (context) => RaisedButton(
              child: Text('REGISTER NEW ACCOUNT'),
              onPressed: () async{
                if(_formkey.currentState.validate()){
                  User data = User();
                  data.userid = userid.text;
                  data.name = name.text;
                  data.age = int.parse(age.text);
                  data.password = password.text;
                  User result = await user.insert(data);
                  print(result);
                  print('pass');
                  Navigator.pushNamed(context, "/");
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}