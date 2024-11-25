import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';
import 'package:nomo_app/features/dashboard/presentation/cubit/home.cubit.dart';
import 'package:nomo_app/features/order/data/models/order.model.dart';
import 'package:nomo_app/features/order/domain/order.usecase.dart';



class OrderListCubit extends BaseCubit<List<OrderModel>?> {
  OrderListCubit(super.context,
      {required this.orderUsecase,});

  final OrderUsecase orderUsecase;

  List<OrderModel>? orders;

  _fetchOrders() async {
  //  String? userId = context?.read<HomeCubit>().userModel?.id;
    Params params = Params();
    // params.andFilters.add(Filter(field: "userId", values: [userId!]));
    // params.andFilters.add(Filter(field: "enabled", values: ["true"]));
    final result = await orderUsecase.getOrders(params);
    orders = result;
    
    emit(BaseCompletedState(data: data));
  
  }

 

  @override
  List<OrderModel>? get data => orders;

  @override
  FutureOr<void> init() async {
    if (state is! BaseLoadingState) emit(const BaseLoadingState());
    await _fetchOrders();

    // if (!isDisposed) {
    //   emit(BaseCompletedState(data: data));
    // }
  }
}
