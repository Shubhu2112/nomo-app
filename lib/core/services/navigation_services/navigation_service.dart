import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/views/custom_navigation_wrapper.widget.dart';
import 'package:nomo_app/features/address/presentation/view/add_address.view.dart';
import 'package:nomo_app/features/address/presentation/view/address_list.view.dart';
import 'package:nomo_app/features/address/presentation/widgets/add_address_bottomsheet.widget.dart';
import 'package:nomo_app/features/authentication/presentation/view/otp.view.dart';
import 'package:nomo_app/features/cart/presentation/view/cart.view.dart';
import 'package:nomo_app/features/dashboard/presentation/view/dashboard.view.dart';
import 'package:nomo_app/features/order/presentation/views/order_status.view.dart';
import 'package:nomo_app/features/order/presentation/widgets/order_success.widget.dart';
import 'package:nomo_app/features/order/presentation/views/order_summary.view.dart';
import 'package:nomo_app/features/order/presentation/views/orders_list.view.dart';
import 'package:nomo_app/features/product/product_details/presentation/view/product_details.view.dart';
import 'package:nomo_app/features/sub_categories/presentation/view/sub_categories.view.dart';

class NavigationService {
  NavigationService._();

   static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static String currentRoute = "/myapp_screen";
  static String previousRoute = "/myapp_screen";
  static List<String> navstack = ["/myapp_screen"];

  static Map<String, dynamic> initializationArgs = {};

  static Map<String, Widget Function(BuildContext context)> generateRoute() {
    return {
      OtpView.routeName: (context) =>  const OtpView(),
      DashboardView.routeName: (context) => const DashboardView(),
      ProductDetailsView.routeName: (context) => const ProductDetailsView(),
      SubCategoriesView.routeName: (context) => const SubCategoriesView(),
      CartView.routeName: (context) => const CartView(),
      OrdersListView.routeName: (context) => const OrdersListView(),
      OrderSummaryView.routeName: (context) => const OrderSummaryView(),
      AddressListView.routeName: (context) => const AddressListView(),
      AddAddressView.routeName: (context) => const AddAddressView(),
      OrderStatusView.routeName: (context) => const OrderStatusView()
      // VideoListView.routeName: (context) => const VideoListView(),
      // HlsVideoPlayerView.routeName: (context) => const HlsVideoPlayerView()
    };
  }

  var errorCallbackClosure = () => {};

  // ignore: unused_element
  static Widget _errorRoute() => const Scaffold(
        body: Center(child: Text("Page not found")),
      );

  static Future<Object?> goNext(BuildContext context, String route,
      {dynamic arg}) {
    previousRoute = currentRoute;

    currentRoute = route;

    navstack.add(route);

    if (arg != null) {
      initializationArgs[route] = arg;
    }

    return Navigator.of(context).pushNamed(route, arguments: arg);
  }

  static goNextFinishAll(BuildContext context, String route,
      {dynamic arg, void Function()? errorCallBack}) async {
    navstack[navstack.length - 1] = route;
    currentRoute = route;
    await Navigator.of(context).pushReplacementNamed(route, arguments: arg);
    if (arg != null) {
      initializationArgs[route] = arg;
    }
  }

  static popUntilAndPush(BuildContext context, String route,
      {dynamic arg, void Function()? errorCallBack}) {
    navstack.clear();
    navstack.add(route);
    currentRoute = route;
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.of(context).pushReplacementNamed(route, arguments: arg);
    if (arg != null) {
      initializationArgs[route] = arg;
      //NavigationUtils.generateRoute();
    }
  }

  static goBack(BuildContext context,
      {String? routeName, bool changeCurrentRoute = true}) {
    if (changeCurrentRoute) {
      navstack.removeLast();
      currentRoute = previousRoute;
      if (navstack.length >= 2) previousRoute = navstack[navstack.length - 2];
    }
    Navigator.of(context).pop();
  }

static bool canGoBack({bool checkDashboard = true}) {
  // Check if there are any routes left in the navigation stack
  if (navstack.isEmpty) return false;

  // Optionally check if the current route is "/dashboard_view"
  if (checkDashboard && currentRoute == "/dashboard_view") {
    return false;
  }

  return true;
}



  static goHardwareBack(BuildContext context) {
    navstack.removeLast();
    currentRoute = navstack.last;

    Navigator.of(context).pop();
  }

  static const String splash = "/splash_screen";
  static const String welcome = "/welcome_screen";
  static const String getStart = "/getstart_screen";
  static const String myApp = "/myapp_screen";
  static const String login = "/login_screen";
}
