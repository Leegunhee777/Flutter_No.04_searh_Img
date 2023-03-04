import 'package:mvvmsearchimage/data/data_source/pixabay_api.dart';
import 'package:mvvmsearchimage/data/data_source/result.dart';
import 'package:mvvmsearchimage/domain/repository/photo_api_repository.dart';
import 'package:mvvmsearchimage/domain/model/photo.dart';

class PhotoApiRepositoryImpl implements PhotoApiRepository {
  PixabayApi api;

  PhotoApiRepositoryImpl(this.api);

  @override
  Future<Result<List<Photo>>> fetch(String query) async {
    final Result<Iterable> result = await api.fetch(query);

    if (result is Success<Iterable>) {
      return Result.success(result.data.map((e) => Photo.fromJson(e)).toList());
    } else if (result is Error<Iterable>) {
      return Result.error(result.message);
    }

    return Result.error('알수없는 에러');
  }
}
