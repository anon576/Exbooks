import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductAPI {
  static Future<List<dynamic>> fetchProducts(
      {int page = 1, int pageSize = 10}) async {
    final response = await http.get(Uri.parse(
        'https://fakestoreapi.com/products?_page=$page&_limit=$pageSize'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<List<dynamic>> fetchCarsoul() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products?limit=5'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
