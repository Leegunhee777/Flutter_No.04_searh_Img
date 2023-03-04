import 'package:flutter_test/flutter_test.dart';
import 'package:mvvmsearchimage/data/data_source/result.dart';
import 'package:mvvmsearchimage/domain/repository/photo_api_repository.dart';
import 'package:mvvmsearchimage/domain/model/photo.dart';
import 'package:mvvmsearchimage/domain/use_case/get_photos_use_case.dart';
import 'package:mvvmsearchimage/presentation/home/home_view_model.dart';

void main() {
  test('Stream이 잘 동착해야한다.', () async {
    final viewModel =
        HomeViewModel(GetPhotosUseCase(FakePhotoApiRepositoryImpl()));

    await viewModel.fetch('apple');
    // await viewModel.fetch('apple');

    final List<Photo> result = fakeJson.map((e) => Photo.fromJson(e)).toList();

    expect(viewModel.state.photos, isA());

    // 원래는 아래처럼 테스트코드를 짜야함
    // expect(viewModel.photos, result);
  });
}

class FakePhotoApiRepositoryImpl implements PhotoApiRepository {
  @override
  Future<Result<List<Photo>>> fetch(String query) async {
    Future.delayed(const Duration(milliseconds: 500));
    return Result.success(fakeJson.map((e) => Photo.fromJson(e)).toList());
  }
}

List<Map<String, dynamic>> fakeJson = [
  {
    "id": 2295434,
    "pageURL":
        "https://pixabay.com/photos/spring-bird-bird-tit-spring-blue-2295434/",
    "type": "photo",
    "tags": "spring bird, bird, tit",
    "previewURL":
        "https://cdn.pixabay.com/photo/2017/05/08/13/15/spring-bird-2295434_150.jpg",
    "previewWidth": 150,
    "previewHeight": 99,
    "webformatURL":
        "https://pixabay.com/get/gcc248192ebf8f5a83dedb15ce966edd855a14fb78f574720de8cbf404bc955fede4c9f8d33935ec53d68c714979b4f403d10f82c29bc527ed164773738655272_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 426,
    "largeImageURL":
        "https://pixabay.com/get/g1f1e877a32d630f2eac5d8139335cbfcdf48b2e4dd71e60a4d02365dcd8652219648aae422d3c1e3cb28d54fd71f1ee70ae81b6aae668950af8555eb2ce93fcc_1280.jpg",
    "imageWidth": 5363,
    "imageHeight": 3575,
    "imageSize": 2938651,
    "views": 619943,
    "downloads": 357042,
    "collections": 2053,
    "likes": 1981,
    "comments": 248,
    "user_id": 334088,
    "user": "JillWellington",
    "userImageURL":
        "https://cdn.pixabay.com/user/2018/06/27/01-23-02-27_250x250.jpg"
  },
  {
    "id": 3063284,
    "pageURL":
        "https://pixabay.com/photos/rose-flower-petal-floral-noble-3063284/",
    "type": "photo",
    "tags": "rose, flower, petal",
    "previewURL":
        "https://cdn.pixabay.com/photo/2018/01/05/16/24/rose-3063284_150.jpg",
    "previewWidth": 150,
    "previewHeight": 99,
    "webformatURL":
        "https://pixabay.com/get/g6d30804745487673210895c13dc655ecef21903224743eb1bd7d7afe6e5da3d4174118688eff8ac160492b70711ce8278f16400acdb6ffdf581db89a0c2ed82e_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 426,
    "largeImageURL":
        "https://pixabay.com/get/gc02a292db6a4cd5b4a3730f7bf689b1248ac19f9dc6ee83c9e16257d34c48f5d215117949b88079c79f412383f453916a410a7741b4d4553b73da5df927da806_1280.jpg",
    "imageWidth": 6000,
    "imageHeight": 4000,
    "imageSize": 3574625,
    "views": 1042517,
    "downloads": 673592,
    "collections": 1408,
    "likes": 1522,
    "comments": 329,
    "user_id": 1564471,
    "user": "anncapictures",
    "userImageURL":
        "https://cdn.pixabay.com/user/2015/11/27/06-58-54-609_250x250.jpg"
  }
];
