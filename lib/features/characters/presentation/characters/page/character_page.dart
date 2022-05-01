// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_marvel/features/characters/domain/usecases/usecases.dart';
import 'package:my_marvel/features/characters/presentation/characters/bloc/bloc.dart';
import 'package:my_marvel/features/characters/presentation/characters/page/page.dart';

class CharacterPage extends StatelessWidget {
  const CharacterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
      ),
      body: BlocProvider(
        create: (_) => CharacterBloc(
          context.read<GetCharacters>(),
        )..add(CharacterFetched()),
        child: CharacterList(),
      ),
    );
  }
}
