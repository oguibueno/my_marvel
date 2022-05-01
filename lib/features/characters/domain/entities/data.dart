import 'package:equatable/equatable.dart';
import 'package:my_marvel/features/characters/domain/entities/character.dart';

class Data extends Equatable {
  const Data({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.results,
  });

  final int offset;
  final int limit;
  final int total;
  final int count;
  final List<Character> results;

  @override
  List<Object?> get props => [
        offset,
        limit,
        total,
        count,
        results,
      ];
}
