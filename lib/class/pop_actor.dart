class PopActor {
  final int? person_id;
  final String? person_name;

  final List? infocharacter;

  PopActor(
      {required this.person_id,
      required this.person_name,
      required this.infocharacter});

  factory PopActor.fromJson(Map<String, dynamic> json) {
    return PopActor(
        person_id: json['person_id'],
        person_name: json['person_name'],
        infocharacter: json['infocharacter']);
  }
}
