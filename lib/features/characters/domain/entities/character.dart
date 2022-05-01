import 'package:equatable/equatable.dart';

class Character extends Equatable {
  const Character({
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
