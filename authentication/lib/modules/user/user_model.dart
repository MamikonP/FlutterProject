import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {

	User({
		required this.firstName,
		required this.lastName,
		required this.email,
		required this.userId,
		required this.preferableCurrency,
		required this.language
	});

	factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

	Map<String, dynamic> toJson() => _$UserToJson(this);

	@JsonKey(name: 'firstName')
	String firstName;
	@JsonKey(name: 'lastName')
	String lastName;
	@JsonKey(name: 'email')
	String email;
	@JsonKey(name: 'id')
	String userId;
	@JsonKey(name: 'lang')
	String language;
	String preferableCurrency;
}
