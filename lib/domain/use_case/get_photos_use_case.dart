import 'dart:math';

import 'package:mvvmsearchimage/data/data_source/result.dart';
import 'package:mvvmsearchimage/domain/model/photo.dart';
import 'package:mvvmsearchimage/domain/repository/photo_api_repository.dart';

class GetPhotosUseCase {
  final PhotoApiRepository photoApiRepository;

  GetPhotosUseCase(this.photoApiRepository);

  Future<Result<List<Photo>>> execute(String query) async {
    final Result<List<Photo>> result = await photoApiRepository.fetch(query);

    if (result is Success<List<Photo>>) {
      return Result.success(result.data.sublist(0, min(3, result.data.length)));
    } else if (result is Error<List<Photo>>) {
      return Result.error(result.message);
    }
    return Result.error('알수없는 에러');
  }
}
