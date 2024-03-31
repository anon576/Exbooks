import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductAPI {
  static Future<Map<String,dynamic>> fetchProducts(
      {required int range
      }) async {
    final response = await http.get(Uri.parse(
        'http://192.168.43.192:5000/get_feed?lastbookid=$range'));

    if (response.statusCode == 200) {
      Map<String,dynamic> fetchedBooks = jsonDecode(response.body);

      return fetchedBooks;
    } else {
     return {};
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
