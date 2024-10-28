class PriceUtils {
  static double? getOfferPercentage(
      double? maxRetailPrice, double? sellingPrice) {
    if (maxRetailPrice == null || sellingPrice == null || maxRetailPrice == 0) {
      return null; // Handle invalid values (null or 0) gracefully
    }

    double discount = ((maxRetailPrice - sellingPrice) / maxRetailPrice) * 100;
    return discount;
  }
}
