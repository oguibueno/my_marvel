// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:my_marvel/features/characters/data/data.dart';
import 'package:my_marvel/features/characters/domain/domain.dart';
import 'package:my_marvel/features/characters/presentation/characters/bloc/bloc.dart';

class MockGetCharacters extends Mock implements GetCharacters {}

void main() {
  late MockGetCharacters mockGetCharacters;
  late CharacterBloc characterBloc;

  setUp(() {
    mockGetCharacters = MockGetCharacters();
    characterBloc = CharacterBloc(mockGetCharacters);
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

  const offset = 0;

  test(
    'initial state should be empty',
    () {
      expect(characterBloc.state, CharacterState());
    },
  );

  blocTest<CharacterBloc, CharacterState>(
    'should emit [success] when data is gotten successfully',
    build: () {
      when(() => mockGetCharacters.execute(offset))
          .thenAnswer((_) async => Right(data));
      return characterBloc;
    },
    act: (bloc) => bloc.add(CharacterFetched()),
    expect: () => [
      CharacterState(
        status: CharacterStatus.success,
        characters: data.results,
        hasReachedMax: false,
      ),
    ],
    verify: (bloc) {
      verify(() => mockGetCharacters.execute(offset));
    },
  );

  blocTest<CharacterBloc, CharacterState>(
    'should emit [success] when data has reached max is gotten successfully',
    build: () {
      when(() => mockGetCharacters.execute(offset)).thenAnswer(
        (_) async => Right(
          Data(
            count: 10,
            limit: 10,
            offset: 0,
            total: 100,
            results: [],
          ),
        ),
      );
      return characterBloc;
    },
    act: (bloc) => bloc.add(CharacterFetched()),
    expect: () => [
      CharacterState(
        status: CharacterStatus.success,
        characters: [],
        hasReachedMax: true,
      ),
    ],
    verify: (bloc) {
      verify(() => mockGetCharacters.execute(offset));
    },
  );

  blocTest<CharacterBloc, CharacterState>(
    'should emit [failure] when get data is unsuccessful',
    build: () {
      when(() => mockGetCharacters.execute(offset))
          .thenAnswer((_) async => Left(ServerFailure('Server failure')));
      return characterBloc;
    },
    act: (bloc) => bloc.add(CharacterFetched()),
    expect: () => [
      CharacterState(
        status: CharacterStatus.failure,
      ),
    ],
    verify: (bloc) {
      verify(() => mockGetCharacters.execute(offset));
    },
  );
}
