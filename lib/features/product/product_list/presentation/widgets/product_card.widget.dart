import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomo_app/core/common/widget/common_shimmer_container.widget.dart';
import 'package:nomo_app/core/data/extensions/assets.extensions.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/core/common/utils/price.util.dart';
import 'package:nomo_app/features/cart/data/models/cart_item.model.dart';
import 'package:nomo_app/features/cart/presentation/cubit/cart.cubit.dart';
import 'package:nomo_app/features/product/product_details/presentation/view/product_details.view.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';
import 'package:nomo_app/features/product/product_list/presentation/widgets/add_to_cart_button.widget.dart';

class ProductCard extends StatelessWidget {
  final ProductModel? productModel;
  final bool isSubCategory;
  final Function()? onAddCartTap;

  const ProductCard(
      {super.key,
      this.productModel,
      this.isSubCategory = true,
      this.onAddCartTap});

  @override
  Widget build(BuildContext context) {
    return productModel?.isLoading ?? true
        ?  const CommonShimmerContainer(
            child: Card(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              onTap: () {
                // Navigate to ProductDetailsView with productModel as argument
                NavigationService.goNext(context, ProductDetailsView.routeName,
                    arg: productModel);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    color: Theme.of(context).colorScheme.onSurface),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        fit: StackFit.passthrough,
                        children: [
                          if (productModel?.image != null)
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  productModel!
                                      .image!, // Use image from productModel
                                  alignment: Alignment.center,
                                  height: isSubCategory ? 100 : 116,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          else
                            Center(
                              child: Image.asset(
                                "bell_pepper".png,
                                alignment: Alignment.center,
                                height: 116,
                                fit: BoxFit.contain,
                              ),
                            ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: AddToCartButtonWidget(
                              productModel: productModel,
                            ),
                          )
                        ],
                      ),
                      // Display product image

                      const Spacer(),
                      CustomText(productModel?.name ?? "")
                          .ds()
                          .bold()
                          .maxLines(2)
                          .overflow(TextOverflow.ellipsis),

                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Show maxRetailPrice and discount percentage if available
                                // if (productModel?.maxRetailPrice != null)
                                Row(
                                  children: [
                                    CustomText(
                                      (productModel?.maxRetailPrice ??
                                                  productModel
                                                      ?.productOptionsValues
                                                      ?.first
                                                      .maxRetailPrice)
                                              ?.toString() ??
                                          "",
                                      showCurrencySymbol: true,
                                    )
                                        .decoration(TextDecoration.lineThrough)
                                        .ds()
                                        .fontWeight(FontWeight.w900),
                                    CustomText(
                                            "${PriceUtils.getOfferPercentage(productModel?.maxRetailPrice ?? productModel?.productOptionsValues?.first.maxRetailPrice, productModel?.sellingPrice ?? productModel?.productOptionsValues?.first.sellingPrice)?.toStringAsFixed(2)}%")
                                        .ds()
                                        .fontSize(10)
                                  ],
                                ),
                                // Show selling price and option value
                                CustomText(
                                        "₹${(productModel?.sellingPrice ?? productModel?.productOptionsValues?.first.sellingPrice)?.toString() ?? ""},  ${productModel?.unit ?? productModel?.productOptionsValues?.first.name}")
                                    .dm()
                                    .bold()
                                    .textColor(Theme.of(context).primaryColor),
                              ],
                            ),
                          ),
                          // Add to cart icon
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
