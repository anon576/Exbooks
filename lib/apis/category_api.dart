
import 'dart:convert';
import 'package:http/http.dart' as http;


class CategoryAPI{

  static Future<List<dynamic>> getAllCategory() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load products');
    }
  }


  }
