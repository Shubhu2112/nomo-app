import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:nomo_app/core/data/extensions/assets.extensions.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';
import 'package:nomo_app/core/presentation/dialogs/common_dialogs.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/features/authentication/data/models/user.model.dart';
import 'package:nomo_app/features/authentication/domain/usecase/auth.usecase.dart';
import 'package:nomo_app/features/authentication/presentation/widget/username_bottomsheet.widget.dart';
import 'package:nomo_app/features/dashboard/presentation/view/dashboard.view.dart';

class AuthCubit extends BaseCubit<(UserModel?, bool?)> {
  AuthCubit(super.context, {required this.authUsecase});

  final AuthUsecase authUsecase;
  bool? isSentOtpSuccess;
  UserModel? userModel;
  String? contactNumber;
  int? otpStatusCode;

  sendOtp(String? contactNum) async {
    contactNumber = contactNum;
    DialogBox.loadingDialog(
      context!,
      Lottie.asset("groceries_loading".anm, fit: BoxFit.scaleDown, height: 100),
    );
    final result = await authUsecase.sendOtp(contactNum);
    isSentOtpSuccess = result;
    Navigator.pop(context!);
    emit(BaseCompletedState(data: data));
  }

  verifyOtp(String? otp) async {
    DialogBox.loadingDialog(
      context!,
      Lottie.asset("groceries_loading".anm, fit: BoxFit.scaleDown, height: 100),
    );
    final result = await authUsecase.verifyOtp(contactNumber, otp);
    userModel = result?.data;
    otpStatusCode = result?.statusCode;
    Navigator.pop(context!);
    if (((otpStatusCode ?? 404) == 202) || (otpStatusCode ?? 404) == 201) {
      if (context?.mounted ?? false) {
        UsernameBottomSheet.show(
          context!,
          (value) async {
            await updateName(value);
            if (userModel != null) {
              if (context?.mounted ?? false) {
                NavigationService.popUntilAndPush(
                    context!, DashboardView.routeName,
                    arg: userModel);
              }
            }
          },
        );
      }
    } else if ((otpStatusCode ?? 404) == 200) {
      if (context?.mounted ?? false) {
        NavigationService.popUntilAndPush(context!, DashboardView.routeName,
            arg: userModel);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 10,
          textColor: Colors.white,
          backgroundColor: Colors.red,
          fontSize: 16.0);
    }
  }

  updateName(String? name) async {
    DialogBox.loadingDialog(
      context!,
      Lottie.asset("groceries_loading".anm, fit: BoxFit.scaleDown, height: 100),
    );
    final result = await authUsecase.updateName(contactNumber, name);
    userModel = result;
    Navigator.pop(context!);
    emit(BaseCompletedState(data: data));
  }

  @override
  (UserModel?, bool?)? get data => (userModel, isSentOtpSuccess);

  @override
  FutureOr<void> init() async {
    if (state is! BaseLoadingState) emit(const BaseLoadingState());
    // await _fetchCategories();
    // await _fetchBestSellingProducts();
    if (!isDisposed) {
      emit(BaseCompletedState(data: data));
    }
  }
}
