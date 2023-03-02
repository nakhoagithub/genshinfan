import 'dart:developer';
import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:genshinfan/objects/app/contribute_character.dart';

class ContributeCharacterService {
  Future<bool> contribute(ContributeCharacter contributeCharacter) async {
    DatabaseReference db =
        FirebaseDatabase.instance.ref("contribution_management");
    try {
      await db
          .child(contributeCharacter.character)
          .push()
          .update(contributeCharacter.toJson())
          .then((value) => value);
      return true;
    } catch (e) {
      log("$e", name: "contribute");
      return false;
    }
  }
}
