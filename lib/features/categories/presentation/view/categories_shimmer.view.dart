import 'package:flutter/material.dart';
import 'package:nomo_app/core/common/widget/common_shimmer_container.widget.dart';
import 'package:nomo_app/features/dashboard/presentation/widget/category_shimmer_card.widget.dart';

class CategoriesShimmerView extends StatelessWidget {
  const CategoriesShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const CommonShimmerContainer(
                height: 27,
                width: 110,
              ),
              SizedBox(
                height: 280,
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.66,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return const CategoryShimmerCardWidget();
                  },
                ),
              ),
              const CommonShimmerContainer(
                height: 27,
                width: 110,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: SizedBox(
                  height: 416,
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.88,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return const CategoryShimmerCardWidget();
                    },
                  ),
                ),
              ),
              const CommonShimmerContainer(
                height: 27,
                width: 110,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: SizedBox(
                  height: 416,
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.88,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return const CategoryShimmerCardWidget();
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
    );
  }
}
