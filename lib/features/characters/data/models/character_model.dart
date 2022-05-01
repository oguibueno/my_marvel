import 'package:equatable/equatable.dart';
import 'package:my_marvel/features/characters/domain/entities/character.dart';

class CharacterModel extends Equatable {
  const CharacterModel({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
  });

  final int id;
  final String name;
  final String description;
  final String thumbnail;

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        thumbnail: json['thumbnail']['path'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'thumbnail': thumbnail,
      };

  Character toEntity() => Character(
        id: id,
        name: name,
        description: description,
        thumbnail: thumbnail,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        thumbnail,
      ];
}
