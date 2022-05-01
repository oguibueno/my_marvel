// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_marvel/features/characters/domain/domain.dart';
import 'package:my_marvel/features/characters/presentation/widgets/widgets.dart';

void main() {
  setUpAll(() => HttpOverrides.global = null);

  testWidgets(
    'should show slide animation',
    (WidgetTester tester) async {
      // act
      await tester.pumpWidget(
        MaterialApp(
          home: SlideAnimation(
            index: 1,
            itemCount: 10,
            animationController: AnimationController(
              vsync: TestVSync(),
              duration: Duration(seconds: 1),
            ),
            child: ListItemCard(
              character: Character(
                id: 1,
                name: 'Guilherme',
                description: 'Software Engineer',
                thumbnail: 'http://guilherme',
              ),
              onTap: () => {},
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // assert
      expect(find.byKey(Key('slide_animation')), equals(findsOneWidget));
    },
  );
}
