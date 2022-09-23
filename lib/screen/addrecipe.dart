import 'package:flutter/material.dart';
import 'package:hello_world/class/recipe.dart';

final TextEditingController _recipe_name_cont = TextEditingController();
final TextEditingController _recipe_desc_cont = TextEditingController();
final TextEditingController _recipe_photo_cont = TextEditingController();
final TextEditingController _recipe_category_cont = TextEditingController();

class AddRecipe extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddRecipeState();
  }
}

class _AddRecipeState extends State<AddRecipe> {
  @override
  int _charleft = 0;
  String _recipeCategory = "Traditional";

  void initState() {
    // TODO: implement initState
    super.initState();
    _recipe_name_cont.text = "Your food name";
    _recipe_desc_cont.text = "Recipe of....";
    _charleft = 200;
    _recipe_desc_cont.text.length;
    _recipe_photo_cont.text = '';
    _recipe_category_cont.text = 'Name recipe category';
  }

  Color getButtonColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return Colors.red;
    } else {
      return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Recipe'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                  controller: _recipe_name_cont,
                  onChanged: (v) {
                    print(_recipe_name_cont);
                    print(v);
                  }),
              TextField(
                controller: _recipe_desc_cont,
                onChanged: (v) {
                  setState(() {
                    _charleft = 200 - v.length;
                  });
                },
                keyboardType: TextInputType.multiline,
                minLines: 4,
                maxLines: null,
              ),
              Text("char left: " + _charleft.toString()),
              TextField(
                controller: _recipe_category_cont,
                onSubmitted: (v) {
                  setState(() {});
                },
              ),
              TextField(
                controller: _recipe_photo_cont,
                onSubmitted: (v) {
                  setState(() {});
                },
              ),
              Image.network(_recipe_photo_cont.text),
              DropdownButton(
                  items: const [
                    DropdownMenuItem<String>(
                      value: "Traditional",
                      child: const Text("Traditional"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Japanese",
                      child: const Text("Japanese"),
                    ),
                  ],
                  value: _recipeCategory,
                  onChanged: (value) {
                    setState(() {
                      _recipeCategory = value.toString();
                    });
                  }),
              ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5),
                      backgroundColor:
                          MaterialStateProperty.resolveWith(getButtonColor)),
                  onPressed: () {
                    recipes.add(Recipe(
                        id: recipes.length + 1,
                        name: _recipe_name_cont.text,
                        photo: _recipe_photo_cont.text,
                        desc: _recipe_desc_cont.text,
                        category: _recipe_category_cont.text));

                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text('Add Recipe'),
                              content: Text('Recipe successfully added'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ));
                  },
                  child: Text("SUBMIT")),
            ],
          ),
        ));
  }
}
