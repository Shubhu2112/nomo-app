import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';

class NonInjectableBaseWidget<T extends BaseCubit<E>, E> extends StatelessWidget {
  final Widget Function(BuildContext context, BaseCompletedState<E> state)
      builder;
  final Function(BuildContext context, BaseState state) listener;
  final Widget Function(BuildContext context, BaseErrorState state)?
      errorBuilder;
  final Widget Function(BuildContext context, BaseState state)? loadingBuilder;

  const NonInjectableBaseWidget({
    super.key,
    required this.builder,
    required this.listener,
    this.errorBuilder,
    this.loadingBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<T, BaseState>(
      listener: listener,
      builder: (context, state) {
        if (state is BaseCompletedState) {
          return builder(context, state as BaseCompletedState<E>);
        } else if (state is BaseErrorState) {
          return errorBuilder != null
              ? errorBuilder!(context, state)
              : Center(
                  child: Text(
                  state.errorMessage ?? "Something went wrong.",
                ));
        } else if ((state is BaseLoadingState &&
                context.read<T>().isLoading) ||
            state is BaseInitialState) {
          return loadingBuilder != null
              ? loadingBuilder!(context, state)
              : const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
