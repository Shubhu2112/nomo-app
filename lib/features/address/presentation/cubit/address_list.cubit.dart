import 'dart:async';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';
import 'package:nomo_app/features/address/data/models/address.model.dart';
import 'package:nomo_app/features/address/domain/usecase/address.usecase.dart';

class AddressListCubit extends BaseCubit<List<AddressModel>?> {
  AddressListCubit(super.context, {required this.addressUsecase});

  final AddressUsecase addressUsecase;
  // final String? addId;
  AddressModel? selectedAddress;
  List<AddressModel>? addresses;

  _fetchAddresses() async {
    // Params params = Params();
    // params.andFilters.add(Filter(field: "categoryId", values: [categoryId!]));
    // params.andFilters.add(Filter(field: "enabled", values: ["true"]));
    final result = await addressUsecase.getAddressses(null);
    addresses = result;
    if (addresses?.isNotEmpty ?? false) {
      addresses!.first = addresses!.first.copyWith(isSelected: true);
      selectedAddress = addresses!.first;
    }
    emit(BaseCompletedState(data: data));
    // if (selectedAddress != null) {
    //   context!
    //       .read<ProductListCubit>()
    //       .fetchProducts(selectedSubcategory!.id!.toString());
    // }
  }

  void updateSubCategorySelection(int index) {
    // Deselect all categories
    addresses = addresses?.map((subCategory) {
      return subCategory.copyWith(isSelected: false);
    }).toList();

    // Select the tapped category
    if (addresses != null && index >= 0 && index < addresses!.length) {
      addresses![index] = addresses![index].copyWith(isSelected: true);
      selectedAddress = addresses![index];
    }

    // Emit a new state to trigger a rebuild
    emit(BaseCompletedState(data: data));
    // if (selectedSubcategory != null) {
    //   context!
    //       .read<ProductListCubit>()
    //       .fetchProducts(selectedSubcategory!.id!.toString());
    // }
  }

  updateSelectedAddress(AddressModel? address) {
    selectedAddress = address;
    emit(BaseCompletedState(data: data));
  }
@override
  FutureOr<void> clearData() {
    addresses = null;
    selectedAddress = null;
  }


  @override
  List<AddressModel>? get data => addresses;

  @override
  FutureOr<void> init() async {
    if (state is! BaseLoadingState) emit(const BaseLoadingState());
    await _fetchAddresses();

    // if (!isDisposed) {
    //   emit(BaseCompletedState(data: data));
    // }
  }
}
