import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello_world/class/pop_actor.dart';
import 'package:hello_world/class/popmovie.dart';
import 'package:hello_world/screen/detailmovie2.dart';
import 'package:hello_world/screen/editpopmovie.dart';
import 'package:hello_world/screen/popularmovie.dart';
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

  Future onGoBack(dynamic value) {
    // print("masuk goback");
    setState(() {
      bacaData();
    });
    throw Exception("gagal refresh");
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

  void deleteMovie(int id, String title) async {
    final response = await http
        .get(Uri.parse("https://ubaya.fun/flutter/160419103/deletemovie.php"));
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        print(id);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sukses Menghapus Data ' + title)));
      }
    } else {
      throw Exception('Failed to read API');
    }
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
        Image.network(
            "https://ubaya.fun/flutter/160419103/images/${widget.id}.jpg"),
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
                    builder: (context) => EditPopMovie(
                      movieID: widget.id,
                    ),
                  ),
                ).then(onGoBack);
              },
            )),
        ElevatedButton(
            onPressed: () {
              deleteMovie(_pm!.movie_id!.toInt(), _pm!.title);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PopularMovie()));
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
