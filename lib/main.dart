// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:my_marvel/features/characters/presentation/presentation.dart';
import 'package:my_marvel/features/characters/data/datasources/datasources.dart';
import 'package:my_marvel/features/characters/data/repositories/repositories.dart';
import 'package:my_marvel/features/characters/domain/usecases/usecases.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => GetCharacters(
            CharacterRepositoryImpl(
              remoteDataSource: RemoteDataSourceImpl(
                client: http.Client(),
              ),
            ),
          ),
        ),
      ],
      child: App(),
    ),
  );
}

class App extends MaterialApp {
  App()
      : super(
          home: BlocProvider(
            create: (context) => CharacterBloc(
              context.read<GetCharacters>(),
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
