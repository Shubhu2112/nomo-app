import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nomo_app/core/data/extensions/assets.extensions.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/features/product/product_details/presentation/widgets/product_price.widget.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';
import 'package:nomo_app/features/product/product_list/presentation/widgets/add_to_cart_button.widget.dart';

class ProductCartCard extends StatelessWidget {
  final ProductModel? productModel;

  const ProductCartCard({
    super.key,
    this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 5,
            child: Row(
              children: [
                if (productModel?.image != null)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Image.network(
                      productModel!.image!,
                      fit: BoxFit.fill,
                      height: 44,
                      width: 40,
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: SvgPicture.asset(
                      "apple".svg,
                      fit: BoxFit.fill,
                    ),
                  ),
                const SizedBox(width: 6),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(productModel?.name ?? "")
                            .db()
                            .maxLines(2)
                            .height(1.1).overflow(TextOverflow.ellipsis),
                        const SizedBox(height: 4),
                        CustomText(productModel?.unit ?? "").lm(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                AddToCartButtonWidget(
                  productModel: productModel,
                  quantitySelectorHeight: 26,
                ),
                const SizedBox(height: 4),
                ProductPriceWidget(
                  maxRetailPrice: productModel?.maxRetailPrice,
                  sellingPrice: productModel?.sellingPrice ?? 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
