import 'package:nomo_app/core/services/flavor_services/flavor_config.dart';

extension AssetsExtension on String {
  ///By this method we will get png image from particular tenants
  ///we just need to add image name with .png extension
  get png =>
      "assets/tenants/${FlavorConfig.instance!.productName}/images/$this.png";
  get iconPng =>
      "assets/tenants/${FlavorConfig.instance!.productName}/icons/$this.png";
  get svg =>
      "assets/tenants/${FlavorConfig.instance!.productName}/images/$this.svg";
  get anm =>
      "assets/tenants/${FlavorConfig.instance!.productName}/animations/$this.json";
}
