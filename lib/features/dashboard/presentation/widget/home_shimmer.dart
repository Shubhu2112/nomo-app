import 'package:flutter/material.dart';
import 'package:nomo_app/core/common/widget/common_shimmer_container.widget.dart';
import 'package:nomo_app/features/dashboard/presentation/widget/category_shimmer_card.widget.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: AppBar(
          backgroundColor:
              Theme.of(context).colorScheme.secondary.withOpacity(0.09),
          flexibleSpace: const FlexibleSpaceBar(
            background: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            CommonShimmerContainer(
                              width: 90,
                              height: 20,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CommonShimmerContainer(
                              width: 50,
                              height: 20,
                            ),
                          ],
                        ),
                        CircleAvatar(
                          child: CommonShimmerContainer(
                            child: ClipOval(
                                child: CircleAvatar(
                              radius: 38,
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const CommonShimmerContainer(
                height: 27,
                width: 120,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: List.generate(
                  3,
                  (index) {
                    return const CategoryShimmerCardWidget();
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                 padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     CommonShimmerContainer(
                      height: 27,
                      width: 110,
                    ),
                     CommonShimmerContainer(
                      height: 27,
                      width: 80,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  //   runSpacing: 8,

                  // spacing: 8,
                  children: List.generate(
                    4,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CommonShimmerContainer(
                          child: Container(
                            height: 220,
                            width: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  16,
                                ),
                                color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
