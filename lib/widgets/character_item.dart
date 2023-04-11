import 'package:flutter/material.dart';
import 'package:myapp/constant.dart';
import 'package:myapp/model/basic_character_model.dart';
import 'package:myapp/pages/character_detail_page.dart';

class CharacterWidget extends StatelessWidget {
  final BasicCharacter item;

  const CharacterWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetailsPage(character: item),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.blue,
                    ),
                  ]),
              w16SizedBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name!,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  h8SizedBox,
                  Text(
                    'UID: ${item.uid}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
