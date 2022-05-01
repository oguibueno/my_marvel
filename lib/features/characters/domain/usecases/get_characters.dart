import 'package:dartz/dartz.dart';
import 'package:my_marvel/features/characters/data/common/failure.dart';
import 'package:my_marvel/features/characters/domain/entities/entities.dart';
import 'package:my_marvel/features/characters/domain/repositories/character_repository.dart';

class GetCharacters {
  final CharacterRepository repository;

  GetCharacters(this.repository);

  Future<Either<Failure, Data>> execute(int offset) {
    return repository.getCharacters(offset);
  }
}
