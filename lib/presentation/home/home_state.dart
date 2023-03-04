import 'package:mvvmsearchimage/domain/model/photo.dart';

class HomeState {
  final List<Photo> _photos;
  final bool _isLoading;

  HomeState(this._photos, this._isLoading);

//객체 복사를 통해서 상태를 바꿔준다.
  HomeState copy({List<Photo>? photos, bool? isLoading}) {
    //photos or isLoading값이 없다면 기존값을 넣어준다!
    return HomeState(photos ??= _photos, isLoading ??= _isLoading);
  }

  get isLoading => _isLoading;
  get photos => _photos;
}
