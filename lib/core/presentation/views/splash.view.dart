import 'package:flutter/material.dart';
import 'package:nomo_app/core/data/extensions/assets.extensions.dart';
import 'package:nomo_app/core/services/cookie_services/cookie.service.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/features/authentication/presentation/view/otp.view.dart';
import 'package:nomo_app/features/dashboard/presentation/view/dashboard.view.dart';

class SplashView extends StatefulWidget {
  static String routeName = "/splash_screen";
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  bool _isSliding = false; // Toggle to trigger sliding
  bool _fillScreenWithColor =
      false; // Toggle to fill the screen with the desired color

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller for fade and scale animations
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Fade and scale happen in 1 second
    );

    // Define the opacity animation (fade-in effect)
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Define the scale animation (scale-up effect)
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Start the fade and scale animation
    _controller.forward();

    // Trigger the fast slide animation after the scale and fade-in complete
    Future.delayed(const Duration(seconds: 1), () {
      // Slide starts at 1 second
      setState(() {
        _isSliding = true;
      });
    });

    // Fill the screen with color immediately after the slide animation
    Future.delayed(const Duration(milliseconds: 800), () {
      // Color fill at 1.5 seconds
      setState(() {
        _fillScreenWithColor = true;
      });
    });

    // Navigate to the next screen after 2 seconds
    Future.delayed(const Duration(seconds: 2), () async {
      // You can navigate to the next screen here

      String? accessToken = await CookieService.retrieveData('token');
      if (mounted) {
        if (accessToken != null) {
          NavigationService.goNextFinishAll(context, DashboardView.routeName);
        } else {
          NavigationService.goNextFinishAll(context, OtpView.routeName);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: AnimatedContainer(
        duration:
            const Duration(milliseconds: 100), // Color transition duration
        color: _fillScreenWithColor
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onPrimary,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: _opacityAnimation.value,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: AnimatedContainer(
                        duration: _isSliding
                            ? const Duration(milliseconds: 200)
                            : Duration.zero, // Quick slide
                        transform: Matrix4.translationValues(
                          _isSliding
                              ? screenWidth
                              : 0.0, // Slide off to the right
                          0.0,
                          0.0,
                        ),
                        child: Image.asset("logo".iconPng),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
