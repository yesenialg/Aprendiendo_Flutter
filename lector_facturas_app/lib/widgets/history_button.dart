import 'package:flutter/material.dart';

class HistoryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
     heroTag: "history",
     elevation: 50,
      onPressed: () {
        Navigator.pushNamed(context, 'table');
        
      },
      child: Icon(Icons.history),
    );
  }

}
