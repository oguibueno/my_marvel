import 'package:equatable/equatable.dart';
import 'package:my_marvel/features/characters/domain/entities/character.dart';

class CharacterModel extends Equatable {
  const CharacterModel({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.comics,
    required this.series,
    required this.stories,
    required this.events,
  });

  final int id;
  final String name;
  final String description;
  final String thumbnail;
  final List<String> comics;
  final List<String> series;
  final List<String> stories;
  final List<String> events;

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        thumbnail: json['thumbnail']['path'],
        comics: (json['comics']['items'] as List)
            .map((comic) => comic['name'] as String)
            .toList(),
        series: (json['series']['items'] as List)
            .map((comic) => comic['name'] as String)
            .toList(),
        stories: (json['stories']['items'] as List)
            .map((comic) => comic['name'] as String)
            .toList(),
        events: (json['events']['items'] as List)
            .map((comic) => comic['name'] as String)
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'thumbnail': thumbnail,
        'comics': comics,
        'series': series,
        'stories': stories,
        'events': events,
      };

  Character toEntity() => Character(
        id: id,
        name: name,
        description: description,
        thumbnail: thumbnail,
        comics: comics,
        series: series,
        stories: stories,
        events: events,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        thumbnail,
        comics,
        series,
        stories,
        events,
      ];
}
