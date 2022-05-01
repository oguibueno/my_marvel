import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_marvel/features/characters/data/common/common.dart';
import 'package:my_marvel/features/characters/data/models/models.dart';

abstract class RemoteDataSource {
  Future<DataModel> getCharacters(int offset);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<DataModel> getCharacters(int offset) async {
    const limit = 10;

    final response = await client.get(
      Uri.parse(Urls.characters(limit, offset)),
    );

    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      return DataModel.fromJson(map['data']);
    } else {
      throw ServerException();
    }
  }
}
