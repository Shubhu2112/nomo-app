import 'package:flutter/material.dart';
import 'package:nomo_app/core/common/widget/common_shimmer_container.widget.dart';

class CategoryShimmerCardWidget extends StatelessWidget {
  const CategoryShimmerCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: 25.0, bottom: 4.6, left: 4.6, top: 4.6),
      child: Column(
        children: [
          CommonShimmerContainer(
            child: ClipOval(
              child:
                  CircleAvatar(radius: 38, backgroundColor: Color(0xffFFDEDE)),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          CommonShimmerContainer(
            height: 27,
            width: 90,
          ),
        ],
      ),
    );
  }
}
