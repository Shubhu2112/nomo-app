import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomo_app/core/presentation/views/non_injectable_base.view.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_appbar.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/features/categories/data/models/categories.model.dart';
import 'package:nomo_app/features/categories/presentation/cubit/categories.cubit.dart';
import 'package:nomo_app/features/categories/presentation/view/categories_shimmer.view.dart';
import 'package:nomo_app/features/categories/presentation/widgets/category_card.widget.dart';
import 'package:nomo_app/features/product/product_search/presentation/view/product_search.view.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NonInjectableBaseView<CategoriesCubit, List<CategoryModel>?>(
      bottomSafeArea: false,
      loadingbuilder: (context, state) {
        return const CategoriesShimmerView();
      },
      builder: (context, state) {
        return CategoriesContent(
          categories: state.data,
        );
      },
      listener: (context, state) => print(state),
    );
  }
}

class CategoriesContent extends StatelessWidget  with WidgetsBindingObserver {
  final List<CategoryModel>? categories;
  CategoriesContent({super.key, this.categories});

  final TextEditingController searchController = TextEditingController();
  CategoriesCubit? _cubit;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addObserver(this);
    _cubit = context.read<CategoriesCubit>();
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        _cubit?.refreshData();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          onSearchPress: () {
            NavigationService.goNext(context, ProductSearchView.routeName).then(
              (value) async {
                if (context.mounted) {
                  FocusScope.of(context).unfocus(); // Dismiss the keyboard
                  await SystemChannels.textInput.invokeMethod('TextInput.hide');
                  await SystemChannels.textInput.invokeMethod('TextInput.hide');
                }
              },
            );
          },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: kToolbarHeight +
                      110, // Adjust height to compensate for the extended app bar
                ),
                if (_cubit!.groceryCategories.isNotEmpty)
                  CustomText("Grocery & Kitchen 😋").db().bold(),
                if (_cubit!.groceryCategories.isNotEmpty)
                  SizedBox(
                    height: 280,
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 0.66,
                      ),
                      itemCount: _cubit?.groceryCategories.length,
                      itemBuilder: (context, index) {
                        CategoryModel categoryModel =
                            _cubit!.groceryCategories[index];
                        return CategoryCard(
                          imgUrl: categoryModel.image,
                          title: categoryModel.name,
                          id: categoryModel.id,
                        );
                      },
                    ),
                  ),
                if (_cubit!.snacksCategories.isNotEmpty)
                  CustomText("Snacks & Drinks 😋").db().bold(),
                if (_cubit!.snacksCategories.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: SizedBox(
                      height: 280,
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.88,
                        ),
                        itemCount: _cubit?.snacksCategories.length,
                        itemBuilder: (context, index) {
                          CategoryModel categoryModel =
                              _cubit!.snacksCategories[index];
                          return CategoryCard(
                            imgUrl: categoryModel.image,
                            title: categoryModel.name,
                            id: categoryModel.id,
                          );
                        },
                      ),
                    ),
                  ),
                if (_cubit!.beautyCategories.isNotEmpty)
                  CustomText("Beauty & Personal Care 😋").db().bold(),
                if (_cubit!.beautyCategories.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: SizedBox(
                      height: 280,
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.88,
                        ),
                        itemCount: _cubit?.beautyCategories.length,
                        itemBuilder: (context, index) {
                          CategoryModel categoryModel =
                              _cubit!.beautyCategories[index];
                          return CategoryCard(
                            imgUrl: categoryModel.image,
                            title: categoryModel.name,
                            id: categoryModel.id,
                          );
                        },
                      ),
                    ),
                  ),
                if (_cubit!.householdCategories.isNotEmpty)
                  CustomText("Household Essentials 😋").db().bold(),
                if (_cubit!.householdCategories.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: SizedBox(
                      height: 160,
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.88,
                        ),
                        itemCount:_cubit?.householdCategories.length,
                        itemBuilder: (context, index) {
                          CategoryModel categoryModel =
                              _cubit!.householdCategories[index];
                          return CategoryCard(
                            imgUrl: categoryModel.image,
                            title: categoryModel.name,
                            id: categoryModel.id,
                          );
                        },
                      ),
                    ),
                  ),
                const SizedBox(
                  height: kToolbarHeight + 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
       _cubit?.refreshData();
    }
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 80);
    path.quadraticBezierTo(width / 2, height, width, height - 80);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
