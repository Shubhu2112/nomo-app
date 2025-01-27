import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';
import 'package:nomo_app/features/dashboard/presentation/cubit/home.cubit.dart';
import 'package:nomo_app/features/order/data/models/order.model.dart';
import 'package:nomo_app/features/order/domain/order.usecase.dart';

class OrderListCubit extends BaseCubit<List<OrderModel>?> {
  OrderListCubit(
    super.context, {
    required this.orderUsecase,
  });

  final OrderUsecase orderUsecase;

  List<OrderModel>? orders = [];
  Params params = Params();
  ScrollController scrollController = ScrollController();
  // bool isLoading = false;

  Future<void> fetchOrders({bool isInit = true}) async {
    if (isInit) {
      _initializeFetch();
    } else {
      _addShimmerLoading();
      params.page++;
    }

    try {
      final result = await orderUsecase.getOrders(params);

      if (isInit) {
        orders = result;
        isLoading = false;
      } else {
        orders?.addAll(result ?? []);
        _removeShimmerLoading();
      }

      emit(BaseCompletedState(data: data));
    } catch (e) {
      emit(BaseErrorState(errorMessage: "Failed to fetch orders: $e"));
    }
  }

  void _initializeFetch() {
    isLoading = true;
    emit(const BaseLoadingState());
    orders = [];
    params = Params();
    // params.limit = 4;
    final userId = _getUserId();
    if (userId != null) {
      params.andFilters.add(Filter(field: "userId", values: [userId]));
    }
  }

  void _addShimmerLoading() {
    final shimmerOrder = OrderModel(isLoading: true);
    for (int i = 0; i < 10; i++) {
      orders?.add(shimmerOrder);
    }
    emit(BaseCompletedState(data: data));
  }

  void _removeShimmerLoading() {
    orders?.removeWhere((order) => order.isLoading);
  }

  String? _getUserId() {
    return context?.read<HomeCubit>().userModel?.id;
  }

  @override
  List<OrderModel>? get data => orders;

  @override
  FutureOr<void> init() async {
    emit(const BaseInitialState());

    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // if (!isLoading) {
        await fetchOrders(isInit: false);
        // }
      }
    });

    await fetchOrders();
  }
}
