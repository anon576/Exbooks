
import 'dart:convert';
import 'package:http/http.dart' as http;


class CartAPI{

  static Future<List<dynamic>> getAllCart() async {
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
