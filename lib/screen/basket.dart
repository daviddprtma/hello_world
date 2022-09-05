import 'package:flutter/material.dart';
import 'package:hello_world/screen/itemBasket.dart';

class Basket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Basket')),
      body: Column(children: [
        Text("This is Basket"),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ItemBasket(1, 10)));
            },
            child: Text("Item1")),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ItemBasket(2, 14)));
            },
            child: Text("Item2")),
      ]),
    );
  }
}
