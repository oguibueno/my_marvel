// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:my_marvel/features/characters/presentation/presentation.dart';

class CharacterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('characters_page'),
      appBar: AppBar(
        title: Text('Characters'),
      ),
      body: CharacterList(),
    );
  }
}
