enum DeliveryStatus {
  inPackingQueue,
  packingInProgress,
  packed,
  deliveryInProgress,
  delivered,
  completed,
}

extension DeliveryStatusExtension on DeliveryStatus {
  String get string {
    switch (this) {
      case DeliveryStatus.inPackingQueue:
        return "In Packing Queue";
      case DeliveryStatus.packingInProgress:
        return "Packing In Progress";
      case DeliveryStatus.packed:
        return "Packed";
      case DeliveryStatus.deliveryInProgress:
        return "Delivery In Progress";
      case DeliveryStatus.delivered:
        return "Delivered";
      case DeliveryStatus.completed:
        return "Completed";
      default:
        return "Unknown";
    }
  }

  static DeliveryStatus fromString(String string) {
    switch (string) {
      case "In Packing Queue":
        return DeliveryStatus.inPackingQueue;
      case "Packing In Progress":
        return DeliveryStatus.packingInProgress;
      case "Packed":
        return DeliveryStatus.packed;
      case "Delivery In Progress":
        return DeliveryStatus.deliveryInProgress;
      case "Delivered":
        return DeliveryStatus.delivered;
      case "Completed":
        return DeliveryStatus.completed;
      default:
        throw ArgumentError("Unknown DeliveryStatus string: $string");
    }
  }
}
