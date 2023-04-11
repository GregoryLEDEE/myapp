import 'package:flutter/material.dart';
import 'package:myapp/constant.dart';
import 'package:myapp/model/basic_character_model.dart';
import 'package:myapp/repository/character_repository.dart';
import 'package:provider/provider.dart';

class CharacterDetailsPage extends StatefulWidget {
  final BasicCharacter character;

  const CharacterDetailsPage({super.key, required this.character});

  @override
  _CharacterDetailPageState createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailsPage> {
  late CharacterListModel _characterProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _characterProvider = Provider.of<CharacterListModel>(context);

    if (!_characterProvider.hasCharacterDetails(widget.character.uid!)) {
      _characterProvider.fetchCharacterDetails(widget.character.uid!);
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.character.name ?? ''),
      ),
      body: _characterProvider.isLoading
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                h16SizedBox,
                Text('Loading data for the character ${widget.character.name}')
              ],
            ))
          : _buildDetails(context),
    );
  }

  Widget _buildDetails(BuildContext context) {
    final detailedCharacter =
        _characterProvider.getCharacterDetails(widget.character.uid!);
    if (detailedCharacter == null) {
      return const Center(child: Text('Failed to load character details.'));
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 100,
            ),
            h32SizedBox,
            Text('Name: ${detailedCharacter.name}'),
            h16SizedBox,
            Text('Birth year: ${detailedCharacter.birthYear}'),
            h16SizedBox,
            Text('UID: ${detailedCharacter.uid}'),
            h16SizedBox,
            Text('URL: ${detailedCharacter.url}'),
            h16SizedBox,
            Text('Home world: ${detailedCharacter.homeworld}'),
            h16SizedBox,
            Text('Description: ${detailedCharacter.description}'),
            h16SizedBox,
            Text('Height: ${detailedCharacter.height}'),
            h16SizedBox,
            Text('Mass: ${detailedCharacter.mass}'),
            h16SizedBox,
            Text('Hair color: ${detailedCharacter.hairColor}'),
            h16SizedBox,
            Text('Skin color: ${detailedCharacter.skinColor}'),
            h16SizedBox,
            Text('Eye color: ${detailedCharacter.eyeColor}'),
            h16SizedBox,
            Text('Gender: ${detailedCharacter.gender}'),
          ],
        ),
      ),
    );
  }
}
