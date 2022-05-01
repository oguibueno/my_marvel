// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_marvel/features/characters/domain/domain.dart';

import 'package:my_marvel/features/characters/presentation/widgets/widgets.dart';

void main() {
  setUpAll(() => HttpOverrides.global = null);

  testWidgets(
    'should show list item card loader',
    (WidgetTester tester) async {
      // act
      await tester.pumpWidget(
        MaterialApp(
          home: ListItemCard(
            character: Character(
              id: 1,
              name: 'Guilherme',
              description: 'Software Engineer',
              thumbnail: 'http://guilherme',
              comics: ['Bueno'],
              series: ['Bueno'],
              stories: ['Bueno'],
              events: ['Bueno'],
            ),
            onTap: () => {},
          ),
        ),
      );

      // assert
      expect(find.byKey(Key('list_item_card_character_1')),
          equals(findsOneWidget));
    },
  );
}
