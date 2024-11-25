import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';

abstract class BaseCubit<T> extends Cubit<BaseState<T>> {
  final BuildContext? context;

  BaseCubit(this.context) : super( BaseInitialState<T>()) {
    if (state is BaseInitialState) {
      load();
    }
  }

  bool get isLogout => _isLogout;
  bool _isLoading = false;
  bool _isDisposed = false;

  bool _isLogout = false;

  FutureOr<void> _initState;

  FutureOr<void> init();
  FutureOr<void> clearData() async {}

  Future<void> logout() async {
    _isLogout = true;
    await clearData(); // Clear any specific data if necessary
    resetState(); // Reset the state to its initial state
  }

  void load() async {
    _isLogout = false;
    if (context != null && context!.mounted) {
      if (!_isDisposed && state is! BaseLoadingState) {
        isLoading = true;
        _initState = init();
        await _initState;
        if (!_isDisposed) {
          isLoading = false;
        }
      }
    }
  }

  // Getters
  bool get isLoading => _isLoading;
  bool get isDisposed => _isDisposed;

  T? get data;

  // Setters
  set isLoading(bool value) {
    _isLoading = value;
    if (!_isDisposed && _isLoading) emit(BaseLoadingState<T>());
  }

  resetState() {
    _isDisposed = true;
    emit(BaseInitialState<T>());
  }

  @override
  Future<void> close() async {
    _isDisposed = true;

    clearData();
    resetState();
    super.close();
  }
}
