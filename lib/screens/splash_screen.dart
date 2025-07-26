import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:resturant/constants/app_assets.dart';
import 'package:resturant/screens/login_screen.dart';
import 'package:resturant/screens/menu_screen.dart';
import 'package:resturant/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _shimmerAnimation; // We need this back

  @override
  void initState() {
    super.initState();
    const logoAnimDuration = Duration(milliseconds: 1500);
    const postAnimDelay = Duration(milliseconds: 2000); // Increased for shimmer
    final totalDuration = Duration(
      milliseconds:
          logoAnimDuration.inMilliseconds + postAnimDelay.inMilliseconds,
    );

    _controller = AnimationController(duration: totalDuration, vsync: this);

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    // This animation will drive the shimmer gradient's movement
    _shimmerAnimation = Tween<double>(begin: -1.5, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.9, curve: Curves.linear),
      ),
    );

    _controller.forward();

    // Your improved navigation logic is perfect!
    Timer(totalDuration, () async {
      if (!mounted) return;

      final authService = AuthService();
      final isLoggedIn = await authService.isUserLoggedIn();

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                isLoggedIn ? const MenuScreen() : const LoginScreen(),
          ),
        );
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
    final screenSize = MediaQuery.of(context).size;
    final logoSize = math.min(screenSize.width * 0.5, screenSize.height * 0.5);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                // Replace Shimmer.fromColors with ShaderMask
                child: ShaderMask(
                  blendMode: BlendMode.srcATop,
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: const [
                        Colors.transparent,
                        Colors.white,
                        Colors.transparent,
                      ],
                      stops: const [0.4, 0.5, 0.6],
                      transform: _ShimmerTransform(
                        percent: _shimmerAnimation.value,
                        bounds: bounds,
                      ),
                    ).createShader(bounds);
                  },
                  // The child is the full-color logo
                  child: Image.asset(
                    AppAssets.logo,
                    width: logoSize,
                    height: logoSize,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Helper class to translate the gradient
class _ShimmerTransform extends GradientTransform {
  final double percent;
  final Rect bounds;

  const _ShimmerTransform({required this.percent, required this.bounds});

  @override
  Matrix4? transform(Rect a, {TextDirection? textDirection}) {
    return Matrix4.identity()..translate(bounds.width * percent, 0.0);
  }
}

// import 'dart:async';
// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart'; // Shimmer package
// import 'package:resturant/constants/app_assets.dart';
// import 'package:resturant/screens/login_screen.dart';
// import 'package:resturant/screens/menu_screen.dart';
// import 'package:resturant/services/auth_service.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late final AnimationController _controller;
//   late final Animation<double> _scaleAnimation;
//   late final Animation<double> _opacityAnimation;

//   @override
//   void initState() {
//     super.initState();
//     const logoAnimDuration = Duration(milliseconds: 1500);
//     const postAnimDelay = Duration(milliseconds: 500);
//     final totalDuration = Duration(
//       milliseconds:
//           logoAnimDuration.inMilliseconds + postAnimDelay.inMilliseconds,
//     );

//     _controller = AnimationController(duration: totalDuration, vsync: this);

//     _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
//       ),
//     );

//     _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
//       ),
//     );

//     _controller.forward();

//     // Navigate to next screen
//     Timer(totalDuration, () async {
//       if (!mounted) return;

//       final authService = AuthService();
//       final isLoggedIn = await authService.isUserLoggedIn();

//       if (mounted) {
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(
//             builder: (context) =>
//                 isLoggedIn ? const MenuScreen() : const LoginScreen(),
//           ),
//         );
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final logoSize = math.min(screenSize.width * 0.5, screenSize.height * 0.5);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: AnimatedBuilder(
//           animation: _controller,
//           builder: (context, child) {
//             return Opacity(
//               opacity: _opacityAnimation.value,
//               child: Transform.scale(
//                 scale: _scaleAnimation.value,
//                 child: Shimmer.fromColors(
//                   baseColor: Colors.grey.shade300,
//                   highlightColor: Colors.white,
//                   child: Image.asset(
//                     AppAssets.logo,
//                     width: logoSize,
//                     height: logoSize,
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
