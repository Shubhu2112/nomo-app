import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:timelines/timelines.dart';

// Define the enum for the delivery stages
enum DeliveryStatus { packing, outForDelivery, arrived }

class OrderStatusTimelineWidget extends StatelessWidget {
  // Current status of the order
  final DeliveryStatus currentStatus;

  const OrderStatusTimelineWidget({super.key, required this.currentStatus});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Packing with dot and label horizontally
          Row(
            children: [
              DotIndicator(
                color: getStatusColor(DeliveryStatus.packing),
                size: 12.0,
              ),
              const SizedBox(width: 8),
              CustomText("Packing").ds().bold().fontSize(13)
            ],
          ),
          // Line between Packing and Out for Delivery
          SizedBox(
            width: 24, // Set a fixed width for the line
            child: Divider(
              color: currentStatus.index >= DeliveryStatus.outForDelivery.index
                  ? Colors.red
                  : Colors.grey,
              thickness: 2.5,
            ),
          ),
          // Out for Delivery with dot and label horizontally
          Row(
            children: [
              DotIndicator(
                color: getStatusColor(DeliveryStatus.outForDelivery),
                size: 12.0,
              ),
              const SizedBox(width: 8),
              CustomText('Out for Delivery')
                  .ds()
                  .bold(
                      returnBold: currentStatus.index >=
                          DeliveryStatus.outForDelivery.index)
                  .fontSize(13)
            ],
          ),
          // Line between Out for Delivery and Arrived
          SizedBox(
            width: 24, // Set a fixed width for the line
            child: Divider(
              color: currentStatus.index >= DeliveryStatus.arrived.index
                  ? Colors.red
                  : Colors.grey,
              thickness: 2.5,
            ),
          ),
          // Arrived with dot and label horizontally
          Row(
            children: [
              DotIndicator(
                color: getStatusColor(DeliveryStatus.arrived),
                size: 12.0,
              ),
              const SizedBox(width: 8),
              CustomText('Arrived')
                  .ds()
                  .bold(
                      returnBold:
                          currentStatus.index >= DeliveryStatus.arrived.index)
                  .fontSize(13)
            ],
          ),
        ],
      ),
    );
  }

  // Helper function to determine the color of the dot based on the current status
  Color getStatusColor(DeliveryStatus status) {
    if (status == currentStatus) {
      return Colors.green; // Current step
    } else if (currentStatus.index > status.index) {
      return Colors.green; // Completed step
    } else {
      return Colors.grey; // Inactive step
    }
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: OrderStatusTimelineWidget(
//       currentStatus: DeliveryStatus.packing, // Set the current status here
//     ),
//   ));
// }
