import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:my_marvel/features/characters/data/data.dart';
import 'package:my_marvel/features/characters/domain/domain.dart';
import 'package:my_marvel/features/characters/presentation/presentation.dart';

final getIt = GetIt.instance;

void init() {
  getIt.registerFactory(() => CharacterBloc(getIt()));
  getIt.registerLazySingleton(() => GetCharacters(getIt()));
  getIt.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(client: getIt()),
  );
  getIt.registerLazySingleton(() => http.Client());
}
