import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:my_marvel/features/characters/data/data.dart';
import 'package:my_marvel/features/characters/domain/domain.dart';

import '../../helpers/json_reader.dart';

void main() {
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
      ),
    ],
  );

  group('to entity', () {
    test(
      'should be a subclass of character entity',
      () async {
        // assert
        final result = dataModel.toEntity();
        expect(result, equals(data));
      },
    );
  });

  group('from json', () {
    const jsonPath = 'helpers/characters_response.json';

    test(
      'should return a valid model from json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          readJson(jsonPath),
        );

        // act
        final result = DataModel.fromJson(jsonMap['data']);

        // assert
        expect(result, equals(dataModel));
      },
    );
  });

  group('to json', () {
    test(
      'should return a json map containing proper data',
      () async {
        // act
        final result = dataModel.toJson();

        // assert
        final expectedJsonMap = {
          'count': 10,
          'limit': 10,
          'offset': 0,
          'total': 100,
          'results': [
            {
              'id': 1,
              'name': 'Guilherme',
              'description': 'Software Engineer',
              'thumbnail': 'http://guilherme.jpg',
            }
          ],
        };
        expect(result, equals(expectedJsonMap));
      },
    );
  });
}
