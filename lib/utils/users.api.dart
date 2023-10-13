import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

var logger = Logger();
//after scan is complete 
//this fetches content into the display page after scan is done
Future<Map<String, dynamic>> fetchUsers(id) async {
  String url = "http://fciis2.fcghana.org/cites/v1/users/searchcites.php?id=$id";
  
  try {
    final response = await http.get(Uri.parse(url));
    logger.d(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data == null) {
        throw Exception('Data is null');
      } else if (data is Map<String, dynamic>) {
        return data;
      } else {
        throw Exception('Invalid JSON format');
      }
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}



