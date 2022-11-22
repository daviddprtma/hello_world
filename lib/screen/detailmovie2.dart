import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello_world/class/popmovie.dart';
import 'package:http/http.dart' as http;

class DetailMovie2 extends StatefulWidget {
  final int id;

  const DetailMovie2({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailMovie2State();
  }
}

class _DetailMovie2State extends State<DetailMovie2> {
  PopMovie? _pm;

  Future<String> fetchDeleteMovie() async {
    final response = await http.post(
        Uri.parse('https://ubaya.fun/flutter/160419103/deletemovie.php'),
        body: {'id': widget.id.toString()});

    if (response.statusCode == 200) {
      return response.body;
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete detail movie.');
    }
  }

  @override
  void initState() {
    super.initState();
    deleteMovie();
  }

  deleteMovie() {
    fetchDeleteMovie().then((value) {
      Map json = jsonDecode(value);
      _pm = PopMovie.fromJson(json['id']);
      setState(() {});
    });
  }

  Widget hapusDataMovie() {
    if (_pm == null) {
      return const CircularProgressIndicator();
    }
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(10),
      child: Column(children: <Widget>[
        Text(
          _pm!.title.toString(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
            onPressed: () {
              deleteMovie();
              Navigator.pop(context);
            },
            child: Text('Kembali'))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Delete Detail Movie 2 '),
        ),
        body: ListView(
          children: <Widget>[hapusDataMovie()],
        ));
  }
}
