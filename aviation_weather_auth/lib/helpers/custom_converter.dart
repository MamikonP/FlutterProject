import 'dart:convert';

abstract class CustomConverter {
  T stringToJson<T>(String data) => jsonDecode(data) as T;
}
