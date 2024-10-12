import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nomo_app/core/data/extensions/assets.extensions.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_button.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_carousel.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/features/cart/presentation/view/cart.view.dart';
import 'package:nomo_app/features/product/product_details/presentation/widgets/product_options_bottom_sheet.widget.dart';

class ProductDetailsView extends StatelessWidget {
  static String routeName = "/product_details_view";
  final double? maxRetailPrice;
  final double? sellingPrice;
  final String? productName;
  final String? productOptionName;
  final String? productOptionValueName;
  final String? productImg;
  final String? productDescription;
  const ProductDetailsView({
    super.key,
    this.maxRetailPrice = 90,
    this.productName = "Apple",
    this.productOptionName = "Select Unit",
    this.productOptionValueName = "1Kg",
    this.sellingPrice = 42,
    this.productImg,
    this.productDescription =
        "Apples are nutritious. Apples may be good for weight loss. apples may be good for your heart. As part of a healtful and varied diet.",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText("1 Item | Rs120 ").db(),
                    CustomText("Rs 29 saved,  Enjoy Free delivery!")
                        .fontSize(12)
                        .textColor(Colors.green),
                    const SizedBox(
                      width: 4,
                    ),
                  ],
                ),
                CustomPrimaryButton(
                  width: 130,
                  textValue: CustomText("Go to Cart")
                      .lm()
                      .textColor(Theme.of(context).colorScheme.onPrimary),
                  onPress: () {
                    NavigationService.goNext(context, CartView.routeName);
                  },
                )
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCarousel(
                  items: List.generate(
                    3,
                    (index) {
                      return SvgPicture.asset(
                        "apple".svg,
                        fit: BoxFit.fill,
                        height: double.infinity,
                        width: double.infinity,
                      );
                    },
                  ),
                  itemIndicatorPadding: 6,
                ),
                CustomText(productName ?? "").hm().bold(),
                CustomText(productOptionValueName ?? "").lm(),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    Row(
                      children: [
                        CustomText("₹$sellingPrice").hm().bold(),
                        const SizedBox(
                          width: 6,
                        ),
                        CustomText("₹$maxRetailPrice")
                            .decoration(TextDecoration.lineThrough)
                            .ls(),
                      ],
                    ),
                    //     InkWell(
                    //       onTap: () {
                    //         _modalBottomSheetMenu(context);
                    //       },
                    //       child: Row(
                    //         children: [
                    //           CustomText("View 4 options ").lm(),
                    //           const Icon(Icons.keyboard_arrow_down)
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    CustomPrimaryButton(
                      width: 135,
                      onPress: () {
                        ProductOptionsBottomSheet.bottomSheetMenu(context);
                      },
                      textValue: Row(
                        children: [
                          CustomText("3 options").lm().textColor(
                              Theme.of(context).colorScheme.onPrimary),
                          const SizedBox(
                            width: 2,
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(),
                CustomText("Product Detail").db().bold(),
                CustomText(productDescription ?? "").ls()
              ],
            ),
          ),
        ));
  }
}
