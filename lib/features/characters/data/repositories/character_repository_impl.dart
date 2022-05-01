import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:my_marvel/features/characters/data/common/common.dart';
import 'package:my_marvel/features/characters/data/datasources/remote_data_source.dart';
import 'package:my_marvel/features/characters/domain/entities/entities.dart';
import 'package:my_marvel/features/characters/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final RemoteDataSource remoteDataSource;

  CharacterRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Data>> getCharacters(int offset) async {
    try {
      final data = await remoteDataSource.getCharacters(offset);
      return Right(data.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
