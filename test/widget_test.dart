// This is a basic Flutter widget test.
//
// For more information, see https://flutter.dev/docs/testing
import 'package:flutter_test/flutter_test.dart';
import 'package:resturant/main.dart'; // Import MyApp
import 'package:resturant/screens/splash_screen.dart'; // Import SplashScreen

void main() {
  testWidgets('MyApp shows SplashScreen on startup', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that SplashScreen is the first widget shown.
    expect(find.byType(SplashScreen), findsOneWidget);
  });
}
