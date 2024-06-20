import 'dart:convert';
import 'package:http/http.dart' as http;

class AddAdDitails {
  static Future<http.Response> postAdDetail(
    String ad_image,
    String ad_text,
  ) async {
    String url = 'https://test-depoly-verel-api.vercel.app/adBox/create';
    var requsetBody = jsonEncode({
      "ad_pic": ad_image,
      "ad_text": ad_text,
    });
    var respone = await http.post(Uri.parse(url),
        body: requsetBody, headers: {'Content-Type': 'application/json'});
    return respone;
  }
}

class DeleteAd {
  static Future<http.Response> deleteAd(
    String adId,
  ) async {
    String url =
        'https://test-depoly-verel-api.vercel.app/adBox/delete/${adId}';
    var respone = await http.delete(Uri.parse(url));
    return respone;
  }
}
