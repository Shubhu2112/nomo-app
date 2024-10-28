import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';

// BaseSelector that works with BaseCompletedState by default using BlocSelector
class BaseCompletedSelector<TCubit extends Cubit<BaseState<ET>>, ET,T > extends StatelessWidget {
  // Selector function to extract the data from BaseCompletedState
  final T Function(TCubit) selector;
  // Builder function to build the UI based on the selected data
  final Widget Function(BuildContext context, T selectedData) builder;

  const BaseCompletedSelector({
    super.key,
    required this.selector,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TCubit, BaseState<ET>, T?>(
      selector: (state) {
        // Only select the data if the state is BaseCompletedState
        if (state is BaseUpdateState<ET> || state is BaseCompletedState<ET>  ) {
          return selector(context.read<TCubit>());
        }
        return null;
      },
      builder: (context, selectedData) {
        if (selectedData != null) {
          // If data is present, pass it to the builder
          return builder(context, selectedData);
        } else {
          // Return an empty widget or any placeholder if there's no completed data
          return const SizedBox.shrink();
        }
      },
    );
  }
}
