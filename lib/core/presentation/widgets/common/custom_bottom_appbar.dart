import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';

class CustomBottomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? bottomWidget;
  final String? title;
  const CustomBottomAppbar({super.key, this.bottomWidget, this.title});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: AppBar(
        elevation: 8,
        toolbarHeight: 70,
      // automaticallyImplyLeading: true,
      // iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        surfaceTintColor: Theme.of(context).colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        title: CustomText(title ?? "").db().bold(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Column(children: [
            const Divider(
              thickness: 2,
            ),
            bottomWidget ?? const Offstage()
          ]),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
