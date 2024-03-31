import 'dart:convert';
import 'package:bookbazaar/components/share_prefs.dart';
import 'package:http/http.dart' as http;

class BookAPI {


 static Future<List<dynamic>> getUserBooks() async {
    try {
      int userid =await SharePrefs.readPrefs("userID", "int");
      final response = await http.get(Uri.parse('http://192.168.43.192:5000/your_book/$userid'));
      
      if (response.statusCode == 200) {
        Map<dynamic,dynamic> data = jsonDecode(response.body);
        return data['books'];
      } else {
        throw Exception('Failed to load books');
      }
    } catch(error) {
      print(error);
      throw Exception('Failed to load books');
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

    static Future< Map<dynamic,dynamic> > updateBook(
      {required String? bookname,
      required int bID,
      required int? price,
      required String? description,
      required String? author,
      required String? image,
      required String? category}) async {
    try {
      int userid = await SharePrefs.readPrefs("userID", "int");

      Map<String, dynamic> bookdata = {
        "bid":bID,
        "bookname": bookname,
        "price": price,
        "description": description,
        "author": author,
        "image": image,
        "category": category,
        "userid": userid
      };

      String jsonData = jsonEncode(bookdata);

      Uri apiUrl = Uri.parse('http://192.168.43.192:5000/update_book');

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

static Future<bool> deletebook({
    required int bid,
  }) async {
    try {
      final apiUrl = Uri.parse('http://192.168.43.192:5000/delete_book/$bid');
      final response = await http.delete(apiUrl);
      
      if (response.statusCode == 200) {
        // Address deleted successfully
        return true;
      } else {
        // Failed to delete address
        return false;
      }
    } catch (error) {
      // Error occurred during the deletion process
      return false;
    }
  }


}
