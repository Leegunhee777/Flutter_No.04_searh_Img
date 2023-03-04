import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mvvmsearchimage/data/data_source/result.dart';

class PixabayApi {
  static const baseUrl = 'https://pixabay.com/api/';
  static const key = '33214222-b10a138b493eb626a877b7ba6';

  Future<Result<Iterable>> fetch(String query) async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl?key=$key&q=$query&image_type=photo&pretty=true'));

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      Iterable hits = jsonResponse['hits'];
      return Result.success(hits);
    } catch (error) {
      return Result.error('네트워크에러');
    }
  }
}
