import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello_world/class/pop_actor.dart';
import 'package:hello_world/class/popmovie.dart';
import 'package:hello_world/screen/detailmovie2.dart';
import 'package:hello_world/screen/editpopmovie.dart';
import 'package:http/http.dart' as http;

class DetailPop extends StatefulWidget {
  final int id;

  const DetailPop({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailPopState();
  }
}

class _DetailPopState extends State<DetailPop> {
  List<PopMovie> PMs = [];
  PopMovie? _pm;
  PopActor? _pa;
  Future<String> fetchData() async {
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419103/detailmovie.php"),
        body: {
          'id': widget.id.toString(),
        });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  bacaData() {
    fetchData().then((value) {
      Map json = jsonDecode(value);
      _pm = PopMovie.fromJson(json['data']);
      _pa = PopActor.fromJson(json['data']);
      setState(() {});
    });
  }

  Widget tampilData() {
    if (_pm == null && _pa == null) {
      return const CircularProgressIndicator();
    }
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(10),
      child: Column(children: <Widget>[
        Text(
          _pm!.title.toString(),
          style: const TextStyle(fontSize: 25),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            _pm!.overview.toString(),
            style: const TextStyle(fontSize: 15),
          ),
        ),
        Padding(padding: EdgeInsets.all(10), child: Text("Genre:")),
        Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _pm?.genres?.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Text(_pm?.genres?[index]['genre_name']);
                })),
        Padding(padding: EdgeInsets.all(10), child: Text("Cast:")),
        Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _pa?.infocharacter?.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Text(_pa?.infocharacter?[index]['character_name']);
                })),
        Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              child: Text('Edit'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPopMovie(movieID: widget.id),
                  ),
                );
              },
            )),
        ElevatedButton(
            onPressed: () {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: Text('Delete Movie'),
                        content: Text(
                            "Are you sure you want to delete this movie? "),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailMovie2(id: widget.id))),
                            child: const Text('OK'),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel"))
                        ],
                      ));
            },
            child: Text("Delete")),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail of popular movie'),
      ),
      body: ListView(children: <Widget>[
        tampilData(),
      ]),
    );
  }
}
