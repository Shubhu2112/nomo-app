import 'package:flutter/material.dart';
import 'package:nomo_app/core/data/extensions/assets.extensions.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_appbar.dart';
import 'package:nomo_app/features/categories/presentation/widgets/category_card.widget.dart';
import 'package:nomo_app/features/product/presentation/widgets/product_card.widget.dart';

class SubCategoriesView extends StatefulWidget {
  static String routeName = "/sub_categories_view";
  const SubCategoriesView({super.key});

  @override
  State<SubCategoriesView> createState() => _SubCategoriesViewState();
}

class _SubCategoriesViewState extends State<SubCategoriesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
      body: Row(
        children: [
          Expanded(
            // flex: 2,
            child: Card(
              elevation: 8,
              shape: const LinearBorder(),
              child:
                  //  Stack(
                  //   fit: StackFit.expand,
                  //   children: [
                  // Positioned.fill(top: kToolbarHeight-55,child: Image.asset("left_bar_sub_categories".png,fit: BoxFit.fill,)),
                  ListView.builder(
                padding: const EdgeInsets.only(top: kToolbarHeight + 54),
                itemBuilder: (context, index) {
                  return CategoryCard(
                    imgUrl: "apple".svg,
                    title: "Apple\nmango",
                    isSubCategory: true,
                  );
                },
                itemCount: 8,
              ),
              //   ],
              // ),
            ),
          ),
          Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(right: 6, left: 1),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.76),
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return const ProductCard(
                      productName: "Bell Pepper Red",
                      maxRetailPrice: 90,
                      sellingPrice: 42,
                      productOptionValueName: "1kg",
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // Start from the bottom left corner
    path.lineTo(0, size.height);

    // Line to the bottom right corner
    path.lineTo(size.width, size.height);

    // Line to the top right corner
    path.lineTo(size.width, 0);

    // Custom curved shape for the top left side (adjust control and end points)
    path.quadraticBezierTo(
      size.width * 0.95, size.height * 0.05, // Control point (curve intensity)
      0, size.height * 0.05, // End point (where curve ends on the left side)
    );

    // Close the path
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
