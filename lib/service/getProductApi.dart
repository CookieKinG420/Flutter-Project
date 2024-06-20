import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List> getProducts() async {
  try {
    var urlGetProduct = 'https://test-depoly-verel-api.vercel.app/products';
    var urlGetProductRes = await http.get(Uri.parse(urlGetProduct));
    if (urlGetProductRes.statusCode == 200) {
      return jsonDecode(urlGetProductRes.body);
    } else {
      throw Exception('error');
    }
  } catch (e) {
    print('catch errorr: $e');
    return [];
  }
}
