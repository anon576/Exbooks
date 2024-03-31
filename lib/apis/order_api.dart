import 'dart:convert';
import 'package:bookbazaar/components/share_prefs.dart';
import 'package:http/http.dart' as http;

class OrderAPI{


 static Future<List<dynamic>> getUserOrderss() async {
    try {
      int userid =await SharePrefs.readPrefs("userID", "int");
      final response = await http.get(Uri.parse('http://192.168.43.192:5000/your_order/$userid'));
      
      if (response.statusCode == 200) {
        Map<dynamic,dynamic> data = jsonDecode(response.body);
        return data['orders'];
      } else {
        throw Exception('Failed to load books');
      }
    } catch(error) {
      print(error);
      throw Exception('Failed to load books');
    }
  }


 }