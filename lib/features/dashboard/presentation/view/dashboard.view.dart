// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
// import 'package:dot_curved_bottom_nav/dot_curved_bottom_nav.dart';
// import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nomo_app/core/data/extensions/assets.extensions.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_carousel.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_textfield.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/features/cart/presentation/view/cart.view.dart';
import 'package:nomo_app/features/categories/presentation/view/categories.view.dart';
import 'package:nomo_app/features/dashboard/presentation/view/home.view.dart';
import 'package:nomo_app/features/categories/presentation/widgets/category_card.widget.dart';
import 'package:nomo_app/features/product/presentation/widgets/product_card.widget.dart';
import 'package:nomo_app/features/profile/presentation/view/profile.view.dart';
import 'package:nomo_app/features/sub_categories/presentation/widgets/sub_categories.view.dart';
// import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

class DashboardView extends StatefulWidget {
  static String routeName = "/dashboard_view";
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _currentPage = 0;

  void changeTab(int index) {
    setState(() {
      if (index == 2) {
        NavigationService.goNext(context, CartView.routeName).then(
          (value) {
            setState(() {
              _currentPage = 0;
            });
          },
        );
      } else {
        _currentPage = index;
      }
    });
  }

   List<Widget> _pages=[];

@override
void initState() {
  super.initState();

  // Initialize _pages here after the state is fully initialized
  _pages = [
    HomeView(
      onProfileTap: () {
        changeTab(3);
      },
      onCategoriesTap: () {
         changeTab(1);
      },
    ),
    const CategoriesView(),
    const Offstage(),
    const ProfileView(),
  ];
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.all(16.0), // Adjust padding for floating effect
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60), // Rounded corners
            child: Container(
              height: 70, // Adjust height of the bottom bar
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor, // Bottom bar color
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color
                    spreadRadius: 5,
                    blurRadius: 10, // Adjust shadow blur
                    offset: const Offset(
                        0, 3), // Offset for shadow to create elevation
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.home),
                      iconSize: 32,
                      color: _currentPage == 0
                          ? Colors.black
                          : Colors.white, // Change color based on selection
                      onPressed: () => changeTab(0),
                    ),
                    IconButton(
                      icon: const Icon(Icons.grid_view),
                      iconSize: 32,
                      color: _currentPage == 1
                          ? Colors.black
                          : Colors.white, // Change color based on selection
                      onPressed: () => changeTab(1),
                    ),
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      iconSize: 32,
                      color: _currentPage == 2
                          ? Colors.black
                          : Colors.white, // Change color based on selection
                      onPressed: () => changeTab(2),
                    ),
                    IconButton(
                      icon: const Icon(Icons.person),
                      iconSize: 32,
                      color: _currentPage == 3
                          ? Colors.black
                          : Colors.white, // Change color based on selection
                      onPressed: () => changeTab(3),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: _pages[_currentPage]);
  }
}
