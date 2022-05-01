// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CharacterSeries extends StatelessWidget {
  const CharacterSeries(this.series);

  final List<String> series;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: series
          .map(
            (serie) => Card(
              child: ListTile(
                title: Text(serie),
              ),
            ),
          )
          .toList(),
    );
  }
}
