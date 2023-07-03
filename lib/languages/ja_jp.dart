import 'dart:ui';

import 'package:genshinfan/models/app/language.dart';

// Nhật

const japanese = Language(
  languageCode: "Japanese",
  language: "日本",
  locale: Locale("ja", 'JP'),
);

const Map<String, String> ja = {
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
  "select_language": "Choose language",
  "character": "Character",
  "weapon": "Weapon",
  "teyvat_resource": "Teyvat's Resources",
  "food": "Food",
  "artifact": "Artifact",
  "domain": "Domain",
  "animal": "Animal",
  "enemy": "Enemy",
  "achievement": "Achievement",
  "windglider": "Windglider",
  "forging_recipe": "Foring recipe",
  "namecard": "Name card",
  "outfit": "Outfit",
  "select_character": "Please choose character",
  "element": "Element",
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
  "skill": "Skill",
  "skill_passive": "Passive",
  "constellation": "Constellation",
  "ascension": "Ascension",
  "level": "Level",
  "ascend": "Ascend",
  "resource": "Resource",
  "skill_ascension": "Skill Ascension",
  "stats": "Stats",
  "weapon_information": "Weapon Information",
  "talent_stats": "Skill stats",
  "select_weapon": "Please choose Weapon",
  "refinement": "Refinement",
  "type": "Type",
  "story": "Story",
  "effectname": "Effect name",
  "resource_information": "Resource Information",
  "select_resource": "Please choose Resource",
  "dupealias": "More information",
  "source": "Source",
  "days_of_week": "Day of Week",
  "artifact_information": "Artifact Information",
  "select_artifact": "Please choose Artifact",
  "set1": "Activate 1 item",
  "set2": "Activate set of 2",
  "set4": "Activate set of 4",
  "domain_information": "Domain Information",
  "select_domain": "Please choose Dungeon",
  "domainentrance": "Entrance",
  "recommendedlevel": "Recommended level",
  "unlockrank": "Unlock rank",
  "recommendedelements": "Recommended element",
  "disorder": "Disorder",
  "reward": "Reward",
  "select_enemy": "Please choose Enemy",
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
  "online": "オンライン",

  "category": "カテゴリ",
  "animal_information": "動物情報",
  "select_animal": "動物を選択してください",
  "achievement_information": "実績情報",
  "select_achievement": "実績を選択してください",
  "namecard_information": "名刺情報",
  "select_namecard": "名刺を選択してください",
  "craft": "クラフト",
  "craft_information": "クラフト情報",
  "select_craft": "クラフトを選択してください",
  "recipe": "レシピ",
  "outfit_information": "服装情報",
  "select_outfit": "服装を選択してください",
  "geography": "地理的エリア",
  "geography_information": "地理情報",
  "select_geography": "地理的エリアを選択してください",
  "windglider_information": "翼の情報",
  "select_windglider": "翼を選択してください",
  "extract_failure": "データ抽出エラー",
  "delete_data_and_redownload": "データを削除して再読み込み",
  "data_failure_wait_for_new_update": "現在のデータは壊れています。新しいアップデートをお待ちください!",

  "note_home":
      "これは正式リリース前の原神扇子のテスト版であるベータ版です。 このバージョンでは、新しい機能が追加され、バグが修正されていますが、製品はまだ不完全であり、マイナーなバグや問題が発生する可能性があります。\nベータ版での言語翻訳への貢献は、製品の品質を向上させるために非常に重要です。 製品の用語と言語構造に関するフィードバックを提供してください。 これにより、ユーザーにとって製品が使いやすくなり、さまざまな国や地域のユーザーが製品を使用しやすくなります。 アプリケーション言語の投稿だけでなく、キャラクターの作り方の投稿もお待ちしております。 <b>設定</b>に移動して貢献できます。\n製品を改善し、その可能性を最大限に活用できるようにするために、ご意見をお待ちしております。 引き続きベータ版を更新し、フィードバックに耳を傾けて、最終製品がお客様のニーズを最もよく満たすようにします。",

  // date
  "day1": "月曜",
  "day2": "火曜",
  "day3": "水曜",
  "day4": "木曜",
  "day5": "金曜",
  "day6": "土曜",
  "day7": "日曜",

  // game
  "FIGHT_PROP_ATTACK_PERCENT": "攻撃力 (%)",
  "FIGHT_PROP_ROCK_ADD_HURT": "岩元素ダメージ (%)",
  "FIGHT_PROP_ICE_ADD_HURT": "氷元素ダメージ (%)",
  "FIGHT_PROP_ELEC_ADD_HURT": "雷元素ダメージ (%)",
  "FIGHT_PROP_FIRE_ADD_HURT": "炎元素ダメージ (%)",
  "FIGHT_PROP_WATER_ADD_HURT": "水元素ダメージ (%)",
  "FIGHT_PROP_WIND_ADD_HURT": "風元素ダメージ (%)",
  "FIGHT_PROP_GRASS_ADD_HURT": "草元素ダメージ (%)",
  "FIGHT_PROP_HEAL_ADD": "与える治療効果 (%)",
  "FIGHT_PROP_DEFENSE_PERCENT": "防御力 (%)",
  "FIGHT_PROP_PHYSICAL_ADD_HURT": "物理ダメージ (%)",
  "FIGHT_PROP_ELEMENT_MASTERY": "元素熟知",
  "FIGHT_PROP_CHARGE_EFFICIENCY": "元素チャージ効率 (%)",
  "FIGHT_PROP_HP_PERCENT": "HP (%)",
  "FIGHT_PROP_CRITICAL": "会心率 (%)",
  "FIGHT_PROP_CRITICAL_HURT": "会心ダメージ (%)",

  // các loại chỉ số
  "attack": "攻撃力",
  "hp": "HP",
  "def": "防御力",
  "energy_recharge": "元素チャージ効率",
  "elemental_mastery": "元素熟知",
  "crit_rate": "会心率",
  "crit_dame": "会心ダメージ",
  "dame_physical": "物理ダメージ",
  "dame_element": "元素ダメージ",
  "healing_bonus": "与える治療効果",

  // element
  "anemo": "風",
  "geo": "岩",
  "electro": "雷",
  "dendro": "草",
  "pyro": "炎",
  "hydro": "水",
  "cryo": "氷",
  "none": "無",

  "e_anemo": "風",
  "e_geo": "岩",
  "e_electro": "雷",
  "e_dendro": "草",
  "e_pyro": "炎",
  "e_hydro": "水",
  "e_cryo": "氷",

  // weapon
  "sword": "片手剣",
  "bow": "弓",
  "claymore": "両手剣",
  "catalyst": "法器",
  "polearm": "長柄武器",

  // region
  "mondstadt": "モンド",
  "sumeru": "スメール",
  "inazuma": "稲妻",
  "liyue": "璃月",
  "snezhnaya": "スネージナヤ",
};