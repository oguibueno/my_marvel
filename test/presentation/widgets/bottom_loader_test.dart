// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_marvel/features/characters/presentation/widgets/widgets.dart';

void main() {
  testWidgets(
    'should show bottom loader',
    (WidgetTester tester) async {
      // act
      await tester.pumpWidget(MaterialApp(home: BottomLoader()));

      // assert
      expect(find.byKey(Key('bottom_loader')), equals(findsOneWidget));
    },
  );
}
