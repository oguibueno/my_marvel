// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CharacterComics extends StatelessWidget {
  const CharacterComics(this.comics);

  final List<String> comics;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: comics
          .map(
            (comic) => Card(
              child: ListTile(
                title: Text(comic),
              ),
            ),
          )
          .toList(),
    );
  }
}
