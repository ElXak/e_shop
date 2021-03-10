import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class NetworkHelper {
  final url;
  final Map<String, String> headers, body;

  NetworkHelper(
    this.url, {
    this.headers,
    this.body,
  });

  Future getData() async {
    http.Response response = await http.get(
      Uri.https(kHostURL, url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      String data = response.body;
      print('http.response => ${jsonDecode(data)}');
      return jsonDecode(data);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future postData() async {
    http.Response response = await http.post(
      Uri.https(kHostURL, url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      String data = response.body;
      print('http.response => ${jsonDecode(data)}');
      return jsonDecode(data);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}
