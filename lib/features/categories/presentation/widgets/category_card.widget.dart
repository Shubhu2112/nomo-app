import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/features/sub_categories/presentation/view/sub_categories.view.dart';

class CategoryCard extends StatelessWidget {
  final String? imgUrl;
  final int? id;
  final String? title;
  final bool isSubCategory;
  final bool isSelected;
  final Function()? onTap;
  const CategoryCard(
      {super.key,
      this.imgUrl,
      this.id,
      this.title,
      this.onTap,
      this.isSelected = false,
      this.isSubCategory = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        if (!isSubCategory) {
          NavigationService.goNext(context, SubCategoriesView.routeName,
              arg: {"id": id});
        }
        onTap?.call();
      },
      child: Padding(
        padding: const EdgeInsets.all( 4.6 ),
        child: Column(
          children: [
            Material(
                elevation: isSubCategory
                    ? 6
                    : 0, // Elevation to create the shadow effect
                shape:
                    const CircleBorder(), // Ensures the material is in a circle shape
                color: Colors
                    .transparent, // Make the background transparent to keep only the circle
                child: ClipOval(
                  child: CircleAvatar(
                    radius: 38,
                    backgroundColor: isSelected
                        ? const Color(0xffFFDEDE)
                        : Theme.of(context).colorScheme.onSurface,
                    child: (imgUrl?.contains("svg") ?? false)
                        ? SvgPicture.asset(imgUrl ?? "")
                        : Image.network(
                            imgUrl ?? "",
                            colorBlendMode: BlendMode.softLight,
                          ),
                  ),
                )),
                const SizedBox(height: 4,),
            if (isSubCategory)
              CustomText(title ?? "").ds().center().fontSize(10.4)
            else
              SizedBox(width: 100,child: CustomText(title ?? "").ds().center().maxLines(2))
          ],
        ),
      ),
    );
  }
}
