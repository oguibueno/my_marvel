// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_marvel/features/characters/domain/entities/entities.dart';

import 'package:my_marvel/features/characters/presentation/characters/bloc/bloc.dart';
import 'package:my_marvel/features/characters/presentation/widgets/widgets.dart';
import 'package:my_marvel/features/characters/presentation/characters/page/page.dart';

class CharacterList extends StatefulWidget {
  @override
  State<CharacterList> createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        switch (state.status) {
          case CharacterStatus.success:
            if (state.characters.isEmpty) {
              return const Center(child: Text('no characters'));
            }

            final itemCount = state.hasReachedMax
                ? state.characters.length
                : state.characters.length + 1;

            return ListView.builder(
              itemBuilder: (context, index) {
                if (index >= state.characters.length) {
                  return BottomLoader();
                }

                return SlideAnimation(
                  itemCount: itemCount,
                  index: index,
                  animationController: _animationController,
                  child: ListItemCard(
                    character: state.characters[index],
                    onTap: () => _navigateToDetailPage(state.characters[index]),
                  ),
                );
              },
              itemCount: itemCount,
              controller: _scrollController,
            );
          case CharacterStatus.failure:
            return const Center(child: Text('failed to fetch characters'));
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<CharacterBloc>().add(CharacterFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _navigateToDetailPage(Character character) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return CharacterDetail(
            character: character,
          );
        },
        transitionDuration: Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
            curve: Curves.fastOutSlowIn,
            parent: animation,
          );
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        },
      ),
    );
  }
}
