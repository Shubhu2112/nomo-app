import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_button.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_carousel.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/features/cart/presentation/view/cart.view.dart';
import 'package:nomo_app/features/cart/presentation/widgets/go_to_cart_bottom_bar.widget.dart';
import 'package:nomo_app/features/product/product_details/presentation/widgets/product_options_bottom_sheet.widget.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';
import 'package:nomo_app/features/product/product_list/presentation/widgets/add_to_cart_button.widget.dart';

class ProductDetailsView extends StatelessWidget {
  static String routeName = "/product_details_view";

  const ProductDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Fetching ProductModel from route arguments
    final productModel =
        ModalRoute.of(context)!.settings.arguments as ProductModel;

    return Scaffold(
      bottomNavigationBar: const GoToCartBottomWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCarousel(
                  items: List.generate(
                    3,
                    (index) {
                      return Image.network(
                        productModel.image!, // Use the image from ProductModel
                        fit: BoxFit.fill,
                        height: double.infinity,
                        width: double.infinity,
                      );
                    },
                  ),
                  itemIndicatorPadding: 6,
                ),
                CustomText(productModel.name ?? "").hm().bold(),
                // CustomText(productModel.productOptionValueName ?? "").lm(),
                CustomText(productModel.unit ??
                        productModel.productOptionsValues?.first.name ??
                        "")
                    .lm(),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          (productModel.sellingPrice ??
                                      productModel.productOptionsValues?.first
                                          .sellingPrice)
                                  ?.toString() ??
                              "",
                          showCurrencySymbol: true,
                        ).hm().bold(),
                        const SizedBox(
                          width: 6,
                        ),
                        CustomText(
                          (productModel.maxRetailPrice ??
                                      productModel.productOptionsValues?.first
                                          .maxRetailPrice)
                                  ?.toString() ??
                              "",
                          showCurrencySymbol: true,
                        ).decoration(TextDecoration.lineThrough).ls(),
                      ],
                    ),
                    AddToCartButtonWidget(
                      productModel: productModel,
                      isDetails: true,
                    ),

                    // CustomPrimaryButton(
                    //   width: 135,
                    //   onPress: () {
                    //     if (productModel.productOptions?.isNotEmpty ?? false) {
                    //       ProductOptionsBottomSheet.bottomSheetMenu(context,
                    //           product: productModel);
                    //     }
                    //   },
                    //   textValue: Row(
                    //     mainAxisAlignment: (productModel.productOptions?.isNotEmpty ?? false)? MainAxisAlignment.spaceBetween:MainAxisAlignment.center,
                    //     children: [
                    //       // "${productModel.productOptionName}"
                    //       CustomText("ADD").lm().textColor(
                    //           Theme.of(context).colorScheme.onPrimary),
                    //       // const SizedBox(
                    //       //   width: 2,
                    //       // ),
                    //       if(productModel.productOptions?.isNotEmpty ?? false)
                    //       const Icon(
                    //         Icons.keyboard_arrow_down,
                    //         color: Colors.white,
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
                const Divider(),
                CustomText("Product Detail").db().bold(),
                CustomText(productModel.description ?? "").ls(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
