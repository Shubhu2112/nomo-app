import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';

class BlocManager {
  final List<BaseCubit> _blocs = [];

  void register(BaseCubit bloc) {
    _blocs.add(bloc);
  }

  void disposeAll({bool forceDispose = false}) {
    for (final bloc in _blocs) {
      if (forceDispose || bloc.state is BaseInitialState) {
        bloc.close();
      } else {
        debugPrint("Skipping Bloc disposal: $bloc (Active state: ${bloc.state})");
      }
    }
    _blocs.clear();
  }

   Future<void> logout() async {
    for (final bloc in _blocs) {
      if (!bloc.isDisposed) {
        await bloc.logout(); // Call the logout method of each BaseCubit
      }
    }
  }
}


final blocManager = BlocManager(); // Singleton instance
