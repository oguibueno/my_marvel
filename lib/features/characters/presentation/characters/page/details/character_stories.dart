// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CharacterStories extends StatelessWidget {
  const CharacterStories(this.stories);

  final List<String> stories;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: stories
          .map(
            (story) => Card(
              child: ListTile(
                title: Text(story),
              ),
            ),
          )
          .toList(),
    );
  }
}
