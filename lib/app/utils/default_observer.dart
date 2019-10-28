import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

typedef OnCompleteCallback = Function();
typedef OnErrorCallback = Function(Exception e);
typedef OnNextCallback = Function(dynamic data);

class DefaultObserver<_T> extends Observer<_T> {
  DefaultObserver({ this.completeCallback, this.errorCallback, this.nextCallback });

  OnCompleteCallback completeCallback;
  OnErrorCallback errorCallback;
  OnNextCallback nextCallback;

  @override
  void onComplete() {
    if (completeCallback != null) {
      completeCallback();
    }
  }

  @override
  void onError(dynamic e) {
    if (errorCallback != null) {
      if (e is Exception) {
        errorCallback(e);
      } else {
        onError(Exception(e));
      }
    }
  }

  @override
  void onNext(_T response) {
    if (nextCallback != null) {
      nextCallback(response);
    }
  }
}