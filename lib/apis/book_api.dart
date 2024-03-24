import 'dart:convert';
import 'package:bookbazaar/components/share_prefs.dart';
import 'package:http/http.dart' as http;

class BookAPI {
  static Future<List<dynamic>> getAllBooks() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products?limit=5'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future< Map<dynamic,dynamic> > addBook(
      {required String? bookname,
      required int? price,
      required String? description,
      required String? author,
      required String? image,
      required String? category}) async {
    try {
      int userid = await SharePrefs.readPrefs("userID", "int");

      Map<String, dynamic> bookdata = {
        "bookname": bookname,
        "price": price,
        "description": description,
        "author": author,
        "image": image,
        "category": category,
        "userid": userid
      };

      String jsonData = jsonEncode(bookdata);

      Uri apiUrl = Uri.parse('http://192.168.43.192:5000/add_book');

      http.Response response = await http.post(apiUrl,
          headers: {'Content-Type': 'application/json'}, body: jsonData);

      if (response.statusCode == 200) {
        Map<dynamic,dynamic> data = jsonDecode(response.body);

        return data;
      } else {
         Map<dynamic,dynamic>  data = {
          "success":false
         };
        return data;
      }
    } catch (error) {
     Map<dynamic,dynamic>  data = {
          "success":false
         };
        return data;
    }
  }
}
