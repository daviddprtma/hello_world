import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello_world/class/genre.dart';
import 'package:hello_world/class/popmovie.dart';
import 'package:hello_world/screen/login.dart';
import 'package:http/http.dart' as http;
import 'package:numberpicker/numberpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPopMovie extends StatefulWidget {
  int movieID;

  EditPopMovie({Key? key, required this.movieID}) : super(key: key);
  @override
  EditPopMovieState createState() {
    return EditPopMovieState();
  }
}

class EditPopMovieState extends State<EditPopMovie> {
  PopMovie? pm;
  File? _image;
  File? _imageProses;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleCont = TextEditingController();
  TextEditingController _homepageCont = TextEditingController();
  TextEditingController _overviewCont = TextEditingController();
  TextEditingController _releaseDate = TextEditingController();
  int _runtime = 100;

  String active_user = "";

  Future<String> fetchData() async {
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419103/detailmovie.php"),
        body: {'id': widget.movieID.toString()});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  Future<List> daftarGenre() async {
    Map json;
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419103/genrelist.php"),
        body: {'movie_id': widget.movieID.toString()});

    if (response.statusCode == 200) {
      print(response.body);
      json = jsonDecode(response.body);
      return json['data'];
    } else {
      throw Exception('Failed to read API');
    }
  }

  Future<String> checkUser() async {
    final prefs = await SharedPreferences.getInstance();
    String user_id = prefs.getString('user_id') ?? '';
    return user_id;
  }

  void submit() async {
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419103/updatemovie.php"),
        body: {
          'title': pm!.title,
          'overview': pm!.overview,
          'homepage': pm!.homepage,
          'release_date': pm!.release_date,
          'runtime': pm!.runtime.toString(),
          'movie_id': widget.movieID.toString()
        });
    if (response.statusCode == 200) {
      print(response.body);
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        if (_imageProses == null) return;
        List<int> imageBytes = _imageProses!.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        final response2 = await http.post(
            Uri.parse(
                'https://ubaya.fun/flutter/160419103/uploadpopmovieposter.php'),
            body: {
              'movie_id': widget.movieID.toString(),
              'image': base64Image,
              'user_id': user_id
            });
        if (response2.statusCode == 200) {
          if (!mounted) return;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(response2.body)));
        }

        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Sukses mengubah Data')));
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaData() {
    fetchData().then((value) {
      Map json = jsonDecode(value);
      pm = PopMovie.fromJson(json['data']);
      setState(() {
        _titleCont.text = pm!.title.toString();
        _homepageCont.text = pm!.homepage.toString();
        _overviewCont.text = pm!.overview.toString();
        _releaseDate.text = pm!.release_date.toString();
        _runtime = pm!.runtime!.toInt();
      });
    });
  }

  void addGenre(genre_id) async {
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419103/addmoviegenre.php"),
        body: {
          'genre_id': genre_id.toString(),
          'movie_id': widget.movieID.toString()
        });
    if (response.statusCode == 200) {
      print(response.body);
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Sukses menambah genre')));
        setState(() {
          bacaData();
        });
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

  void deleteGenre(genre_id) async {
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419103/deletemoviegenre.php"),
        body: {
          'genre_id': genre_id.toString(),
          'movie_id': widget.movieID.toString(),
        });
    if (response.statusCode == 200) {
      print(response.body);
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sukses menghapus genre')));
        setState(() {
          bacaData();
        });
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

  Widget comboGenre = Text('tambah genre');

  void generateComboGenre() {
    //widget function for city list
    List<Genre> genres;
    var data = daftarGenre();
    data.then((value) {
      genres = List<Genre>.from(value.map((i) {
        return Genre.fromJSON(i);
      }));
      comboGenre = DropdownButton(
          dropdownColor: Colors.grey[100],
          hint: Text("tambah genre"),
          isDense: false,
          items: genres.map((gen) {
            return DropdownMenuItem(
              child: Column(children: <Widget>[
                Text(gen.genre_name.toString(), overflow: TextOverflow.visible),
              ]),
              value: gen.genre_id,
            );
          }).toList(),
          onChanged: (value) {
            //memnaggil fungsi menambah genre disini
            addGenre(value);
          });
    });
  }

  _imgGaleri() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 600,
        maxWidth: 600);
    if (image == null) return;
    //setState(() {
    _image = File(image.path);
    prosesFoto();
    //});
  }

  _imgKamera() async {
    final picker = ImagePicker();
    final image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 20);
    if (image == null) return;
    //setState(() {
    _image = File(image.path);
    prosesFoto();
    //});
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              color: Colors.white,
              child: new Wrap(
                children: <Widget>[
                  ListTile(
                      tileColor: Colors.white,
                      leading: Icon(Icons.photo_library),
                      title: Text('Galeri'),
                      onTap: () {
                        _imgGaleri();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: new Text('Kamera'),
                    onTap: () {
                      _imgKamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void prosesFoto() {
    checkUser().then((String result) {
      active_user = result;
    });
    Future<Directory?> extDir = getTemporaryDirectory();
    extDir.then((value) {
      String _timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

      final String filePath = value!.path + '/${_timestamp()}.jpg';
      _imageProses = File(filePath);
      img.Image? temp = img.readJpg(_image!.readAsBytesSync());
      img.Image temp2 = img.copyResize(temp!, width: 480, height: 640);

      img.drawString(temp2, img.arial_24, 8, 130, DateTime.now().toString(),
          color: img.getColor(47, 133, 110));
      img.drawString(temp2, img.arial_24, 4, 4, 'Kuliah Flutter',
          color: img.getColor(250, 100, 100));
      img.drawString(temp2, img.arial_24, 5, 550, active_user,
          color: img.getColor(250, 49, 49));
      setState(() {
        _imageProses?.writeAsBytesSync(img.writeJpg(temp2));
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bacaData();
    setState(() {
      generateComboGenre();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Popular Movie"),
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Text(widget.movieID.toString()),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    onChanged: (value) {
                      pm!.title = value;
                    },
                    controller: _titleCont,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'judul harus diisi';
                      }
                      return null;
                    },
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Website',
                    ),
                    onChanged: (value) {
                      pm!.homepage = value;
                    },
                    controller: _homepageCont,
                    validator: (value) {
                      if (value == null || !Uri.parse(value).isAbsolute) {
                        return 'alamat website salah';
                      }
                      return null;
                    },
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Overview',
                    ),
                    onChanged: (value) {
                      pm!.overview = value;
                    },
                    controller: _overviewCont,
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: 6,
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Release Date',
                        ),
                        controller: _releaseDate,
                      )),
                      ElevatedButton(
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2200))
                                .then((value) {
                              setState(() {
                                _releaseDate.text =
                                    value.toString().substring(0, 10);
                              });
                            });
                          },
                          child: Icon(
                            Icons.calendar_today_sharp,
                            color: Colors.white,
                            size: 24.0,
                          ))
                    ],
                  )),
              NumberPicker(
                value: _runtime,
                axis: Axis.horizontal,
                minValue: 50,
                maxValue: 300,
                itemHeight: 30,
                itemWidth: 60,
                step: 1,
                onChanged: (value) {
                  pm!.runtime = value;
                  setState(() => _runtime = value);
                },
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: _imageProses != null
                          ? Image.file(_imageProses!)
                          : Image.network("https://ubaya.fun/blank.jpg"))),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    var state = _formKey.currentState;
                    if (state == null || !state.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Harap Isian diperbaiki')));
                    } else {
                      submit();
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
              Padding(padding: EdgeInsets.all(10), child: Text("Genre:")),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: pm!.genres!.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return new Row(children: [
                        Text(pm!.genres![index]['genre_name']),
                        ElevatedButton(
                            onPressed: () {
                              deleteGenre(pm!.genres![index]['genre_id']);
                            },
                            child: const Text('X'))
                      ]);
                    }),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: comboGenre),
            ],
          ),
        )));
  }
}
