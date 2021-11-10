import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Avatar Page"),
          actions: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://iteragrow.com/wp-content/uploads/2018/04/buyer-persona-e1545248524290.jpg'),
            ),
            Container(
              margin: EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                child: Text("AV"),
                backgroundColor: Colors.brown,
              ),
            )
          ],
        ),
        body: Center(
          child: FadeInImage(
              placeholder: AssetImage('assets/jar-loading.gif'),
              image: NetworkImage(
                  'https://iteragrow.com/wp-content/uploads/2018/04/buyer-persona-e1545248524290.jpg'),
              fadeInDuration: Duration(milliseconds: 200)),
        ));
  }
}
