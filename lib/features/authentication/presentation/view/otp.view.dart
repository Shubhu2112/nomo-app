import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nomo_app/core/data/extensions/assets.extensions.dart';
import 'package:nomo_app/core/presentation/views/injectable_base.view.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_textfield.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/core/services/network_services/dio_http_impl.service.dart';
import 'package:nomo_app/features/authentication/data/models/user.model.dart';
import 'package:nomo_app/features/authentication/data/repository/auth_impl.repository.dart';
import 'package:nomo_app/features/authentication/data/sources/auth_impl.source.dart';
import 'package:nomo_app/features/authentication/domain/usecase/auth.usecase.dart';
import 'package:nomo_app/features/authentication/presentation/cubit/auth.cubit.dart';
import 'package:nomo_app/features/authentication/presentation/widget/username_bottomsheet.widget.dart';
import 'package:nomo_app/features/dashboard/presentation/view/dashboard.view.dart';

import 'package:pinput/pinput.dart';

class OtpView extends StatelessWidget {
  static String routeName = "/otp_view";

  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return InjectableBaseView<AuthCubit, (UserModel?, bool?)>(
      bottomSafeArea: false,
      builder: (context, state) {
        return OtpViewContent(
          data: state.data,
        );
      },
      listener: (context, state) => print(state),
      cubitBuilder: (BuildContext context) => AuthCubit(
        context,
        authUsecase: AuthUsecase(
            repository: AuthImplRepository(
                dataSource: AuthImplDataSource(httpService: ApiRestService()))),
      ),
    );
  }
}

class OtpViewContent extends StatelessWidget {
  final (UserModel?, bool?)? data;
  OtpViewContent({super.key, this.data});

  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode otpFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    if (!isKeyboardVisible) {
      if (_scrollController.positions.isNotEmpty) {
        _scrollController.animateTo(
          0, // Target scroll position
          duration:
              const Duration(milliseconds: 100), // Duration in milliseconds
          curve: Curves.easeInOut, // Curve of the animation
        );
      }
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            "otp_background_logo".png,
            fit: BoxFit.fitWidth,
            width: double.infinity,
          ),
        ),
        SafeArea(
            child: SingleChildScrollView(
          controller: _scrollController,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                // CustomText("NOMO")
                //     .dlt()
                //     .textColor(Theme.of(context).colorScheme.surface),
                const SizedBox(
                  height: 136,
                ),
                CustomText("LOGIN").dmt(),
                const SizedBox(
                  height: 48,
                ),
                CustomTextField(
                    hintText: "Phone Number",
                    focusNode: phoneNumberFocusNode,
                    textInputType: const TextInputType.numberWithOptions(signed: true),
                    isRequired: true,
                    onPress: () {
                      _scrollController.animateTo(
                        100, // Target scroll position
                        duration: const Duration(
                            milliseconds: 200), // Duration in milliseconds
                        curve: Curves.easeInOut, // Curve of the animation
                      );
                    },
                    onFieldSubmitted: (value) async {
                      if (value.length == 10) {
                        await cubit.sendOtp(value);
                        phoneNumberFocusNode.unfocus();
                        otpFocusNode.requestFocus();
                      } else {
                        print("Phone number must be 10 digits.");
                      }
                    },
                    onChanged: (value) async {
                      // Automatically trigger sendOtp when the phone number reaches 10 digits
                      if (value.length == 10) {
                        await cubit.sendOtp(value);
                        phoneNumberFocusNode.unfocus();
                         otpFocusNode.requestFocus();
                      }
                    }),
                const SizedBox(
                  height: 36,
                ),
                Pinput(
                  length: 4,
                  enabled: cubit.isSentOtpSuccess ?? false,
                  focusNode: otpFocusNode,
                  onTap: () {
                    _scrollController.animateTo(
                      100, // Target scroll position
                      duration: const Duration(
                          milliseconds: 200), // Duration in milliseconds
                      curve: Curves.easeInOut, // Curve of the animation
                    );
                  },
                  onCompleted: (value) async {
                    await cubit.verifyOtp(value);
                  },
                  scrollPadding: EdgeInsets.zero,
                  defaultPinTheme: PinTheme(
                    margin: const EdgeInsets.all(6),
                    width: 60, // Adjust size as per your requirement
                    height: 60,
                    textStyle: const TextStyle(
                      fontSize: 24, // You can adjust font size here
                      color: Colors.black, // Define text color
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.2), // Soft shadow color
                          spreadRadius: 2, // Shadow spread
                          blurRadius: 10, // Blur for shadow softness
                          offset: const Offset(0, 4), // Shadow position
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 200,
                )
              ],
            ),
          ),
        ))
      ]),
    );
  }
}
