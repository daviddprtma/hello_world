import 'package:json_annotation/json_annotation.dart';
part 'pop_actor.g.dart';

@JsonSerializable()
class PopActor {
  @JsonKey(name: 'person_id')
  final int person_id;
  @JsonKey(name: 'person_name')
  final String person_name;

  PopActor({
    required this.person_id,
    required this.person_name,
  });

  factory PopActor.fromJson(Map<String, dynamic> json) =>
      _$PopActorFromJson(json);
}
