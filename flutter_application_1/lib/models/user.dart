import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  User();

  @JsonKey(name: '+1')
  int? loved;
  // 名字
  late String name;
  late User father;
  late List<User> friends;
  late List<String> keywords;
  num? age;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
