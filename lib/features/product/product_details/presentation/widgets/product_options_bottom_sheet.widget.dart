import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_button.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/features/product/product_details/presentation/widgets/product_option_card.widget.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';

class ProductOptionsBottomSheet {
  static void bottomSheetMenu(
    BuildContext context, {
    ProductModel? product,
  }) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 400.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(product?.name ?? "").db(),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: product?.productOptionsValues?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Card(
                                child: ProductOptionCard(
                                  productOptionValueModel:
                                      product?.productOptionsValues?[index],
                                      productModel: product,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: CustomPrimaryButton(
                          onPress: () {
                            Navigator.pop(context);
                          },
                          isExpanded: true,
                          textValue: CustomText("Confirm").lm().textColor(
                              Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                    ],
                  ),
                )),
          );
        });
  }
}
