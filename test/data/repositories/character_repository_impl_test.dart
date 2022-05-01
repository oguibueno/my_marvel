// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:my_marvel/features/characters/data/data.dart';
import 'package:my_marvel/features/characters/domain/domain.dart';

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late CharacterRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = CharacterRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  const dataModel = DataModel(
    count: 10,
    limit: 10,
    offset: 0,
    total: 100,
    results: [
      CharacterModel(
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

  group('get characters', () {
    const offset = 0;

    test(
      'should return characters when a call to data source is successful',
      () async {
        // arrange
        when(() => mockRemoteDataSource.getCharacters(offset))
            .thenAnswer((_) async => dataModel);

        // act
        final result = await repository.getCharacters(offset);

        // assert
        verify(() => mockRemoteDataSource.getCharacters(offset));
        expect(result, equals(Right(data)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(() => mockRemoteDataSource.getCharacters(offset))
            .thenThrow(ServerException());

        // act
        final result = await repository.getCharacters(offset);

        // assert
        verify(() => mockRemoteDataSource.getCharacters(offset));
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(() => mockRemoteDataSource.getCharacters(offset))
            .thenThrow(SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getCharacters(offset);

        // assert
        verify(() => mockRemoteDataSource.getCharacters(offset));
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });
}
