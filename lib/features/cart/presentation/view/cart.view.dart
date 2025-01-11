import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:nomo_app/core/data/extensions/assets.extensions.dart';
import 'package:nomo_app/core/presentation/dialogs/common_dialogs.dart';
import 'package:nomo_app/core/presentation/views/non_injectable_base.widget.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_bottom_appbar.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_button.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/presentation/widgets/common/shared_ui.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/features/address/data/models/address.model.dart';
import 'package:nomo_app/features/address/presentation/cubit/address_list.cubit.dart';
import 'package:nomo_app/features/address/presentation/view/add_address.view.dart';
import 'package:nomo_app/features/address/presentation/view/address_list.view.dart';
import 'package:nomo_app/features/cart/data/models/cart_item.model.dart';
import 'package:nomo_app/features/cart/domain/cart.usecase.dart';
import 'package:nomo_app/features/cart/presentation/cubit/cart.cubit.dart';
import 'package:nomo_app/features/cart/presentation/cubit/state/cart.state.dart';
import 'package:nomo_app/features/cart/presentation/widgets/bill_summary_card.widget.dart';
import 'package:nomo_app/features/cart/presentation/widgets/bill_summary_item.widget.dart';
import 'package:nomo_app/features/cart/presentation/widgets/cart_shimmer.dart';
import 'package:nomo_app/features/cart/presentation/widgets/gradient_offer_card.widget.dart';
import 'package:nomo_app/features/cart/presentation/widgets/product_cart_card.widget.dart';
import 'package:nomo_app/features/cart/presentation/widgets/product_options_cart_card.widget.dart';
import 'package:nomo_app/features/dashboard/presentation/cubit/home.cubit.dart';
import 'package:nomo_app/features/dashboard/presentation/view/dashboard.view.dart';
import 'package:nomo_app/features/order/presentation/views/order_status.view.dart';
import 'package:nomo_app/features/order/presentation/widgets/order_success.widget.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';
import 'package:nomo_app/features/product/product_list/data/models/product_option_value.model.dart';

class CartView extends StatelessWidget {
  static String routeName = "/cart_view";
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return NonInjectableBaseWidget<CartCubit, CartState>(
      resetStateOnPop: true,
      builder: (context, state) {
        if (state is EmptyCartState) {
          return Scaffold(
            appBar: const CustomBottomAppbar(
              title: "Your Cart",
            ),
            body: Center(
              child: CustomText(state.message ?? "").db(),
            ),
          );
        }
        return CartContent(
          cartState: state.data,
        );
      },
      listener: (context, state) {
        if (state is OrderPlaceState) {
          SharedUi.showCustomDialog(context, child: const OrderSuccessWidget());
          Future.delayed(
            const Duration(milliseconds: 1400),
            () {
              if (context.mounted) {
                NavigationService.goNext(context, OrderStatusView.routeName,
                    arg: state.data?.orderModel);
              }
            },
          );
        }
      },
      loadingBuilder: (context, state) {
        return const CartShimmer();
      },
      init: (cubit) {
        cubit.checkout();
      },
    );
  }
}

class CartContent extends StatelessWidget {
  static String routeName = "/cart_view";

  final CartState? cartState;

  const CartContent({super.key, this.cartState});

  @override
  Widget build(BuildContext context) {
    ({
      double maxRetailPriceTotal,
      double priceTotal,
      double totalSavings
    }) cartAmount = CartUsecase.calculateCartTotal(cartState?.cartItems ?? []);

    AddressModel? selectedAddressModel =
        context.watch<AddressListCubit>().selectedAddress;

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomPrimaryButton(
          width: double.infinity,
          textValue: CustomText(selectedAddressModel == null
                  ? "Add Address to Proceed"
                  : "Click to Pay (₹ ${cartAmount.priceTotal})  >")
              .lb()
              .textColor(Theme.of(context).colorScheme.surface),
          onPress: () {
            if (selectedAddressModel == null) {
              NavigationService.goNext(context, AddAddressView.routeName);
            } else {
              DialogBox.loadingDialog(
                context,
                Lottie.asset("groceries_loading".anm,
                    fit: BoxFit.cover, height: 248),
              );
              context
                  .read<CartCubit>()
                  .placeOrder(selectedAddressModel.id ?? 0);
            }
          },
        ),
      ),
      appBar: CustomBottomAppbar(
        title: "Your Cart",
        bottomWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
          child: Row(
            children: [
              const Icon(Icons.near_me, size: 36),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                            "Ordering for ${context.read<HomeCubit>().userModel?.name ?? ""}")
                        .db()
                        .bold(),
                    if (selectedAddressModel?.streetName1 != null)
                      InkWell(
                        onTap: () {
                          NavigationService.goNext(
                              context, AddressListView.routeName,
                              arg: {"isCart": true});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(1.6),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomText(
                                  "${selectedAddressModel?.streetName1 ?? ""},${selectedAddressModel?.streetName2 ?? ""}, ${selectedAddressModel?.pincode ?? ""}",
                                )
                                    .lm()
                                    .overflow(TextOverflow.ellipsis)
                                    .maxLines(1),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const GradientCard(),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: CustomText("Review items").db().bold(),
              ),
              Card(
                color: const Color(0xffF4E2E4),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Row for Delivery and item count
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText("Delivery in 8 Mins")
                                .db()
                                .textColor(Colors.green),
                            Row(
                              children: [
                                Image.asset("grocery_delivery".png),
                                CustomText(
                                        "${cartState?.cartItems.length} items")
                                    .lm(),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // ListView or equivalent for product cards
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap:
                            true, // Allows ListView to shrink to the height of its content
                        physics:
                            const NeverScrollableScrollPhysics(), // Prevents it from scrolling separately
                        itemCount:
                            cartState?.cartItems.length, // Number of items
                        itemBuilder: (context, index) {
                          CartItemModel? cartItemModel =
                              cartState?.cartItems[index];

                          if (cartItemModel?.productOptionValueId == null) {
                            return ProductCartCard(
                              productModel: cartItemModel?.product,
                              // productModel: ProductModel(
                              //     id: cartItemModel?.productId,
                              //     maxRetailPrice: cartItemModel?.maxRetailPrice,
                              //     sellingPrice: cartItemModel?.price,
                              //     image: cartItemModel?.image,
                              //     name: cartItemModel?.name,
                              //     unit: cartItemModel?.unit),
                            );
                          } else {
                            return ProductOptionCartCard(
                              productModel: cartItemModel?.product,
                              productOptionValueModel:
                                  cartItemModel?.productOptionValue,
                              // productModel: ProductModel(
                              //     id: cartItemModel?.productId,
                              //     maxRetailPrice: cartItemModel?.maxRetailPrice,
                              //     sellingPrice: cartItemModel?.price,
                              //     image: cartItemModel?.image,
                              //     name: cartItemModel?.name,
                              //     unit: cartItemModel?.unit),
                              // productOptionValueModel: ProductOptionValueModel(
                              //     id: cartItemModel?.productOptionValueId,
                              //     maxRetailPrice: cartItemModel?.maxRetailPrice,
                              //     sellingPrice: cartItemModel?.price,
                              //     productsId: cartItemModel?.productId,
                              //     image: cartItemModel?.image,
                              //     name: cartItemModel?.name,
                              //     unit: cartItemModel?.unit),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              InkWell(
                onTap: () {
                  NavigationService.goNextFinishAll(
                      context, DashboardView.routeName);
                  // if (NavigationService.canGoBack()) {
                  //   NavigationService.goBack(context);
                  // }
                },
                child: Card(
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText("Missed Something? ").ds().bold(),
                        CustomText("Add More items")
                            .ds()
                            .textColor(Theme.of(context).primaryColor)
                            .bold()
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              BillSummaryCardWidget(
                maxRetailPriceTotal: cartAmount.maxRetailPriceTotal,
                totalSavings: cartAmount.totalSavings,
                total: cartAmount.priceTotal,
              ),
              const SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: CustomText("Review your order to avoid cancellations")
                    .dm()
                    .bold(),
              ),
              Card(
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                              "NOTE: Orders cannot be canceled and are non-refundable once packed for delivery.")
                          .ds(),
                      CustomText("Read Cancellation Policy")
                          .ds()
                          .textColor(Theme.of(context).primaryColor)
                          .decoration(TextDecoration.underline)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                  height: kToolbarHeight - 50), // Add space at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
