import 'package:flutter/material.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';

class CustomNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);

    // Check if we can perform a custom back action
    if (NavigationService.canGoBack()) {
      // Handle your custom back navigation
      NavigationService.goBack(NavigationService.navigatorKey.currentContext!);
    }
  }
}
