import 'dart:ui';

import 'package:genshinfan/models/app/language.dart';

const english = Language(
  languageCode: "English",
  language: "English",
  locale: Locale("en", 'US'),
);

const Map<String, String> en = {
  "welcome_to_app": "Welcome to Genshin Fan",
  "version": "Version @version",

  "loading": "Loading...",
  "downloading": "@percent% Downloaded.",
  "decompressing": "Decompressing...",
  "processing": "Processing",
  "checking": "Checking",
  "no_data_version": "There is no new data version.",
  "update_new_data": "Update new data.",
  "complete": "Complete!",
  "wait_a_minute": "Wait a minute",
  "data_failure": "Unable to load data! Please turn on the network.",
  "not_internet": "Internet connection failed!",
  "setting": "Settings",
  "dark_theme": "Dark theme",
  "change_language": "Change language",
  "select_language": "Select language",
  "teyvat_resource": "Teyvat's Resources",
  "select_character": "Please select a Character",
  "rarity": "Rarity",
  "especially": "Especially",
  "information": "Information",
  "character_information": "Character infomation",
  "substat": "Substat",
  "gender": "Gender",
  "birthday": "Birthday",
  "travelerBirthday": "Traveler's birthday",
  "affiliation": "Affiliation",
  "region": "Region",
  "description": "Description",
  "level": "Level",
  "resource": "Resource",
  "skill_ascension": "Skill Ascension",
  "stats": "Stats",
  "weapon_information": "Weapon Information",
  "talent_stats": "Skill stats",
  "select_weapon": "Please select a Weapon",
  "refinement": "Refinement",
  "type": "Type",
  "story": "Story",
  "effectname": "Effect name",
  "resource_information": "Resource Information",
  "select_resource": "Please select a Resource",
  "dupealias": "More information",
  "source": "Source",
  "artifact_information": "Artifact Information",
  "select_artifact": "Please select an Artifact",
  "set1": "Activate 1 item",
  "set2": "Activate set of 2",
  "set4": "Activate set of 4",
  "domain_information": "Domain Information",
  "select_domain": "Please select a Dungeon",
  "domainentrance": "Entrance",
  "recommendedlevel": "Recommended level",
  "unlockrank": "Unlock rank",
  "recommendedelements": "Recommended element",
  "disorder": "Disorder",
  "reward": "Reward",
  "select_enemy": "Please select an Enemy",
  "enemy_information": "Enemy Information",
  "monster": "Monster",
  "specialname": "Special name",
  "notification": "Notification",
  "notification_change_language":
      "After you change the language, the application will restart to load data in the language of your choice.",
  "cancel": "Cancel",
  "ok": "Agree",
  "double_click_exit": "Press again to exit",
  "today": "Today",
  "birthday_in_month": "Birthdays of the month",
  "option": "Option",
  "success": "Successfully",
  "not": "Not",
  "note": "Note",
  "daily_reset_time":
      "<b>Daily Reset</b> takes place every 04:00 (4AM), based on the server time zone time.\n\n - Server Asia (AS): GMT+8\n - Server Europe (EU): GMT+1\n - Server America (NA): GMT-5",
  "character_up_today": "Characters can find upgrade materials during the day.",
  "weapon_up_today": "Weapons can find upgrade materials during the day.",
  "genshin_map": "Genshin Map",
  "notification_open_genshin_map":
      "Do you want to open <b>Genshin Map</b> in the browser?",
  "update": "Update",
  "check_update": "Check data update.",
  "description_update_setting": "Check and update data for the application.",
  "contribute": "Contribute",
  "character_building": "Character building",
  "contribute_translation": "Contribute translations",
  "send_feedback": "Send feedback",
  "description_send_feedback": "Email the developer.",
  "other": "Other",
  "join_discord": "Join Discord server.",
  "confirm": "Confirm",
  "access_throughput": "Access throughput",
  "total": "Total",
  "this_month": "This month",
  "set2_artifact": "Set of 2 artifact",
  "set4_artifact": "Set of 4 artifact",
  "sands_effect": "Sands effect",
  "goblet_effect": "Goblet effect",
  "circlet_effect": "Circlet effect",
  "user_information": "User information",
  "login": "Login",
  "logout_question": "Do you want to sign out?",
  "refresh_traffic": "Refresh traffic?",
  "required_login": "You need to login to perform this function.",
  "admin": "Admin",
  "admin_description": "Application management",
  "user_management": "User management",
  "data_management": "Data management",
  "manager": "Manager",
  "contribution_character": "Contribution Character",
  "role_and_data_user": "User rights and data.",
  "manage_user_character_contribution": "Manage user's Character contribution.",
  "select_full_info": "You must select full the information.",
  "author": "Author",
  "invalid": "Invalid",
  "delete": "Delete",
  "delete_contribute": "Delete this user contribution?",
  "add_contribute_to_database": "Add this contribution to the database?",
  "delete_contribute_to_database": "Delete this contribution?",
  "contribute_manage_empty": "No contributions yet",
  "censor": "Censor",
  "member": "Member",
  "permission": "Permission",
  "permission_denied": "Permission denied",
  "error": "Error",
  "note_contribute_character_building":
      "This contributed data will be reviewed and approved by moderators.",
  "timeout_exception": "Timeout exception",
  "reset": "Reset",
  "filter_character": "Filter Character",
  "filter_weapon": "Filter Weapon",
  "filter_artifact": "Filter Artifact",
  "filter_domain": "Filter Dungeon",
  "filter_resource": "Filter Teyvat's Resources",
  "filter_enemy": "Filter Enemy",
  "reset_filter_comfirm": "Do you want to reset the filter?",
  "sort_name": "Sort by name",
  "filter_with_rarity": "Filter by a single rarity",
  "empty_character": "No characters",
  "empty_artifact": "No Artifact",
  "empty_resource": "No Teyvat's Resource",
  "empty_weapon": "No Weapon",
  "all": "All",
  "online": "Online",

  "category": "Category",
  "animal_information": "Animal Information",
  "select_animal": "Please select an Animal",
  "achievement_information": "Achievement Information",
  "select_achievement": "Please select an Achievement",
  "namecard_information": "Namecard Information",
  "select_namecard": "Please select a Namecard",
  "craft": "Craft",
  "craft_information": "Craft Information",
  "select_craft": "Please select a Craft",
  "recipe": "recipe",
  "outfit_information": "Outfit Information",
  "select_outfit": "Please choose an Outfit",
  "geography": "Geographic Area",
  "geography_information": "Geographical Information",
  "select_geography": "Please select a Geographic Area",
  "windglider_information": "Wing Information",
  "select_windglider": "Please select a Wing",
  "extract_failure": "Error extracting data",
  "delete_data_and_redownload": "Delete data and reload",
  "data_failure_wait_for_new_update":
      "The current data is corrupted, please wait for the new update!",
  "user": "User",
  "search": "Search",
  "role": "Role",
  "food_information": "Food Information",
  "empty_food": "No Food",
  "ingredient": "Ingredient",
  "menu": "Menu",
  "tool": "Tools",
  "team_building": "Team Building",

  "contribute_note":
      "This interface will be deprecated in the next few versions.",

  "home": "Home",
  "change_today": "Change the day of the week",

  // cần dịch
  "character": "Character",
  "artifact": "Artifact",
  "weapon": "Weapon",
  "food": "Food",
  "domain": "Domain",
  "animal": "Animal",
  "enemy": "Ennemy",
  "achievement": "Achievement",
  "windglider": "Windglider",
  "forging_recipe": "Foring recipe",
  "namecard": "Name card",
  "outfit": "Outfit",
  "element": "Element",
  "skill": "Skill",
  "skill_passive": "Passive",
  "constellation": "Constellation",
  "ascension": "Ascension",
  "ascend": "Ascend",
  "days_of_week": "Days of week",

  // date
  "day1": "Monday",
  "day2": "Tuesday",
  "day3": "Wednesday",
  "day4": "Thursday",
  "day5": "Friday",
  "day6": "Saturday",
  "day7": "Sunday",

  // game
  "FIGHT_PROP_ATTACK_PERCENT": "Attack (%)",
  "FIGHT_PROP_ROCK_ADD_HURT": "Geo DMG Bonus (%)",
  "FIGHT_PROP_ICE_ADD_HURT": "Cryo DMG Bonus (%)",
  "FIGHT_PROP_ELEC_ADD_HURT": "Electro DMG Bonus (%)",
  "FIGHT_PROP_FIRE_ADD_HURT": "Pyro DMG Bonus (%)",
  "FIGHT_PROP_WATER_ADD_HURT": "Hydro DMG Bonus (%)",
  "FIGHT_PROP_WIND_ADD_HURT": "Anemo DMG Bonus (%)",
  "FIGHT_PROP_GRASS_ADD_HURT": "Dendro DMG Bonus (%)",
  "FIGHT_PROP_HEAL_ADD": "Healing Bonus (%)",
  "FIGHT_PROP_DEFENSE_PERCENT": "DEF (%)",
  "FIGHT_PROP_PHYSICAL_ADD_HURT": "Physical DMG Bonus (%)",
  "FIGHT_PROP_ELEMENT_MASTERY": "Elemental Mastery",
  "FIGHT_PROP_CHARGE_EFFICIENCY": "Energy Recharge (%)",
  "FIGHT_PROP_HP_PERCENT": "HP (%)",
  "FIGHT_PROP_CRITICAL": "CRIT Rate (%)",
  "FIGHT_PROP_CRITICAL_HURT": "CRIT DMG (%)",

  // các loại chỉ số
  "attack": "Attack",
  "hp": "HP",
  "def": "Defense",
  "energy_recharge": "Energy Recharge",
  "elemental_mastery": "Elemental Mastery",
  "crit_rate": "CRIT Rate",
  "crit_dame": "CRIT Dame",
  "dame_physical": "Dame Physical",
  "dame_element": "Dame Element",
  "healing_bonus": "Healing Bonus",

  // element
  "anemo": "Anemo",
  "geo": "Geo",
  "electro": "Electro",
  "dendro": "Dendro",
  "pyro": "Pyro",
  "hydro": "Hydro",
  "cryo": "Cryo",
  "none": "None",

  "e_anemo": "Anemo",
  "e_geo": "Geo",
  "e_electro": "Electro",
  "e_dendro": "Dendro",
  "e_pyro": "Pyro",
  "e_hydro": "Hydro",
  "e_cryo": "Cryo",

  // weapon
  "sword": "Sword",
  "bow": "Bow",
  "claymore": "Claymore",
  "catalyst": "Catalyst",
  "polearm": "Polearm",

  // region
  "mondstadt": "Mondstadt",
  "sumeru": "Sumeru",
  "inazuma": "Inazuma",
  "liyue": "Liyue",
  "snezhnaya": "Snezhnaya",
};
