import 'package:flutter/material.dart';
import 'package:nomo_app/core/data/extensions/assets.extensions.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_search_bar.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_textfield.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // final String? title;
  final String? searchHint;
  final Function(String search)? onSearch;
  final VoidCallback? onBackPress;
  final bool showBackButton;
  final Widget? titleWidget;
  final void Function()? onSearchPress;

  const CustomAppBar(
      {super.key,
      // this.title,
      this.searchHint,
      this.onBackPress,
      this.onSearch,
      this.showBackButton = false,
      this.titleWidget,this.onSearchPress});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(116),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("app_bar_1".png), fit: BoxFit.fill)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showBackButton)
                  IconButton(
                      onPressed: () {
                        NavigationService.goBack(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: Theme.of(context).colorScheme.onSecondary,
                      )),
                Expanded(
                  child: titleWidget ??
                      CustomSearchBar(
                        onSearch: onSearch,
                        searchHint: searchHint,
                        onPress: onSearchPress,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
      // elevation: 0, // Removes the shadow effect
      // backgroundColor: Colors.transparent, // Makes the background transparent
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(116);
}
