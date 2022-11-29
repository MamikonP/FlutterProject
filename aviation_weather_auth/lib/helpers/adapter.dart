import 'dart:convert';

import 'package:xml2json/xml2json.dart';

abstract class Adapter<T> {
  Obj convertStringXMLToJson<Obj>(String data) {
    final Xml2Json xml2json = Xml2Json();
    xml2json.parse(data);
    final String jsonString = xml2json.toParker();
    return convertStringToJson<Obj>(jsonString);
  }

  Obj convertStringToJson<Obj>(String data) => jsonDecode(data) as Obj;

  List<T> getDataToModel(List<dynamic> data);
}
