import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomo_app/core/common/utils/tel.util.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/features/order/data/common/enum/order_status.enum.dart';
import 'package:nomo_app/features/order/presentation/cubits/order_status_timeline.cubit.dart';
import 'package:timelines/timelines.dart';

class OrderStatusTimelineWidget extends StatelessWidget {
  // Current status of the order
  final int? currentOrderId;
  const OrderStatusTimelineWidget({super.key, this.currentOrderId});

  @override
  Widget build(BuildContext context) {
    final DeliveryStatus currentStatus =
        context.watch<OrderStatusTimelineCubit>().data.status;
    final String? deliveryCaptainContactNum = context
        .watch<OrderStatusTimelineCubit>()
        .data
        .deliveryCaptainContactNum;

    final String? deliveryCaptainName =
        context.watch<OrderStatusTimelineCubit>().data.deliveryCaptainName;
    context.read<OrderStatusTimelineCubit>().currentOrderId =
        currentOrderId.toString();

    Color getStatusColor(DeliveryStatus status) {
      if (status == currentStatus) {
        return Colors.green; // Current step
      } else if (currentStatus.index > status.index) {
        return Colors.green; // Completed step
      } else {
        return Colors.grey; // Inactive step
      }
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Packing with dot and label horizontally
              Row(
                children: [
                  DotIndicator(
                    color: getStatusColor(DeliveryStatus.packingInProgress),
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
                  color: currentStatus.index >=
                          DeliveryStatus.deliveryInProgress.index
                      ? Colors.red
                      : Colors.grey,
                  thickness: 2.5,
                ),
              ),
              // Out for Delivery with dot and label horizontally
              Row(
                children: [
                  DotIndicator(
                    color: getStatusColor(DeliveryStatus.deliveryInProgress),
                    size: 12.0,
                  ),
                  const SizedBox(width: 8),
                  CustomText('Out for Delivery')
                      .ds()
                      .bold(
                          returnBold: currentStatus.index >=
                              DeliveryStatus.deliveryInProgress.index)
                      .fontSize(13)
                ],
              ),
              // Line between Out for Delivery and Arrived
              SizedBox(
                width: 24, // Set a fixed width for the line
                child: Divider(
                  color: currentStatus.index >= DeliveryStatus.delivered.index
                      ? Colors.red
                      : Colors.grey,
                  thickness: 2.5,
                ),
              ),
              // Arrived with dot and label horizontally
              Row(
                children: [
                  DotIndicator(
                    color: getStatusColor(DeliveryStatus.delivered),
                    size: 12.0,
                  ),
                  const SizedBox(width: 8),
                  CustomText('Arrived')
                      .ds()
                      .bold(
                          returnBold: currentStatus.index >=
                              DeliveryStatus.delivered.index)
                      .fontSize(13)
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: CustomText("Sit Back, Your Order is in Progress")
              .ls()
              .textColor(Theme.of(context).colorScheme.surface),
        ),
        const SizedBox(
          height: 20,
        ),
        if (currentStatus == DeliveryStatus.deliveryInProgress)
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  right: 12,
                ),
                child: CircleAvatar(
                  child: Icon(Icons.person),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText("Hi, I am $deliveryCaptainName ").dm().bold(),
                      CustomText("(Delivery Partner)").dm()
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText("Chat/Call Delivery Partner: ").dm(),
                      InkWell(
                          onTap: () {
                            TelUtil.makePhoneCall(
                                "+91$deliveryCaptainContactNum");
                          },
                          child: CustomText("Click here")
                              .dm()
                              .decoration(TextDecoration.underline))
                    ],
                  )
                ],
              )
            ],
          )
      ],
    );
  }

  // Helper function to determine the color of the dot based on the current status
}

// void main() {
//   runApp(MaterialApp(
//     home: OrderStatusTimelineWidget(
//       currentStatus: DeliveryStatus.packing, // Set the current status here
//     ),
//   ));
// }
