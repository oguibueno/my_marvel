import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import 'package:my_marvel/features/characters/data/data.dart';

import '../../helpers/json_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late RemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get characters', () {
    const jsonPath = 'helpers/characters_response.json';

    final dataModel = DataModel.fromJson(
      (json.decode(readJson(jsonPath))['data']),
    );

    test(
      'should return character model when the response code is 200',
      () async {
        // arrange
        when(
          () => mockHttpClient.get(Uri.parse(Urls.characters(10, 0))),
        ).thenAnswer(
          (_) async => http.Response(
            readJson(jsonPath),
            200,
          ),
        );

        // act
        final result = await dataSource.getCharacters(0);

        // assert
        expect(result, equals(dataModel));
      },
    );

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(
          () => mockHttpClient.get(Uri.parse(Urls.characters(10, 0))),
        ).thenAnswer(
          (_) async => http.Response('Not found', 404),
        );

        // act
        final call = dataSource.getCharacters(0);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
