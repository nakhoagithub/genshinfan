import 'dart:ui';

import 'package:genshinfan/objects/app/language.dart';

// indonesia

const indonesian = Language(
  languageCode: "Indonesian",
  language: "bahasa Indonesia",
  locale: Locale("id", 'ID'),
);

const Map<String, String> id = {
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
  "choose_language": "Choose language",
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
  "choose_character": "Please choose character",
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
  "choose_weapon": "Please choose Weapon",
  "refinement": "Refinement",
  "type": "Type",
  "story": "Story",
  "effectname": "Effect name",
  "resource_information": "Resource Information",
  "choose_resource": "Please choose Resource",
  "dupealias": "More information",
  "source": "Source",
  "days_of_week": "Day of Week",
  "artifact_information": "Artifact Information",
  "choose_artifact": "Please choose Artifact",
  "set1": "Activate 1 item",
  "set2": "Activate set of 2",
  "set4": "Activate set of 4",
  "domain_information": "Domain Information",
  "choose_domain": "Please choose Dungeon",
  "domainentrance": "Entrance",
  "recommendedlevel": "Recommended level",
  "unlockrank": "Unlock rank",
  "recommendedelements": "Recommended element",
  "disorder": "Disorder",
  "reward": "Reward",
  "choose_enemy": "Please choose Enemy",
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
  "choose_full_info": "You must select full the information.",
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
  "online": "On line",

  "note_home":
      "Ini adalah versi Beta, versi uji coba Genshin Fan sebelum dirilis secara resmi. Dalam versi ini, fitur baru ditambahkan dan bug diperbaiki, namun produk masih belum lengkap dan mungkin mengalami bug dan masalah kecil.\nKontribusi Anda dalam terjemahan bahasa dalam versi Beta sangat penting untuk membantu meningkatkan kualitas produk. Anda dapat membantu dengan memberikan umpan balik tentang istilah dan struktur bahasa dalam produk. Ini membuat produk lebih mudah digunakan oleh pengguna dan juga memudahkan pengguna di berbagai negara dan wilayah untuk menggunakan produk. Selain kontribusi bahasa aplikasi, saya juga mengharapkan kontribusi Anda tentang bagaimana membangun karakter. Anda dapat membuka <b>Setelan</b> untuk berkontribusi. \nSaya berharap dapat menerima masukan Anda untuk meningkatkan produk dan memastikannya digunakan secara maksimal. Saya akan terus memperbarui versi Beta dan mendengarkan umpan balik Anda untuk memastikan bahwa produk akhir akan memenuhi kebutuhan Anda dengan sebaik-baiknya.",

  // date
  "day1": "Senin",
  "day2": "Selasa",
  "day3": "Rabu",
  "day4": "Kamis",
  "day5": "Jumat",
  "day6": "Sabtu",
  "day7": "Minggu",

  // các loại chỉ số
  "attack": "ATK",
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
  "none": "Tidak ada",

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
