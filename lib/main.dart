// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_marvel/features/characters/presentation/presentation.dart';
import 'package:my_marvel/features/characters/domain/usecases/usecases.dart';

import 'package:my_marvel/startup.dart' as startup;

void main() {
  startup.init();
  runApp(App());
}

class App extends MaterialApp {
  App()
      : super(
          home: BlocProvider(
            create: (_) => CharacterBloc(
              startup.getIt<GetCharacters>(),
            )..add(CharacterFetched()),
            child: CharacterPage(),
          ),
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: Colors.grey[900],
            ),
            scaffoldBackgroundColor: Colors.grey[900],
          ),
        );
}
