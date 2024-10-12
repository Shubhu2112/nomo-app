import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/features/sub_categories/presentation/widgets/sub_categories.view.dart';

class CategoryCard extends StatelessWidget {
  final String? imgUrl;
  final String? title;
  final bool isSubCategory;
  const CategoryCard(
      {super.key, this.imgUrl, this.title, this.isSubCategory = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          if (!isSubCategory) {
            NavigationService.goNext(context, SubCategoriesView.routeName);
          }
        },
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Theme.of(context).colorScheme.onSurface,
              child: SvgPicture.asset(imgUrl ?? ""),
            ),
            CustomText(title ?? "").ds()
          ],
        ),
      ),
    );
  }
}
