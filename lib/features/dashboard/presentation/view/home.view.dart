
import 'package:flutter/material.dart';
import 'package:nomo_app/core/data/extensions/assets.extensions.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_carousel.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_textfield.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/features/address/presentation/view/address_list.view.dart';
import 'package:nomo_app/features/categories/presentation/widgets/category_card.widget.dart';
import 'package:nomo_app/features/product/presentation/widgets/product_card.widget.dart';

class HomeView extends StatelessWidget {
  final Function()? onProfileTap;
  final Function()? onCategoriesTap;
  HomeView({super.key, this.onProfileTap, this.onCategoriesTap});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: CustomScrollView(
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
                              CustomText("Delivery in just 10 Mins")
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
                                    CustomText(" Kalyan, Thane - Mum").ds(),
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
                      child: CustomTextField(
                        controller: searchController,
                        hintText: "Search Namkeen",
                        isRequired: false,
                        isEnable: true,
                        textInputType: TextInputType.text,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Theme.of(context).primaryColor,
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        borderRadius: 24,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        focusedColor: Theme.of(context).colorScheme.primary,
                        enabledBorder: Theme.of(context).colorScheme.onPrimary,
                        isDense: true,
                        onChanged: (value) {
                          // Handle search query changes here
                          print('Search Query: $value');
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a search term';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Sliver for the carousel
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: CustomCarousel(
                items: [
                  Image.asset("carousel_1".png),
                  Image.asset("carousel_2".png),
                  Image.asset("carousel_2".png),
                ],
                aspectRatio: 2.1,
              ),
            ),
          ),

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
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoryCard(
                    imgUrl: "apple".svg,
                    title: "Apple",
                  );
                },
                itemCount: 8,
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
                  TextButton(
                      onPressed: () {}, child: CustomText("See all").db()),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.8),
              itemCount: 8,
              itemBuilder: (context, index) {
                return const ProductCard(
                  productName: "Bell Pepper Red",
                  maxRetailPrice: 90,
                  sellingPrice: 42,
                  productOptionValueName: "1kg",
                );
              },
            ),
          ),

          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: kToolbarHeight - 10),
          ),
        ],
      ),
    );
  }
}
