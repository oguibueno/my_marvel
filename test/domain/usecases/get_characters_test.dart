// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:my_marvel/features/characters/domain/domain.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  late MockCharacterRepository mockCharacterRepository;
  late GetCharacters usecase;

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    usecase = GetCharacters(mockCharacterRepository);
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
      ),
    ],
  );

  const offset = 0;

  test(
    'should get characters from the repository',
    () async {
      // arrange
      when(() => mockCharacterRepository.getCharacters(offset))
          .thenAnswer((_) async => const Right(data));

      // act
      final result = await usecase.execute(offset);

      // assert
      expect(result, equals(Right(data)));
    },
  );
}
