import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello_world/class/pop_actor.dart';
import 'package:http/http.dart' as http;

String _temp = 'Waiting API respond...';
List<PopActor> PAs = [];

Future<String> fetchData() async {
  final response = await http
      .get(Uri.https("ubaya.fun", 'flutter/160419103/popularartis.php'));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API.');
  }
}

class PopularActor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PopularActorState();
  }
}

class _PopularActorState extends State<PopularActor> {
  readData() {
    Future<String> data = fetchData();
    data.then((value) {
      Map json = jsonDecode(value);
      for (var popActor in json['data']) {
        PopActor pa = PopActor.fromJson(popActor);
        PAs.add(pa);
      }
      setState(() {
        _temp = PAs[1].person_name.toString();
      });
    });
  }

  Widget daftarPopActor(data) {
    List<PopActor> PAs2 = [];
    Map json = jsonDecode(data);
    for (var popActor in json['data']) {
      PopActor pa = PopActor.fromJson(popActor);
      PAs2.add(pa);
    }
    return ListView.builder(
        itemCount: PAs2.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Card(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.recent_actors, size: 30),
                title: Text(PAs2[index].person_id.toString()),
                subtitle: Text(PAs2[index].person_name.toString()),
              ),
            ],
          ));
        });
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Actor"),
      ),
      body: ListView(
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 2,
              child: FutureBuilder(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return daftarPopActor(snapshot.data.toString());
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }))
        ],
      ),
    );
  }
}
