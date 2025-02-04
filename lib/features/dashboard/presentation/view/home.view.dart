import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomo_app/core/data/extensions/assets.extensions.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/views/non_injectable_base.view.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_carousel.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_search_bar.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_textfield.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/features/address/presentation/view/address_list.view.dart';
import 'package:nomo_app/features/categories/data/models/categories.model.dart';
import 'package:nomo_app/features/categories/presentation/widgets/category_card.widget.dart';
import 'package:nomo_app/features/dashboard/presentation/cubit/home.cubit.dart';
import 'package:nomo_app/features/dashboard/presentation/widget/home_shimmer.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';
import 'package:nomo_app/features/product/product_list/presentation/widgets/product_card.widget.dart';
import 'package:nomo_app/features/product/product_search/presentation/view/product_search.view.dart';
import 'package:nomo_app/features/store/data/models/store.model.dart';

class HomeView extends StatelessWidget {
  final Function()? onProfileTap;
  final Function()? onCategoriesTap;

  const HomeView({super.key, this.onProfileTap, this.onCategoriesTap});

  @override
  Widget build(BuildContext context) {
    return NonInjectableBaseView<HomeCubit,
        (List<CategoryModel>?, List<ProductModel>?, StoreModel?)>(
      bottomSafeArea: false,
      loadingbuilder: (context, state) {
        return const HomeShimmer();
      },
      builder: (context, state) {
        return HomeViewContent(
          onCategoriesTap: onCategoriesTap,
          onProfileTap: onProfileTap,
          categories: state.data?.$1,
          bestSellingProducts: state.data?.$2,
          store: state.data?.$3,
        );
      },
      listener: (context, state) => print(state),
    );
  }
}

class HomeViewContent extends StatelessWidget {
  final Function()? onProfileTap;
  final Function()? onCategoriesTap;
  final List<CategoryModel>? categories;
  final List<ProductModel>? bestSellingProducts;
  final StoreModel? store;
  HomeViewContent(
      {super.key,
      this.onProfileTap,
      this.onCategoriesTap,
      this.categories,
      this.bestSellingProducts,
      this.store});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        context.read<HomeCubit>().refreshData();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: CustomScrollView(
          controller: context.read<HomeCubit>().scrollController,
          slivers: [
            // SliverAppBar with a Custom Search Bar and Header
            SliverAppBar(
              backgroundColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(0.09),
              floating: true,
              pinned: false,
              snap: false,
              expandedHeight: 130.0,
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                        "Delivery in just ${store?.travelTimeInMins} Mins")
                                    .db()
                                    .bold(),
                                InkWell(
                                  onTap: () {
                                    NavigationService.goNext(
                                        context, AddressListView.routeName);
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.location_pin,
                                      ),
                                      CustomText(" ${store?.address}").ds(),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                onProfileTap?.call();
                              },
                              child: const CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: CustomSearchBar(
                          onPress: () {
                            NavigationService.goNext(
                              context,
                              ProductSearchView.routeName,
                            ).then((value) async {
                              if (context.mounted) {
                                  FocusScope.of(context)
                                    .unfocus(); // Dismiss the keyboard
                              await  SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                               await SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                              
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //TODO: add carousel
      
            // Sliver for the carousel
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            //     child: CustomCarousel(
            //       items: [
            //         Image.asset("carousel_1".png),
            //         Image.asset("carousel_2".png),
            //         Image.asset("carousel_2".png),
            //       ],
            //       aspectRatio: 2.1,
            //     ),
            //   ),
            // ),
      
            // Sliver for the Categories section
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText("Categories 😋").db().bold(),
                    TextButton(
                        onPressed: () {
                          onCategoriesTap?.call();
                        },
                        child: CustomText("See all").db()),
                  ],
                ),
              ),
            ),
      
            // Sliver for the horizontal list of categories
            SliverToBoxAdapter(
              child: SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    CategoryModel? category = categories?[index];
                    return CategoryCard(
                      imgUrl: category?.image,
                      title: category?.name,
                      id: category?.id,
                    );
                  },
                  itemCount: categories?.length,
                ),
              ),
            ),
      
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText("Best Selling 🔥").db().bold(),
                    // TODO : need to add more functionality
                    // TextButton(
                    //     onPressed: () {}, child: CustomText("See all").db()),
                  ],
                ),
              ),
            ),
      
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.8),
                itemCount: bestSellingProducts?.length,
                itemBuilder: (context, index) {
                  ProductModel? product = bestSellingProducts?[index];
                  return ProductCard(
                    isSubCategory: false,
                    productModel: product,
                  );
                },
              ),
            ),
      
            const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: kToolbarHeight - 10),
            ),
          ],
        ),
      ),
    );
  }
}
