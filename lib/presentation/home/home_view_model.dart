import 'package:flutter/material.dart';
import 'package:mvvmsearchimage/data/data_source/result.dart';
import 'dart:async';

import 'package:mvvmsearchimage/domain/model/photo.dart';
import 'package:mvvmsearchimage/domain/use_case/get_photos_use_case.dart';
import 'package:mvvmsearchimage/presentation/home/home_state.dart';
import 'package:mvvmsearchimage/presentation/home/home_ui_event.dart';

//ChangeNotifier를 extends하고 있는 클래스에서
//notifyListeners();를 호출하면
//HomeViewModel 클래스를 watch 하고있는 곳에 자동으로 업데이트된 결과를 반영해줄수있음
class HomeViewModel extends ChangeNotifier {
  final GetPhotosUseCase getPhotosUseCase;

  //HomeViewModel 클래스에서 state를 컨트롤해야하므로,
  //HomeState 클래스의 인스턴스를 HomeViewModel에서 private으로 선언해놓고
  //HomeViewModel 내부에서 _state에 대한 업데이트를 잔행해준다.
  HomeState _state = HomeState([], false);
  HomeState get state => _state;

//다른 개발자가 외부에서 _photos를 직접적으로 수정할수없게 해주려고
//getter를 쓰는것임
//getter를 통해 _photos 값을 제공해주지않으면
// final instance = HomeViewModel();
// instance._photos = [2,3,4] 이런식으로 수정이 되기때문에 이를 방지하고자하는 조치임
// get을 사용하면 intance.photos = [2,3,4] 이렇게 하면 에러뜬다!
// getter인 photos에 값을 넣으려고 하니까 에러가 뜨는것이다.!!!

  //state클래스를 분리하고난후 더이상 필요없다.
  // final List<Photo> _photos = [];
  // UnmodifiableListView<Photo> get photos => UnmodifiableListView(_photos);

  // //dart의 private은 _으로 처리해준다.
  // final bool _isLoading = false;
  // bool get isLoading => _isLoading;
  //이벤트 처리를위헌 스트림을 준비를한다.
  final _eventController = StreamController<HomeUiEvent>();
  Stream<HomeUiEvent> get eventStream => _eventController.stream;

  HomeViewModel(this.getPhotosUseCase);

  Future<void> fetch(String query) async {
    _state = state.copy(isLoading: true);
    notifyListeners();
    final Result<List<Photo>> result = await getPhotosUseCase.execute(query);

    if (result is Success<List<Photo>>) {
      _state = state.copy(photos: result.data);
    } else if (result is Error<List<Photo>>) {
      print(result.message);
      _eventController.add(HomeUiEvent.showSnackBar(result.message));
    }
    _state = state.copy(isLoading: false);
    notifyListeners();
  }
}
