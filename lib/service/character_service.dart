import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/model/basic_character_model.dart';
import 'package:myapp/model/detail_character_model.dart';

class CharacterResponse {
  List<BasicCharacter> characters;
  bool hasNextPage;

  CharacterResponse({required this.hasNextPage, required this.characters});
}

class CharacterService {
  static const int _perPage = 20;
  static const String baseUrl = 'https://www.swapi.tech/api/people';

  Future<CharacterResponse> getBasicCharacters(int page, int? limit) async {
    final response = await http
        .get(Uri.parse('$baseUrl?page=$page&limit=${limit ?? _perPage}'));

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      List? listOfJsonCharacters = data?['results'];
      var characters =
          listOfJsonCharacters!.map((x) => BasicCharacter.fromJson(x)).toList();
      bool hasNextPage = (data['next'] != null && data['next'].isNotEmpty);

      return CharacterResponse(
          hasNextPage: hasNextPage, characters: characters);
    } else {
      throw Exception('Failed to load characters');
    }
  }

  static Future<DetailCharacter> fetchCharacterDetail(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      Map<String, dynamic> jsonCharacter = data?['result'];
      return DetailCharacter.fromJson(jsonCharacter);
    } else {
      throw Exception('Failed to fetch character detail');
    }
  }
}
