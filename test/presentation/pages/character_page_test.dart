// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route {}

class FakeCharacterState extends Fake implements CharacterState {}

class FakeCharacterEvent extends Fake implements CharacterEvent {}

void main() {
  late MockCharacterBloc mockCharacterBloc;
  late MockNavigatorObserver mockNavigatorObserver;

  setUpAll(() async {
    HttpOverrides.global = null;
    registerFallbackValue(FakeCharacterState());
    registerFallbackValue(FakeCharacterEvent());
    registerFallbackValue(FakeRoute());
  });

  setUp(() {
    mockCharacterBloc = MockCharacterBloc();
    mockNavigatorObserver = MockNavigatorObserver();
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
        navigatorObservers: [mockNavigatorObserver],
      ),
    );
  }

  testWidgets(
    'should show progress indicator when state is not success nor error',
    (WidgetTester tester) async {
      // arrange
      when(() => mockCharacterBloc.state).thenReturn(CharacterState(
        status: CharacterStatus.initial,
      ));

      // act
      await tester.pumpWidget(_makeTestableWidget(CharacterPage()));

      // assert
      expect(find.byType(CircularProgressIndicator), equals(findsOneWidget));
    },
  );

  testWidgets(
    'should show widget contain characters data when state is success with data',
    (WidgetTester tester) async {
      // arrange
      when(() => mockCharacterBloc.state).thenReturn(CharacterState(
        status: CharacterStatus.success,
        characters: data.results,
      ));

      // act
      await tester.pumpWidget(_makeTestableWidget(CharacterPage()));

      // assert
      expect(find.byKey(Key('list_item_card_character_1')),
          equals(findsOneWidget));
    },
  );

  testWidgets(
    'should show \'no characters to show\' when state is success with empty results',
    (WidgetTester tester) async {
      // arrange
      when(() => mockCharacterBloc.state).thenReturn(CharacterState(
        status: CharacterStatus.success,
      ));

      // act
      await tester.pumpWidget(_makeTestableWidget(CharacterPage()));

      // assert
      expect(find.byKey(Key('no_characters_to_show')), equals(findsOneWidget));
    },
  );

  testWidgets(
    'should show \'failed to fetch characters\' when state is failure',
    (WidgetTester tester) async {
      // arrange
      when(() => mockCharacterBloc.state).thenReturn(CharacterState(
        status: CharacterStatus.failure,
      ));

      // act
      await tester.pumpWidget(_makeTestableWidget(CharacterPage()));

      // assert
      expect(find.byKey(Key('failed_to_fetch_characters')),
          equals(findsOneWidget));
    },
  );

  testWidgets(
    'should dispatch on bloc the event CharacterFetched when scrolling to the bottom',
    (WidgetTester tester) async {
      // arrange
      when(() => mockCharacterBloc.state).thenReturn(CharacterState(
        status: CharacterStatus.success,
        characters: [
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
          Character(
            id: 2,
            name: 'Guilherme',
            description: 'Software Engineer',
            thumbnail: 'http://guilherme.jpg',
            comics: ['Bueno'],
            series: ['Bueno'],
            stories: ['Bueno'],
            events: ['Bueno'],
          ),
          Character(
            id: 3,
            name: 'Guilherme',
            description: 'Software Engineer',
            thumbnail: 'http://guilherme.jpg',
            comics: ['Bueno'],
            series: ['Bueno'],
            stories: ['Bueno'],
            events: ['Bueno'],
          ),
          Character(
            id: 4,
            name: 'Guilherme',
            description: 'Software Engineer',
            thumbnail: 'http://guilherme.jpg',
            comics: ['Bueno'],
            series: ['Bueno'],
            stories: ['Bueno'],
            events: ['Bueno'],
          ),
          Character(
            id: 5,
            name: 'Guilherme',
            description: 'Software Engineer',
            thumbnail: 'http://guilherme.jpg',
            comics: ['Bueno'],
            series: ['Bueno'],
            stories: ['Bueno'],
            events: ['Bueno'],
          ),
          Character(
            id: 6,
            name: 'Guilherme',
            description: 'Software Engineer',
            thumbnail: 'http://guilherme.jpg',
            comics: ['Bueno'],
            series: ['Bueno'],
            stories: ['Bueno'],
            events: ['Bueno'],
          ),
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
          Character(
            id: 7,
            name: 'Guilherme',
            description: 'Software Engineer',
            thumbnail: 'http://guilherme.jpg',
            comics: ['Bueno'],
            series: ['Bueno'],
            stories: ['Bueno'],
            events: ['Bueno'],
          ),
        ],
      ));

      // act
      await tester.pumpWidget(_makeTestableWidget(CharacterPage()));

      await tester.scrollUntilVisible(
          find.byKey(Key('list_item_card_character_7')), 300.0);

      verify(() => mockCharacterBloc.add(CharacterFetched()));
    },
  );

  testWidgets(
    'should navigate to character detail page when tapping on the list item',
    (WidgetTester tester) async {
      // arrange
      when(() => mockCharacterBloc.state).thenReturn(CharacterState(
        status: CharacterStatus.success,
        characters: data.results,
      ));

      // act
      await tester.pumpWidget(_makeTestableWidget(CharacterPage()));

      await tester.ensureVisible(find.byKey(Key('list_item_card_character_1')));

      await tester.tap(
        find.byKey(Key('list_item_card_character_1')),
      );

      // assert
      verify(() => mockNavigatorObserver.didPush(any(), any()));
    },
  );
}
