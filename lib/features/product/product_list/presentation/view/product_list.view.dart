import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/views/non_injectable_base.view.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';
import 'package:nomo_app/features/product/product_list/presentation/cubit/product_list.cubit.dart';
import 'package:nomo_app/features/product/product_list/presentation/widgets/product_card.widget.dart';

class ProductListView extends StatelessWidget {
  final String? subCategoryId;
  const ProductListView({super.key, this.subCategoryId});

  @override
  Widget build(BuildContext context) {
    return NonInjectableBaseView<ProductListCubit, List<ProductModel>?>(
      // bottomSafeArea: false,
      builder: (context, state) {
        return ProductListContent(
          productList: state.data,
        );
      },
      listener: (context, state) => print(state),
    );
  }
}

class ProductListContent extends StatelessWidget {
  final List<ProductModel>? productList;
  const ProductListContent({super.key, this.productList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6, left: 1),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.64),
        itemCount: productList?.length,
        itemBuilder: (context, index) {
          ProductModel? product = productList?[index];
          return ProductCard(
           productModel: product,
          );
        },
      ),
    );
  }
}
