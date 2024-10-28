import 'dart:async';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';
import 'package:nomo_app/features/address/data/models/address.model.dart';
import 'package:nomo_app/features/address/domain/usecase/address.usecase.dart';

class AddAddressCubit extends BaseCubit<AddressModel?> {
  AddAddressCubit(super.context, {required this.addressUsecase});

  final AddressUsecase addressUsecase;
  // final String? addId;
  AddressModel? address = AddressModel();
  String? addressType;

  addAddress() async {
    final result = await addressUsecase.addAddresss(address ?? AddressModel());
    address = result;

    emit(BaseCompletedState(data: data));
  }

  void updateAddressType(String addressDataType) {
    addressType = addressDataType;
    if (addressDataType != "Other") {
      address = address?.copyWith(name: addressDataType);
    }
    emit(BaseCompletedState(data: data));
  }

  @override
  AddressModel? get data => address;

  @override
  FutureOr<void> init() async {
    // if (state is! BaseLoadingState) emit(const BaseLoadingState());
    // await _fetchAddresses();

    if (!isDisposed) {
      emit(BaseCompletedState(data: data));
    }
  }
}
