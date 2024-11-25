abstract class BaseState<T> {
  const BaseState();
}

class BaseInitialState<T> extends BaseState<T> {
  final String? initMessage;
  const BaseInitialState({this.initMessage});
}

class BaseLoginState<T> extends BaseState<T> {
  final String? initMessage;
  const BaseLoginState({this.initMessage});
}

class BaseLoadingState<T> extends BaseState<T> {
  const BaseLoadingState();
}

class BaseCompletedState<T> extends BaseState<T> {
  final T? data;
  BaseCompletedState({this.data});
}

class BaseUpdateState<T> extends BaseState<T> {
  final T? data;
  BaseUpdateState({this.data});
}

class BaseErrorState<T> extends BaseState<T> {
  final String? errorMessage;
  BaseErrorState({this.errorMessage});
}
