import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:reverbeo/view_models/audio_view_model.dart';
import 'package:reverbeo/main.dart';

void main() {
  testWidgets('App renders main screen and bottom navigation', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AudioViewModel(),
        child: const ReverbeoApp(),
      ),
    );

    // Verify that the home page is shown by default.
    expect(find.text('Tap to Record'), findsOneWidget);

    // Verify that the bottom navigation bar is present with 3 items.
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.list), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);
  });
}