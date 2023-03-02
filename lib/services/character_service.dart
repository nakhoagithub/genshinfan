import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../objects/character.dart';

class CharacterService {
  Future<void> getCharacterFromGzip(
      Directory directory, String language, dynamic json) async {
    List<dynamic> characters = [];
    dynamic data = json['data'];
    dynamic image = json['image'];
    dynamic stat = json['stats'];
    dynamic curve = json['curve'];

    dynamic jsonData = data[language]['characters'];
    dynamic img = image['characters'];
    dynamic talent = data[language]['talents'];
    dynamic imgTalent = image['talents'];
    dynamic statTalent = stat['talents'];
    dynamic constellations = data[language]['constellations'];
    dynamic imgConstellation = image['constellations'];
    dynamic statCharacter = stat['characters'];
    dynamic curveCharacter = curve['characters'];
    for (var k in jsonData.keys) {
      Character obj = Character.fromJson(jsonData[k]);
      obj.id = k;
      // hình ảnh
      obj.setImage(img[k]);
      obj.setTalent(k, talent, imgTalent, statTalent);
      obj.setConstellation(k, constellations, imgConstellation);
      obj.setStat(statCharacter[k], curveCharacter);
      characters.add(obj.toJson());
    }
    File fileCharacter = File("${directory.path}/$language/characters.json");
    await fileCharacter.create(recursive: true);
    await fileCharacter.writeAsString(jsonEncode(characters).toString());
  }

  Future<List<Character>?> getCharacters(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      File file = File("${directory.path}/$language/characters.json");
      String json = await file.readAsString();
      List<Character> characters = List<Character>.from(
          jsonDecode(json).map((e) => Character.fromJson(e))).toList();
      return characters;
    }
    return null;
  }
}
