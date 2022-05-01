// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:my_marvel/features/characters/domain/entities/entities.dart';

class ListItemCard extends StatelessWidget {
  final Character character;
  final VoidCallback onTap;

  const ListItemCard({
    Key? key,
    required this.character,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[900],
      key: Key('list_item_card_character_${character.id}'),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 120,
          margin: EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 9.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 122, 118, 118).withAlpha(200),
                blurRadius: 10.0,
              ),
            ],
            image: DecorationImage(
              image: NetworkImage(
                '${character.thumbnail}/portrait_uncanny.jpg',
              ),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  character.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(top: 10, right: 13.0),
                    child: Text(
                      character.description.isNotEmpty
                          ? character.description
                          : '--',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
