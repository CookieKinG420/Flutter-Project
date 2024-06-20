import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List> getAdboxdetails() async {
  try {
    var url = 'https://test-depoly-verel-api.vercel.app/adBox';
    var respone = await http.get(Uri.parse(url));
    if (respone.statusCode == 200) {
      return jsonDecode(respone.body);
    } else {
      throw Exception('error get Ad');
    }
  } catch (e) {
    print('get Ad error :$e');
    return [];
  }
}
