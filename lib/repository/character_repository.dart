import 'package:flutter/foundation.dart';
import "package:collection/collection.dart";
import 'package:myapp/model/basic_character_model.dart';
import 'package:myapp/model/dashboard_details_model.dart';
import 'package:myapp/model/detail_character_model.dart';
import 'package:myapp/service/character_service.dart';

class CharacterListModel with ChangeNotifier {
  final List<BasicCharacter> _basicCharacters = [];
  final Map<String, DetailCharacter> _detailedCharacters = {};
  bool _isLoading = false;
  bool _hasError = false;
  bool _isLastPage = false;
  bool _isInitialized = false;
  int _currentPage = 1;

  List<BasicCharacter> get items => [..._basicCharacters];
  Map<String, DetailCharacter> get characters => {..._detailedCharacters};
  bool get isLoading => _isLoading;
  bool get isInitialized => _isInitialized;
  bool get hasError => _hasError;
  int get currentPage => _currentPage;

  bool hasCharacterDetails(String characterId) {
    return _detailedCharacters.containsKey(characterId);
  }

  DetailCharacter? getCharacterDetails(String characterId) {
    return _detailedCharacters[characterId];
  }

  DashboardDetails getDashboardDetails() {
    var totalOfCharacters = items.length;
    var totalOfDetailedCharacters = characters.length;

    var averageHeight = totalOfDetailedCharacters != 0
        ? (characters.values
                    .map((x) => int.parse(x.height!))
                    .fold(0, (a, b) => a + b) /
                totalOfDetailedCharacters)
            .round()
        : '-';
    var averageMass = totalOfDetailedCharacters != 0
        ? (characters.values
                    .map((x) => int.parse(x.mass!))
                    .fold(0, (a, b) => a + b) /
                totalOfDetailedCharacters)
            .round()
        : '-';
    var mostRepresentedGender = totalOfDetailedCharacters != 0
        ? groupBy(characters.values,
                (DetailCharacter character) => character.gender)
            .entries
            .reduce((a, b) => a.value.length > b.value.length ? a : b)
            .key
        : '-';

    return DashboardDetails(
        totalOfCharacters: totalOfCharacters,
        totalOfDetailedCharacters: totalOfDetailedCharacters,
        averageHeight: averageHeight.toString(),
        averageMass: averageMass.toString(),
        mostRepresentedGender: mostRepresentedGender!);
  }

  Future<void> loadMoreData() async {
    if (_isLoading || _hasError) {
      return;
    }

    if (!_isLastPage) {
      _isLoading = true;
      notifyListeners();

      try {
        final response =
            await CharacterService().getBasicCharacters(_currentPage, 20);
        if (response.hasNextPage) {
          _basicCharacters.addAll(response.characters);
          _currentPage++;
        } else {
          _isLastPage = true;
        }
      } catch (e) {
        print(e);
        _hasError = true;
      }

      _isInitialized = true;

      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCharacterDetails(String id) async {
    if (_isLoading || _hasError) {
      return;
    }

    _isLoading = true;
    notifyListeners();
    final character =
        _detailedCharacters.containsKey(id) ? _detailedCharacters[id] : null;

    if (character != null) return;

    final basicCharacter = items.firstWhere((item) => item.uid == id);

    final characterDetails =
        await CharacterService.fetchCharacterDetail(basicCharacter.url!);
    _detailedCharacters.putIfAbsent(id, () => characterDetails);

    _isLoading = false;
    notifyListeners();
  }
}
