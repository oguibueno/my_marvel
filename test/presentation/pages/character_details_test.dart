// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:my_marvel/features/characters/domain/domain.dart';
import 'package:my_marvel/features/characters/presentation/presentation.dart';

class MockCharacterBloc extends MockBloc<CharacterEvent, CharacterState>
    implements CharacterBloc {}

class FakeCharacterState extends Fake implements CharacterState {}

class FakeCharacterEvent extends Fake implements CharacterEvent {}

void main() {
  late MockCharacterBloc mockCharacterBloc;

  setUpAll(() async {
    HttpOverrides.global = null;
    registerFallbackValue(FakeCharacterState());
    registerFallbackValue(FakeCharacterEvent());
  });

  setUp(() {
    mockCharacterBloc = MockCharacterBloc();
  });

  const data = Data(
    count: 10,
    limit: 10,
    offset: 0,
    total: 100,
    results: [
      Character(
        id: 1,
        name: 'Guilherme',
        description: 'Software Engineer',
        thumbnail: 'http://guilherme.jpg',
        comics: ['Bueno'],
        series: ['Bueno'],
        stories: ['Bueno'],
        events: ['Bueno'],
      ),
    ],
  );

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<CharacterBloc>.value(
      value: mockCharacterBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'should show widgets: comics, events, series, stories when state is success with data',
    (WidgetTester tester) async {
      // arrange
      when(() => mockCharacterBloc.state).thenReturn(CharacterState(
        status: CharacterStatus.success,
        characters: data.results,
      ));

      // act
      await tester.pumpWidget(_makeTestableWidget(CharacterDetail(
        character: data.results.first,
      )));

      // assert
      expect(find.byType(CharacterComics), equals(findsOneWidget));

      await tester.tap(find.text('Series'));
      await tester.pumpAndSettle();

      expect(find.byType(CharacterSeries), equals(findsOneWidget));

      await tester.tap(find.text('Stories'));
      await tester.pumpAndSettle();

      expect(find.byType(CharacterStories), equals(findsOneWidget));

      await tester.tap(find.text('Events'));
      await tester.pumpAndSettle();

      expect(find.byType(CharacterEvents), equals(findsOneWidget));
    },
  );
}
