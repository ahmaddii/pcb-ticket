import 'package:flutter_test/flutter_test.dart';
import 'package:pcb/app.dart';

void main() {
  testWidgets('App renders SplashScreen with PCB and Pakistan Cricket Board', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('PCB'), findsOneWidget);
    expect(find.text('Pakistan Cricket Board'), findsOneWidget);
  });
}
