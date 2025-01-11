import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_appbar.dart';
import 'package:nomo_app/features/cart/presentation/widgets/go_to_cart_bottom_bar.widget.dart';
import 'package:shimmer/shimmer.dart';

class SubCategoryShimmerWidget extends StatelessWidget {
  const SubCategoryShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
      bottomNavigationBar: const GoToCartBottomWidget(),
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Card(
                  elevation: 8,
                  margin: EdgeInsets.zero,
                  shape: const LinearBorder(),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: kToolbarHeight + 80),
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.6),
                              child: Column(
                                children: [
                                  Shimmer.fromColors(
                                    baseColor:
                                        Theme.of(context).colorScheme.onSurface,
                                    highlightColor: Colors.white,
                                    child: const ClipOval(
                                        child: CircleAvatar(
                                      radius: 38,
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Shimmer.fromColors(
                            baseColor: Theme.of(context).colorScheme.onSurface,
                            highlightColor: Colors.white,
                            child: Container(
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
                          ),
                        ],
                      );
                    },
                    itemCount: 2,
                  )),
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.64),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Shimmer.fromColors(
                    baseColor: Theme.of(context).colorScheme.onSurface,
                    highlightColor: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
