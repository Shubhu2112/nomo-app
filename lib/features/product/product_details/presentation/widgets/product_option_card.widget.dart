import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nomo_app/core/data/extensions/assets.extensions.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/features/product/product_details/presentation/widgets/product_price.widget.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';
import 'package:nomo_app/features/product/product_list/data/models/product_option_value.model.dart';
import 'package:nomo_app/features/product/product_list/presentation/widgets/add_to_cart_button.widget.dart';

class ProductOptionCard extends StatelessWidget {
  final ProductOptionValueModel? productOptionValueModel;
  final ProductModel? productModel;

  const ProductOptionCard({
    super.key,
    this.productOptionValueModel,
    this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (productOptionValueModel?.image != null)
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Image.network(
                    productOptionValueModel!.image!,
                    fit: BoxFit.fill,
                    height: 40,
                    width: 40,
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    "apple".svg,
                    fit: BoxFit.fill,
                  ),
                ),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(productOptionValueModel?.name ?? "").lm(),
                ],
              ),
            ],
          ),
          ProductPriceWidget(
            maxRetailPrice: productOptionValueModel?.maxRetailPrice,
            sellingPrice: productOptionValueModel?.sellingPrice ?? 0,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: AddToCartButtonWidget(
              productModel: productModel,
              productOptionValueModel: productOptionValueModel,
            ),
          ),
        ],
      ),
    );
  }
}
