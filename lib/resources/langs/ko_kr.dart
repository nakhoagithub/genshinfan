import 'dart:ui';

import 'package:genshinfan/objects/app/language.dart';

// Hàn Quốc

const korean = Language(
  languageCode: "Korean",
  language: "한국인",
  locale: Locale("ko", 'KR'),
);

const Map<String, String> ko = {
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
  "online": "온라인",

  "category": "카테고리",
  "animal_information": "동물 정보",
  "select_animal": "동물을 선택하세요",
  "achievement_information": "업적 정보",
  "select_achievement": "업적을 선택하세요",
  "namecard_information": "명함 정보",
  "select_namecard": "명함을 선택하세요",
  "craft": "크래프트",
  "craft_information": "공예 정보",
  "select_craft": "공예를 선택하세요",
  "recipe": "레시피",
  "outfit_information": "의상 정보",
  "select_outfit": "의상을 선택하세요",
  "geography": "지리적 영역",
  "geography_information": "지리 정보",
  "select_geography": "지리적 영역을 선택하세요",
  "windglider_information": "날개 정보",
  "select_windglider": "날개를 선택하세요",
  "extract_failure": "데이터 추출 오류",
  "delete_data_and_redownload": "데이터 삭제 및 다시 로드",
  "data_failure_wait_for_new_update": "현재 데이터가 손상되었습니다. 새 업데이트를 기다리십시오!",

  "note_home":
      "이것은 정식 출시 전 Genshin Fan의 테스트 버전인 베타 버전입니다. 이 버전에서는 새로운 기능이 추가되고 버그가 수정되었지만 제품이 아직 불완전하고 사소한 버그와 문제가 발생할 수 있습니다.\n베타 버전에서 언어 번역에 대한 귀하의 기여는 제품 품질을 개선하는 데 매우 중요합니다. 제품의 용어 및 언어 구조에 대한 피드백을 제공하여 도움을 줄 수 있습니다. 이렇게 하면 사용자가 제품을 더 쉽게 사용할 수 있고 다른 국가 및 지역의 사용자가 제품을 더 쉽게 사용할 수 있습니다. 응용 프로그램 언어에 기여하는 것 외에도 캐릭터 구축 방법에 대한 기여도 기대합니다. <b>설정</b>으로 이동하여 기여할 수 있습니다.\n제품을 개선하고 제품의 잠재력을 최대한 활용할 수 있도록 귀하의 의견을 기다리겠습니다. 베타 버전을 계속 업데이트하고 최종 제품이 귀하의 요구를 가장 잘 충족시킬 수 있도록 귀하의 피드백에 귀를 기울일 것입니다.",

  // date
  "day1": "월요일",
  "day2": "화요일",
  "day3": "수요일",
  "day4": "목요일",
  "day5": "금요일",
  "day6": "토요일",
  "day7": "일요일",

  // game
  "FIGHT_PROP_ATTACK_PERCENT": "공격력 (%)",
  "FIGHT_PROP_ROCK_ADD_HURT": "바위 원소 피해 보너스 (%)",
  "FIGHT_PROP_ICE_ADD_HURT": "얼음 원소 피해 보너스 (%)",
  "FIGHT_PROP_ELEC_ADD_HURT": "번개 원소 피해 보너스 (%)",
  "FIGHT_PROP_FIRE_ADD_HURT": "불 원소 피해 보너스 (%)",
  "FIGHT_PROP_WATER_ADD_HURT": "물 원소 피해 보너스 (%)",
  "FIGHT_PROP_WIND_ADD_HURT": "바람 원소 피해 보너스 (%)",
  "FIGHT_PROP_GRASS_ADD_HURT": "풀 원소 피해 보너스 (%)",
  "FIGHT_PROP_HEAL_ADD": "치유 보너스 (%)",
  "FIGHT_PROP_DEFENSE_PERCENT": "방어력 (%)",
  "FIGHT_PROP_PHYSICAL_ADD_HURT": "물리 피해 보너스 (%)",
  "FIGHT_PROP_ELEMENT_MASTERY": "원소 마스터리",
  "FIGHT_PROP_CHARGE_EFFICIENCY": "원소 충전 효율 (%)",
  "FIGHT_PROP_HP_PERCENT": "HP (%)",
  "FIGHT_PROP_CRITICAL": "치명타 확률 (%)",
  "FIGHT_PROP_CRITICAL_HURT": "치명타 피해 (%)",

  // các loại chỉ số
  "attack": "공격력",
  "hp": "HP",
  "def": "방어력",
  "energy_recharge": "원소 충전 효율",
  "elemental_mastery": "원소 마스터리",
  "crit_rate": "치명타 확률",
  "crit_dame": "치명타 피해",
  "dame_physical": "물리 피해",
  "dame_element": "원소 피해",
  "healing_bonus": "치유 보너스",

  // element
  "anemo": "바람",
  "geo": "바위",
  "electro": "번개",
  "dendro": "풀",
  "pyro": "불",
  "hydro": "물",
  "cryo": "얼음",
  "none": "없음",

  "e_anemo": "바람",
  "e_geo": "바위",
  "e_electro": "번개",
  "e_dendro": "풀",
  "e_pyro": "불",
  "e_hydro": "물",
  "e_cryo": "얼음",

  // weapon
  "sword": "한손검",
  "bow": "활",
  "claymore": "양손검",
  "catalyst": "법구",
  "polearm": "장병기",

  // region
  "mondstadt": "몬드",
  "sumeru": "수메르",
  "inazuma": "이나즈마",
  "liyue": "리월",
  "snezhnaya": "스네즈나야",
};
