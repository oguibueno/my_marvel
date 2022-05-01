import 'package:equatable/equatable.dart';
import 'package:my_marvel/features/characters/data/data.dart';
import 'package:my_marvel/features/characters/domain/entities/entities.dart';

class DataModel extends Equatable {
  const DataModel({
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
  final List<CharacterModel> results;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        offset: json['offset'],
        limit: json['limit'],
        total: json['total'],
        count: json['count'],
        results: (json['results'] as List)
            .map((result) => CharacterModel.fromJson(result))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'offset': offset,
        'limit': limit,
        'total': total,
        'count': count,
        'results': results.map((result) => result.toJson()).toList(),
      };

  Data toEntity() => Data(
        offset: offset,
        limit: limit,
        total: total,
        count: count,
        results: results.map((result) => result.toEntity()).toList(),
      );

  @override
  List<Object?> get props => [
        offset,
        limit,
        total,
        count,
        results,
      ];
}
