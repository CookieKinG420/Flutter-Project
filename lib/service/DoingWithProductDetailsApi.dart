import 'dart:convert';
import 'package:http/http.dart' as http;

class addProduct {
  static Future<http.Response> postProduct(
    String prodName,
    String prodDesc,
    double prodPrice,
    String prodType,
    String imageBytes,
  ) async {
    String url = 'https://test-depoly-verel-api.vercel.app/products';
    var requestBody = jsonEncode({
      "prod_name": prodName,
      "prod_desc": prodDesc,
      "prod_price": prodPrice,
      "prod_type": prodType,
      "prod_image": imageBytes,
    });
    var respose = await http.post(Uri.parse(url),
        body: requestBody, headers: {'Content-Type': 'application/json'});

    return respose;
  }
}

class UpdateProduct {
  static Future<http.Response> putProducts(
    String prodName,
    String prodDes,
    double prodPrice,
    String productId,
  ) async {
    String url =
        'https://test-depoly-verel-api.vercel.app/products/${productId}';
    var requestBody = jsonEncode({
      "prod_name": prodName,
      "prod_desc": prodDes,
      "prod_price": prodPrice,
    });
    var respone = await http.put(Uri.parse(url),
        body: requestBody, headers: {'Content-Type': 'application/json'});

    return respone;
  }
}

class DeleteProduct {
  static Future<http.Response> deleteProducct(
    String productId,
  ) async {
    String url =
        'https://test-depoly-verel-api.vercel.app/products/${productId}';
    var respone = await http.delete(Uri.parse(url));
    return respone;
  }
}
