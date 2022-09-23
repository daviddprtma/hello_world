import 'package:flutter/material.dart';
import 'package:hello_world/class/recipe.dart';
import 'package:hello_world/screen/itemBasket.dart';

class Basket extends StatefulWidget {
  @override
  State<Basket> createState() => _MyBasketState();
}

class _MyBasketState extends State<Basket> {
  List<Widget> widRecipes() {
    List<Widget> temp = [];
    int i = 0;

    while (i < recipes.length) {
      Widget w = Card(
          margin: EdgeInsets.all(20),
          elevation: 20,
          child: Column(children: [
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  recipes[i].name,
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                )),
            Image.network(recipes[i].photo),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  recipes[i].desc,
                )),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "category: " + recipes[i].category,
                )),
            TextButton(
                onPressed: () {
                  setState(() {
                    final currentIdx = i;
                    recipes.removeWhere((recipe) => recipe.id == currentIdx);
                  });
                },
                child: Text("Delete")),
          ]));
      temp.add(w);
      i++;
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Basket')),
        body: SingleChildScrollView(
          child: Column(children: [
            Text("This is Basket"),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemBasket(1, 10)));
                },
                child: Text("Item1")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemBasket(2, 14)));
                },
                child: Text("Item2")),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: widRecipes(),
            ),
            Divider(
              height: 100,
            )
          ]),
        ));
  }
}
