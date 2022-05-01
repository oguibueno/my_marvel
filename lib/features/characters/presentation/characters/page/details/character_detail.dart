// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:my_marvel/features/characters/domain/entities/entities.dart';
import 'package:my_marvel/features/characters/presentation/characters/page/page.dart';
import 'package:my_marvel/features/characters/presentation/widgets/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CharacterDetail extends StatelessWidget {
  final Character character;

  const CharacterDetail({required this.character});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: Material(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SlidingUpPanel(
              maxHeight: size.height * .80,
              minHeight: 320.0,
              parallaxEnabled: true,
              parallaxOffset: .5,
              body: Hero(
                tag: "pic",
                child: Image.network(
                  '${character.thumbnail}/portrait_incredible.jpg',
                  height: size.height * .55,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
              ),
              panelBuilder: (scrollController) => _Content(
                context: context,
                character: character,
                scrollController: scrollController,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
    required this.context,
    required this.character,
    required this.scrollController,
  }) : super(key: key);

  final BuildContext context;
  final Character character;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      key: Key('content_slide_panel'),
      context: context,
      removeTop: true,
      child: ListView(
        controller: scrollController,
        children: <Widget>[
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 18.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Details',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 24.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 36.0),
          Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Description',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  character.description,
                  softWrap: true,
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          NestedTabBar(
            {
              Tab(text: "Comics"): CharacterComics(character.comics),
              Tab(text: "Series"): CharacterSeries(character.series),
              Tab(text: "Stories"): CharacterStories(character.stories),
              Tab(text: "Events"): CharacterEvents(character.events),
            },
          ),
        ],
      ),
    );
  }
}
