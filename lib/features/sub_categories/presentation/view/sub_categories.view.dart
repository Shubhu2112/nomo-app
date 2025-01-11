import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomo_app/core/presentation/views/injectable_base.view.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_appbar.dart';
import 'package:nomo_app/core/services/network_services/dio_http_impl.service.dart';
import 'package:nomo_app/features/cart/presentation/widgets/go_to_cart_bottom_bar.widget.dart';
import 'package:nomo_app/features/categories/presentation/widgets/category_card.widget.dart';
import 'package:nomo_app/features/product/product_list/presentation/view/product_list.view.dart';
import 'package:nomo_app/features/sub_categories/data/models/sub_categories.model.dart';
import 'package:nomo_app/features/sub_categories/data/repositories/sub_categories_impl.repository.dart';
import 'package:nomo_app/features/sub_categories/data/sources/sub_categories_impl.source.dart';
import 'package:nomo_app/features/sub_categories/domain/usecase/sub_categories.usecase.dart';
import 'package:nomo_app/features/sub_categories/presentation/cubit/sub_categories.cubit.dart';
import 'package:nomo_app/features/sub_categories/presentation/widgets/sub_category_shimmer.widget.dart';

class SubCategoriesView extends StatelessWidget {
  static String routeName = "/sub_categories_view";

  const SubCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    String categoryId = args["id"].toString();
    return InjectableBaseView<SubCategoriesCubit, List<SubCategoryModel>?>(
      loadingbuilder: (context, state) {
        return const SubCategoryShimmerWidget();
      },
      bottomSafeArea: false,
      builder: (context, state) {
        return SubCategoriesContent(
          subCategoriesModels: state.data,
        );
      },
      listener: (context, state) => print(state),
      cubitBuilder: (BuildContext context) => SubCategoriesCubit(
        context,
        categoryId: categoryId,
        subCategoriesUsecase: SubCategoriesUsecase(
            repository: SubCategoriesImplRepository(
                dataSource: SubCategoriesImplDataSource(
                    httpService: ApiRestService()))),
      ),
    );
  }
}

class SubCategoriesContent extends StatelessWidget {
  final List<SubCategoryModel>? subCategoriesModels;
  const SubCategoriesContent({super.key, this.subCategoriesModels});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SubCategoriesCubit>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
      bottomNavigationBar: const GoToCartBottomWidget(),
      body: Row(
        children: [
          if (subCategoriesModels != null)
            Expanded(
              // flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Card(
                    elevation: 8,
                    margin: EdgeInsets.zero,
                    shape: const LinearBorder(),
                    child:
                        //  Stack(
                        //   fit: StackFit.expand,
                        //   children: [
                        // Positioned.fill(top: kToolbarHeight-55,child: Image.asset("left_bar_sub_categories".png,fit: BoxFit.fill,)),

                        ListView.builder(
                      padding: const EdgeInsets.only(top: kToolbarHeight + 80),
                      itemBuilder: (context, index) {
                        SubCategoryModel? subCategoryModel =
                            subCategoriesModels?[index];

                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Using the CategoryCard widget
                            Expanded(
                              child: CategoryCard(
                                imgUrl: subCategoryModel
                                    ?.image, // Use the image from subCategoryModel
                                title: subCategoryModel?.name?.replaceAll(" ",
                                    "\n"), // Use the name from subCategoryModel
                                // Pass the id if necessary
                                isSubCategory: true, // Mark it as a subcategory

                                isSelected:
                                    subCategoryModel?.isSelected ?? false,
                                onTap: () {
                                  // Ensure the list is non-null and iterate through subCategories to deselect them
                                  cubit.updateSubCategorySelection(index);

                                  // Define tap action or leave empty if handled inside CategoryCard
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            if (subCategoryModel?.isSelected ?? false)
                              // Vertical divider between CategoryCards
                              Container(
                                width: 4, // Border width
                                height: 66, // Height to match the content
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(
                                            0.6), // Border color to match the UI
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4),
                                        bottomLeft: Radius.circular(4))),
                              ),
                          ],
                        );
                      },
                      itemCount: subCategoriesModels?.length,
                    )

                    //   ],
                    // ),
                    ),
              ),
            ),
          Expanded(
            flex: 4,
            child: ProductListView(
              subCategoryId: cubit.selectedSubcategory?.id.toString(),
            ),
          )
        ],
      ),
    );
  }
}
