import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class BaseResponse<T> {
  BaseResponse(this.success, this.data, this.message);

  factory BaseResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);

  final bool success;
  final String? message;
  final T? data;
}
