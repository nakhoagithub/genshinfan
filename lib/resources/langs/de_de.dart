import 'dart:ui';

import 'package:genshinfan/objects/app/language.dart';

// Đức

const german = Language(
  languageCode: "German",
  language: "Deutsch",
  locale: Locale("de", 'DE'),
);

const Map<String, String> de = {
  "welcome_to_app": "Welcome to Genshin Fan",
  "version": "Version @version",

  "loading": "Lädt...",
  "downloading": "@percent% Heruntergeladen",
  "decompressing": "Dekomprimieren...",
  "processing": "Verarbeiten",
  "checking": "Überprüfung",
  "no_data_version": "Es gibt keine neue Datenversion",
  "update_new_data": "Neue Daten aktualisieren",
  "complete": "Fertig!",
  "wait_a_minute": "Warten sie bitte",
  "data_failure":
      "Es ist nicht möglich die daten herunterzuladen! Bitte überprüfen sie ihre Netzwerkverbindung.",
  "not_internet": "Netzwerkverbindung fehlgeschlagen!",
  "setting": "Einstellungen",
  "dark_theme": "Dunkel Modus",
  "change_language": "Sprache ändern",
  "select_language": "Sprache wählen",
  "character": "Charakter",
  "weapon": "Waffe",
  "teyvat_resource": "Teyvats Ressourcen",
  "food": "Essen",
  "artifact": "Artefakt",
  "domain": "Sphäre",
  "animal": "Tier",
  "enemy": "Gegner",
  "achievement": "Errungenschaft",
  "windglider": "Windgleiter",
  "forging_recipe": "Schmiederezept",
  "namecard": "Namenskärtchen",
  "outfit": "Outfit",
  "select_character": "Bitte wählen sie einen Charakter",
  "element": "Element",
  "rarity": "Seltenheit",
  "especially": "Besonders",
  "information": "Information",
  "character_information": "Charakter Information",
  "substat": "Substat",
  "gender": "Geschlecht",
  "birthday": "Geburtstag",
  "travelerBirthday": "Geburtstag des Reisenden",
  "affiliation": "Beziehung",
  "region": "Region",
  "description": "Beschreibung",
  "skill": "Fertigkeit",
  "skill_passive": "Passiv",
  "constellation": "Sternbild",
  "ascension": "Aufstieg",
  "level": "Level",
  "ascend": "Aufstieg",
  "resource": "Ressourcen",
  "skill_ascension": "Aufstieg der Fertigkeit",
  "stats": "Statistiken",
  "weapon_information": "Waffeninformationen",
  "talent_stats": "Skill-Statistiken",
  "select_weapon": "Bitte wähle eine Waffe aus",
  "refinement": "Weiterentwicklung",
  "type": "Typ",
  "story": "Geschichte",
  "effectname": "Name des Effekts",
  "resource_information": "Information der Ressourcen",
  "select_resource": "Bitte wähle Ressourcen",
  "dupealias": "Mehr Informationen",
  "source": "Quelle",
  "days_of_week": "Tage der Woche",
  "artifact_information": "Artefakten Information",
  "select_artifact": "Bitte wähle ein Artefakt",
  "set1": "Aktiviere ein Item",
  "set2": "Aktiviere Set mit 2 Teilen",
  "set4": "Aktiviere Set mit 4 Teilen",
  "domain_information": "Sphären Information",
  "select_domain": "Bitte wähle eine Sphäre",
  "domainentrance": "Eingang",
  "recommendedlevel": "Empfohlenes Level",
  "unlockrank": "Entsperre den Rang",
  "recommendedelements": "Empfohlene Elemente",
  "disorder": "Störung",
  "reward": "Belohnung",
  "select_enemy": "Bitte wähle einen Gegner",
  "enemy_information": "Gegner Information",
  "monster": "Monster",
  "specialname": "Spezial Name",
  "notification": "Benachrichtigung",
  "notification_change_language":
      "Nachdem sie die Sprache geändert haben, wird das Programm neu starten um die daten der von ihnen ausgewählten Sprache zu laden.",
  "cancel": "Abbrechen",
  "ok": "Zustimmen",
  "double_click_exit": "Tippen sie nochmal, um die App zu verlassen",
  "today": "Heute",
  "birthday_in_month": "Geburtstage dieses Monats",
  "option": "Option",
  "success": "Erfolgreich",
  "not": "Nicht",
  "note": "Notiz",
  "daily_reset_time":
      "<b>Tägliche Wiederholung</b> findet immer um 04:00 (4 Uhr morgens) statt, basierend auf der Uhrzeit der verschiedenen Servern.\n\n  - Server Asien (AS): GMT +8\n - Server Europa (EU): GMT+1\n - Server Amerika (NA): GMT-5",
  "character_up_today":
      "Charaktere können verschiedene Verbesserungsmaterialien während des Tages finden.",
  "weapon_up_today":
      "Waffen können verschiedene Verbesserungsmaterialien während des Tages finden.",
  "genshin_map": "Genshin Karte",
  "notification_open_genshin_map":
      "Möchten sie die <b>Genshin Karte</b> in ihrem Browser öffnen?",
  "update": "Update",
  "check_update": "Suche nach Update",
  "description_update_setting":
      "Checken und Updaten der daten für die Anwendung.",
  "contribute": "Beitrag",
  "character_building": "Charakter bauen",
  "contribute_translation": "zur Übersetzung beitragen",
  "send_feedback": "Feedback senden",
  "description_send_feedback": "Schicken sie eine E-mail an den Entwickler.",
  "other": "Anderes",
  "join_discord": "Joine dem Discord server.",
  "confirm": "Bestätigen",
  "access_throughput": "Zugriffsdurchsatz",
  "total": "Total",
  "this_month": "Diesen Monat",
  "set2_artifact": "Set von 2 Artefakten",
  "set4_artifact": "Set von 4 Artefakten",
  "sands_effect": "Sand Effekte",
  "goblet_effect": "Kelch Effekte",
  "circlet_effect": "Haarreif Effekte",
  "user_information": "Benutzer Information",
  "login": "Anmeldung",
  "logout_question": "Möchten sie sich abmelden?",
  "refresh_traffic": "Aktualisieren?",
  "required_login": "Sie müssen sich für diese Funktion einloggen.",
  "admin": "Administrator",
  "admin_description": "Bewerbungsmanagement",
  "user_management": "Benutzer Management",
  "data_management": "Daten Management",
  "manager": "Manager",
  "contribution_character": "Charakter Beitrag",
  "role_and_data_user": "Nutzungsbedingungen und Daten",
  "manage_user_character_contribution":
      "Verwalten Sie den Charakterbeitrag des Benutzers.",
  "select_full_info": "Sie müssen die Informationen vollständig auswählen.",
  "author": "Autor",
  "invalid": "Ungültig",
  "delete": "Löschen",
  "delete_contribute": "Möchten sie diesen User Beitrag löschen?",
  "add_contribute_to_database":
      "Möchten sie diesen Beitrag zur Datenbank hinzufügen?",
  "delete_contribute_to_database": "Möchten sie diesen Beitrag löschen?",
  "contribute_manage_empty": "Noch keine Beiträge vorhanden",
  "censor": "Zensieren",
  "member": "Member",
  "permission": "Erlaubnis",
  "permission_denied": "Verweigerte Erlaubnis",
  "error": "Error",
  "note_contribute_character_building":
      "Diese beigertagenen Daten werden von den Moderatoren eingesehen und bestätigt.",
  "timeout_exception": "Timeout-Ausnahme",
  "reset": "Zurücksetzten",
  "filter_character": "Charakter filtern",
  "filter_weapon": "Waffe filtern",
  "filter_artifact": "Artefakte filtern",
  "filter_domain": "Sphären filtern",
  "filter_resource": "Teyvat's Ressourcen filtern",
  "filter_enemy": "Gegner filtern",
  "reset_filter_comfirm": "Möchten sie den Filter zurücksetzten?",
  "sort_name": "Nach Namen sortieren",
  "filter_with_rarity": "Nach einer einzelnen Seltenheit filtern",
  "empty_character": "Keine Charaktere",
  "empty_artifact": "Keine Artefakte",
  "empty_resource": "Keine Ressourcen von Teyvat",
  "empty_weapon": "Keine Waffen",
  "all": "Alles",
  "online": "Online",

  "category": "Kategorie",
  "animal_information": "Tierinformationen",
  "select_animal": "Bitte wählen Sie ein Tier aus",
  "achievement_information": "Leistungsinformationen",
  "select_achievement": "Bitte wählen Sie eine Leistung aus",
  "namecard_information": "Informationen zur Visitenkarte",
  "select_namecard": "Bitte wählen Sie eine Visitenkarte aus",
  "craft": "Handwerk",
  "craft_information": "Handwerksinformationen",
  "select_craft": "Bitte wählen Sie ein Handwerk aus",
  "recipe": "Rezept",
  "outfit_information": "Outfit-Informationen",
  "select_outfit": "Bitte wählen Sie ein Outfit",
  "geography": "Geographisches Gebiet",
  "geography_information": "Geografische Informationen",
  "select_geography": "Bitte wählen Sie ein geografisches Gebiet aus",
  "windglider_information": "Flügelinformationen",
  "select_windglider": "Bitte wählen Sie einen Flügel aus",

  "note_home":
      "Dies ist eine Beta-Version, eine Testversion von Genshin Fan, bevor sie offiziell veröffentlicht wird. In dieser Version werden neue Funktionen hinzugefügt und Fehler behoben, das Produkt ist jedoch noch unvollständig und kann kleinere Fehler und Probleme aufweisen.\nIhr Beitrag zur Sprachübersetzung in der Beta-Version ist sehr wichtig, um zur Verbesserung der Qualität des Produkts beizutragen. Sie können helfen, indem Sie Feedback zu Begriffen und Sprachstrukturen im Produkt geben. Dies erleichtert die Verwendung des Produkts für Benutzer und erleichtert auch Benutzern in verschiedenen Ländern und Regionen die Verwendung des Produkts. Neben dem Beitrag zur Bewerbungssprache freue ich mich auch auf Ihren Beitrag zum Charakteraufbau. Sie können zu den <b>Einstellungen</b> gehen, um einen Beitrag zu leisten.\nIch freue mich auf Ihren Beitrag, um das Produkt zu verbessern und sicherzustellen, dass es sein volles Potenzial ausschöpft. Ich werde die Beta-Version weiterhin aktualisieren und auf Ihr Feedback hören, um sicherzustellen, dass das Endprodukt Ihren Anforderungen am besten entspricht.",

  // date
  "day1": "Montag",
  "day2": "Dienstag",
  "day3": "Mittwoch",
  "day4": "Donnerstag",
  "day5": "Freitag",
  "day6": "Samstag",
  "day7": "Sonntag",

  // các loại chỉ số
  "attack": "ANG",
  "hp": "LP",
  "def": "VTD",
  "energy_recharge": "Aufladerate",
  "elemental_mastery": "Elementarkunde",
  "crit_rate": "KT",
  "crit_dame": "KSCH",
  "dame_physical": "Physischer SCH-Bonus",
  "dame_element": "SCH-Bonus",
  "healing_bonus": "Heilungsbonus",

  // element
  "anemo": "Anemo",
  "geo": "Geo",
  "electro": "Elektro",
  "dendro": "Dendro",
  "pyro": "Pyro",
  "hydro": "Hydro",
  "cryo": "Kryo",
  "none": "k. A.",

  "e_anemo": "Anemo",
  "e_geo": "Geo",
  "e_electro": "Elektro",
  "e_dendro": "Dendro",
  "e_pyro": "Pyro",
  "e_hydro": "Hydro",
  "e_cryo": "Kryo",

  // weapon
  "sword": "Einhänder",
  "bow": "Bogen",
  "claymore": "Zweihänder",
  "catalyst": "Katalysator",
  "polearm": "Stangenwaffe",

  // region
  "mondstadt": "Mondstadt",
  "sumeru": "Sumeru",
  "inazuma": "Inazuma",
  "liyue": "Liyue",
  "snezhnaya": "Snezhnaya",
};
