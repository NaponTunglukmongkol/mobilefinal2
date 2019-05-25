import 'package:flutter/material.dart';
import '../model/user.dart';

class UserScreen extends StatelessWidget {
  UserProvider user = UserProvider();
  @override
  Widget build(BuildContext context) {
    // user: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("user Screen"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Open DB"), 
              onPressed: () {
                user.open("user.db");
                print('open');
              },
            ),
            RaisedButton(
              child: Text("Insert"), 
              onPressed: () async{
                User data = User();
                data.name = "test";
                data.age = 10;
                data.userid = "test";
                data.password = "test";
                User result = await user.insert(data);
                print(result);
                /*user.insert(data).then((result){
                });*/
              },
            ),
            RaisedButton(
              child: Text("Get id=1"), 
              onPressed: () async{
                User data = await user.getUser(1);
                print(data.toMap());
              },
            ),
            RaisedButton(
              child: Text("Get id=2"), 
              onPressed: () async{
                User data = await user.getUser(2);
                print(data.toMap());
              },
            ),
            RaisedButton(
              child: Text("Get id=3"), 
              onPressed: () async{
                User data = await user.getUser(3);
                print(data.toMap());
              },
            ),
            RaisedButton(
              child: Text("Update"), 
              onPressed: () async {
                User newData = User();
                newData.id = 1;
                newData.name = 'New Test';
                newData.age = 20;
                newData.userid = 'tester';
                newData.password = 'tester';

                int result = await user.update(newData);
                print(result);
              },
            ),
            RaisedButton(
              child: Text("Delete"), 
              onPressed: () async {
                int result = await user.delete(1);
                print(result);
              },
            ),
            RaisedButton(
              child: Text("Close"), 
              onPressed: () {
                user.close();
              },
            )
          ],
        ),
      ),
    );
  }
}