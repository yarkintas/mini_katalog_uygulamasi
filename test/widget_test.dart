import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog_uygulamasi/main.dart';

void main() {
  testWidgets('Mini catalog adds product and opens checkout', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1000, 1200);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const MiniCatalogApp());
    await tester.pumpAndSettle();

    expect(find.text('Mini Katalog'), findsWidgets);
    expect(find.text('iPhone 15 Pro'), findsOneWidget);
    expect(find.byIcon(Icons.add_shopping_cart_outlined), findsWidgets);

    await tester.tap(find.byIcon(Icons.add_shopping_cart_outlined).first);
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
    expect(find.textContaining('sepete eklendi'), findsOneWidget);

    await tester.tap(find.byTooltip('Sepet'));
    await tester.pumpAndSettle();

    expect(find.text('Sepetim'), findsOneWidget);
    expect(find.text('Sepet ozeti'), findsOneWidget);
    expect(find.text('Odemeye gec'), findsOneWidget);

    await tester.tap(find.text('Odemeye gec'));
    await tester.pumpAndSettle();

    expect(find.text('Odeme'), findsOneWidget);
    expect(find.text('Guvenli odeme'), findsOneWidget);
    expect(find.text('Siparis ozeti'), findsOneWidget);
  });
}
