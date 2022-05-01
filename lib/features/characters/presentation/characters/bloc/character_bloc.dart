import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:my_marvel/features/characters/domain/entities/entities.dart';
import 'package:my_marvel/features/characters/domain/usecases/usecases.dart';

part 'character_event.dart';
part 'character_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetCharacters _getCharacters;

  CharacterBloc(this._getCharacters) : super(const CharacterState()) {
    on<CharacterFetched>(
      _onCharacterFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onCharacterFetched(
    CharacterEvent event,
    Emitter<CharacterState> emit,
  ) async {
    if (state.hasReachedMax) return;

    final result = await _getCharacters.execute(state.characters.length);

    result.fold(
      (failure) => emit(state.copyWith(status: CharacterStatus.failure)),
      (data) {
        if (data.results.isEmpty) {
          emit(state.copyWith(
            status: CharacterStatus.success,
            hasReachedMax: true,
          ));
        } else {
          emit(state.copyWith(
            status: CharacterStatus.success,
            characters: List.of(state.characters)..addAll(data.results),
            hasReachedMax: false,
          ));
        }
      },
    );
  }
}
