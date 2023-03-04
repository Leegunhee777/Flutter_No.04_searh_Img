import 'package:mvvmsearchimage/data/data_source/result.dart';
import 'package:mvvmsearchimage/domain/model/photo.dart';

abstract class PhotoApiRepository {
  Future<Result<List<Photo>>> fetch(String query);
}
