import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final bool isDetails;
  final double? height;

  const QuantitySelector(
      {super.key,
      required this.quantity,
      required this.onIncrement,
      required this.onDecrement,
      this.height = 32,
      this.isDetails = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height??32,
      width: isDetails ? 126 : 100,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor, // Background color of the widget
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.remove, color: Colors.white),
            onPressed: onDecrement,
            iconSize: isDetails ? 30 : 20,
          ),
          if (isDetails)
            const SizedBox(
              width: 10,
            ),
          if (isDetails)
            CustomText(
              '$quantity', // Display quantity with "pcs"
            )
                .lb()
                .textColor(Theme.of(context).colorScheme.onSurface)
                .fontWeight(FontWeight.w900)
          else
            CustomText(
              '$quantity', // Display quantity with "pcs"
            )
                .ls()
                .textColor(Theme.of(context).colorScheme.onSurface)
                .fontWeight(FontWeight.w900),
          if (isDetails)
            const SizedBox(
              width: 10,
            ),
          IconButton(
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: onIncrement,
            iconSize: isDetails ? 30 : 20,
          ),
        ],
      ),
    );
  }
}
