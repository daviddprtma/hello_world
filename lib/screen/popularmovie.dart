import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello_world/class/genre.dart';
import 'package:hello_world/class/popmovie.dart';
import 'package:hello_world/screen/cart.dart';
import 'package:hello_world/screen/detailpop.dart';
import 'package:http/http.dart' as http;

String _temp = 'Waiting API respond...';
List<PopMovie> PMs = [];
String _txtCari = "";
final dbHelper = DatabaseHelper.instance;

Future<String> fetchData() async {
  final response = await http.post(
      Uri.parse("https://ubaya.fun/flutter/160419103/movie.php"),
      body: {'cari': _txtCari});
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API.');
  }
}

class PopularMovie extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PopularMovieState();
  }
}

class _PopularMovieState extends State<PopularMovie> {
  @override
  void initState() {
    super.initState();

    bacaData();
  }

  bacaData() {
    PMs.clear();
    Future<String> data = fetchData();
    data.then((value) {
      Map json = jsonDecode(value);
      for (var mov in json['data']) {
        PopMovie pm = PopMovie.fromJson(mov);
        PMs.add(pm);
      }

      setState(() {
        // _temp = PMs[2].overview;
      });
    });
  }

  void addCart(movie_id, title) async {
    Map<String, dynamic> row = {
      'movie_id': movie_id,
      'title': title,
      'jumlah': 1
    };
    await dbHelper.addCart(row);
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Sukses manambah barang')));
  }

  Widget DaftarPopMovie(popMovs) {
    if (popMovs != null) {
      return ListView.builder(
          itemCount: popMovs.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return new Card(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.movie, size: 30),
                    title: GestureDetector(
                      child: Text(PMs[index].title.toString()),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPop(
                                      id: PMs[index].movie_id!.toInt(),
                                    )));
                      },
                    ),
                    subtitle: Column(
                      children: [
                        Text(PMs[index].overview),
                        ElevatedButton(
                            onPressed: () {
                              addCart(PMs[index].movie_id, PMs[index].title);
                            },
                            child: Text("Add to cart"))
                      ],
                    )),
              ],
            ));
          });
    } else {
      return CircularProgressIndicator();
    }
  }

  Widget DaftarPopMovie2(data) {
    List<PopMovie> PMs2 = [];
    Map json = jsonDecode(data);
    for (var mov in json['data']) {
      PopMovie pm = PopMovie.fromJson(mov);
      PMs2.add(pm);
    }
    return ListView.builder(
        itemCount: PMs2.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Card(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.movie, size: 30),
                title: Text(PMs2[index].title.toString()),
                subtitle: Text(PMs2[index].overview.toString()),
              ),
            ],
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Popular Movie')),
        body: ListView(children: [
          TextFormField(
            decoration: const InputDecoration(
                icon: Icon(Icons.search), labelText: 'Judul mengandung kata'),
            onFieldSubmitted: (value) {
              _txtCari = value;
              bacaData();
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: DaftarPopMovie(PMs),
          ),
          Container(
              height: MediaQuery.of(context).size.height / 2,
              child: FutureBuilder(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return DaftarPopMovie2(snapshot.data.toString());
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ))
        ]));
  }
}
