import 'package:dartz/dartz.dart';
import 'package:my_marvel/features/characters/data/common/failure.dart';
import 'package:my_marvel/features/characters/domain/entities/entities.dart';

abstract class CharacterRepository {
  Future<Either<Failure, Data>> getCharacters(int offset);
}
