class MapperService {
  Map<String, dynamic> encodeQueryParameters(Map<String, dynamic> params) {
    final Map<String, dynamic> encodedParams = <String, dynamic>{};
    params.forEach((String key, dynamic value) {
      encodedParams.addAll(<String, dynamic>{
        Uri.encodeFull(key): Uri.encodeFull(
          value.toString(),
        )
      });
    });
    return encodedParams;
  }
}
