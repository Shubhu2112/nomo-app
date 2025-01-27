import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomo_app/core/common/widget/common_shimmer_container.widget.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/views/non_injectable_base.view.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_search_bar.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/features/cart/presentation/widgets/go_to_cart_bottom_bar.widget.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';
import 'package:nomo_app/features/product/product_list/presentation/cubit/product_list.cubit.dart';
import 'package:nomo_app/features/product/product_list/presentation/widgets/product_card.widget.dart';
import 'package:nomo_app/features/product/product_search/presentation/cubit/product_search.cubit.dart';

class ProductSearchView extends StatelessWidget {
  static String routeName = "/product_search_view";
  final String? subCategoryId;
  const ProductSearchView({super.key, this.subCategoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: const GoToCartBottomWidget(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: CustomSearchBar(
                autofocus: true,
                enableDebounce: true,
                onSearch: (search) {
                  if (search.length > 1) {
                    context.read<ProductSearchCubit>().searchProducts(search);
                  }
                },
              ),
            ),
            Expanded(
              child: NonInjectableBaseView<ProductSearchCubit,
                  List<ProductModel>?>(
                // bottomSafeArea: false,
                builder: (context, state) {
                  return ProductSearchContent(
                    productList: state.data,
                  );
                },
                initBuilder: (context, state) {
                  return Center(
                    child: CustomText("Search wide variety of products").dm(),
                  );
                },
                loadingbuilder: (context, state) {
                  return Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.8),
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: CommonShimmerContainer(
                            child: Card(
                              child: SizedBox(
                                height: double.infinity,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                listener: (context, state) => print(state),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductSearchContent extends StatelessWidget {
  final List<ProductModel>? productList;
  const ProductSearchContent({super.key, this.productList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.8),
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
