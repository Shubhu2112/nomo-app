import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';

class NonInjectableBaseView<T extends BaseCubit<E>, E> extends StatelessWidget {
  final Widget Function(BuildContext context, BaseCompletedState<E> state)
      builder;
  final Function(BuildContext context, BaseState state) listener;
  final Widget Function(BuildContext context, BaseErrorState state)?
      errorBuilder;
      final Widget Function(BuildContext context,  BaseInitialState state)?
      initBuilder;
  final Widget Function(BuildContext context, BaseState state)? loadingbuilder;

  // Scaffold properties
  final PreferredSizeWidget? appBar;
  final FloatingActionButton? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final bool bottomSafeArea;
  final bool extendBody;
  final bool extendBodyBehindAppBar;

  const NonInjectableBaseView(
      {super.key,
      required this.builder,
      required this.listener,
      this.errorBuilder,
      this.initBuilder,
      this.loadingbuilder,
      this.appBar,
      this.floatingActionButton,
      this.bottomNavigationBar,
      this.drawer,
      this.bottomSafeArea = true,
      this.extendBody = false,
      this.extendBodyBehindAppBar = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: bottomSafeArea,
      child: BlocConsumer<T, BaseState>(
        listener: listener,
        builder: (context, state) {
          return Scaffold(
            appBar: appBar,
            extendBody: extendBody,
            extendBodyBehindAppBar: extendBodyBehindAppBar,
            floatingActionButton: floatingActionButton,
            bottomNavigationBar: bottomNavigationBar,
            drawer: drawer,
            body: Stack(
              children: [
                //  if (state is BaseInitialState)
                //   initBuilder != null
                //       ? initBuilder!(context, state)
                //       : Center(
                //           child: Text(
                //           state.initMessage ?? "init...",
                //           textAlign: TextAlign.center,
                //         )),
                if (state is BaseCompletedState)
                  builder(context, state as BaseCompletedState<E>),
                if (state is BaseErrorState)
                  errorBuilder != null
                      ? errorBuilder!(context, state)
                      : Center(
                          child: Text(
                          state.errorMessage ?? "Something went wrong.",
                          textAlign: TextAlign.center,
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
    );
  }
}
