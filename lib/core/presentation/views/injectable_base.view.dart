import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';

class InjectableBaseView<T extends BaseCubit<E>, E> extends StatelessWidget {
  final T Function(BuildContext context)? cubitBuilder;
  final Widget Function(BuildContext context, BaseCompletedState<E> state)
      builder;
  final Function(BuildContext context, BaseState state) listener;
  final Widget Function(BuildContext context, BaseErrorState state)?
      errorBuilder;
  final Widget Function(BuildContext context, BaseState state)? loadingbuilder;

  // Scaffold properties
  final AppBar? appBar;
  final FloatingActionButton? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final bool bottomSafeArea;

  const InjectableBaseView(
      {super.key,
      required this.cubitBuilder,
      required this.builder,
      required this.listener,
      this.errorBuilder,
      this.loadingbuilder,
      this.appBar,
      this.floatingActionButton,
      this.bottomNavigationBar,
      this.drawer,
      this.bottomSafeArea = true});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: bottomSafeArea,
      child: BlocProvider<T>(
        create: (context) => cubitBuilder!(context),
        child: BlocConsumer<T, BaseState>(
          listener: listener,
          builder: (context, state) {
            return Scaffold(
              appBar: appBar,
              floatingActionButton: floatingActionButton,
              bottomNavigationBar: bottomNavigationBar,
              drawer: drawer,
              body: Stack(
                children: [
                  if (state is BaseCompletedState)
                    builder(context, state as BaseCompletedState<E>),
                  if (state is BaseErrorState)
                    errorBuilder != null
                        ? errorBuilder!(context, state)
                        : Center(
                            child: Text(
                            state.errorMessage ?? "Something went wrong.",
                          )),
                  if ((state is BaseLoadingState &&
                          context.read<T>().isLoading) ||
                      state is BaseInitialState)
                    loadingbuilder != null
                        ? loadingbuilder!(context, state)
                        : const Center(
                            child: CircularProgressIndicator.adaptive()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
