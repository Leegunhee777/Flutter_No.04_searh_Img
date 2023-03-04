abstract class Result<T> {
  //아래의 Success class or Error class 둘중 하나로 생성이 될수있는
  //factory 생성자를 명시해준다.
  //Sealed Class라고한다.

  //아래의 Success Class or Error Class가
  //Result Class 안에서 생성이 되어서 사용되는 형태이다.!!!!!!!!!!

  // Result하고 .찍는게 팩토리의 생성자를 만드는 문법이다.
  factory Result.success(T data) {
    return Success(data);
  }

  factory Result.error(String message) {
    return Error(message);
  }
}

class Success<T> implements Result<T> {
  final T data;

  Success(this.data);
}

class Error<T> implements Result<T> {
  final String message;

  Error(this.message);
}
