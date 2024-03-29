import 'dart:ui';

import 'package:genshinfan/models/app/language.dart';

// phồn thể

const chineseTraditional = Language(
  languageCode: "ChineseTraditional",
  language: "中國傳統的",
  locale: Locale("zh", "TW"),
);

const Map<String, String> zhTW = {
  "welcome_to_app": "Welcome to Genshin Fan", // (ChineseTraditional)
  "version": "Version @version",
  "loading": "加載中...",
  "downloading": "@percent% 下載。",
  "decompressing": "解壓縮...",
  "processing": "加工",
  "checking": "檢查",
  "no_data_version": "沒有新的數據版本。",
  "update_new_data": "更新新數據。",
  "complete": "完全的！",
  "wait_a_minute": "等一下",
  "data_failure": "無法加載數據！ 請打開網絡。",
  "not_internet": "互聯網連接失敗！",
  "setting": "設置",
  "dark_theme": "深色主題",
  "change_language": "改變語言",
  "select_language": "選擇語言",
  "character": "特點",
  "weapon": "武器",
  "teyvat_resource": "資源",
  "food": "食物",
  "artifact": "人工製品",
  "domain": "地下城",
  "animal": "動物",
  "enemy": "敵人",
  "achievement": "成就",
  "windglider": "滑翔機",
  "forging_recipe": "鍛造配方",
  "namecard": "名片",
  "outfit": "Outfit",
  "select_character": "請選擇角色",
  "element": "元素",
  "rarity": "稀有度",
  "especially": "尤其",
  "information": "信息",
  "character_information": "角色信息",
  "substat": "子統計",
  "gender": "性別",
  "birthday": "生日",
  "travelerBirthday": "旅行者的生日",
  "affiliation": "聯繫",
  "region": "地區",
  "description": "描述",
  "skill": "技能",
  "skill_passive": "被動的",
  "constellation": "星座",
  "ascension": "阿森松島",
  "level": "等級",
  "ascend": "登高",
  "resource": "資源",
  "skill_ascension": "技能提升",
  "stats": "統計數據",
  "weapon_information": "武器信息",
  "talent_stats": "技能統計",
  "select_weapon": "請選擇武器",
  "refinement": "求精",
  "type": "類型",
  "story": "故事",
  "effectname": "效果名稱",
  "resource_information": "資源信息",
  "select_resource": "請選擇資源",
  "dupealias": "更多信息",
  "source": "來源",
  "days_of_week": "星期幾",

  "artifact_information": "Artifact Information",
  "select_artifact": "請選擇神器",
  "set1": "激活 1 項",
  "set2": "激活 2 件套",
  "set4": "激活 4 件套",

  "domain_information": "域信息",
  "select_domain": "請選擇地牢",
  "domainentrance": "入口",
  "recommendedlevel": "推薦等級",
  "unlockrank": "解鎖排名",
  "recommendedelements": "推薦元素",
  "disorder": "紊亂",
  "reward": "報酬",
  "select_enemy": "請選擇敵人",
  "enemy_information": "敵人信息",
  "monster": "怪物",
  "specialname": "特殊名稱",
  "notification": "通知",
  "notification_change_language": "更改語言後，應用程序將重新啟動以您選擇的語言加載數據。",
  "cancel": "取消",
  "ok": "同意",
  "double_click_exit": "再按一次退出",
  "today": "今天",
  "birthday_in_month": "當月生日",
  "option": "選項",
  "success": "成功地",
  "not": "不是",
  "note": "筆記",
  "daily_reset_time":
      "<b>每日重置</b>根據服務器時區時間每 04:00 (4AM) 進行一次。\n\n - 服務器亞洲 (AS)：GMT+8\n - 服務器歐洲 (EU)： GMT+1\n - 美國服務器（NA）：GMT-5",
  "character_up_today": "角色可以在白天找到升級材料。",
  "weapon_up_today": "武器可以在白天找到升級材料。",
  "genshin_map": "Teyvat Map",
  "notification_open_genshin_map": "您要在瀏覽器中打開 <b>Teyvat Map</b> 嗎？",
  "update": "更新",
  "check_update": "檢查數據更新",
  "description_update_setting": "檢查和更新應用程序的數據",
  "contribute": "貢獻",
  "character_building": "人物塑造",
  "contribute_translation": "貢獻翻譯",
  "send_feedback": "發送反饋",
  "description_send_feedback": "給開發者發郵件",
  "other": "其他",
  "join_discord": "加入 Discord 服務器",
  "confirm": "確認",
  "access_throughput": "訪問吞吐量",
  "total": "全部的",
  "this_month": "這個月",
  "set2_artifact": "2件套神器",
  "set4_artifact": "4件套神器",
  "sands_effect": "金沙效應",
  "goblet_effect": "高腳杯效應",
  "circlet_effect": "圓環效應",
  "user_information": "用戶信息",
  "login": "登錄",
  "logout_question": "你想退出嗎？",
  "refresh_traffic": "刷新流量？",
  "required_login": "您需要登錄才能執行此功能",
  "admin": "Admin",
  "admin_description": "應用管理",
  "user_management": "用戶管理",
  "data_management": "數據管理",
  "manager": "經理",
  "contribution_character": "貢獻人物",
  "role_and_data_user": "用戶權利和數據",
  "manage_user_character_contribution": "管理用戶的角色貢獻",
  "select_full_info": "您必須選擇完整的信息",
  "author": "作者",
  "invalid": "無效的",
  "delete": "刪除",
  "delete_contribute": "刪除此用戶貢獻？",
  "add_contribute_to_database": "將此貢獻添加到數據庫？",
  "delete_contribute_to_database": "刪除此貢獻？",
  "contribute_manage_empty": "還沒有貢獻",
  "censor": "審查",
  "member": "成員",
  "permission": "允許",
  "permission_denied": "沒有權限",
  "error": "錯誤",
  "note_contribute_character_building": "這些貢獻的數據將由版主審查和批准",
  "timeout_exception": "超時異常",
  "reset": "重置",
  "filter_character": "過濾字符",
  "filter_weapon": "過濾武器",
  "filter_artifact": "過濾神器",
  "filter_domain": "過濾地下城",
  "filter_resource": "篩選資源",
  "filter_enemy": "過濾敵人",
  "reset_filter_comfirm": "是否要重置過濾器？",
  "sort_name": "按名稱分類",
  "filter_with_rarity": "按單一稀有度過濾",
  "empty_character": "沒有字符",
  "empty_artifact": "無神器",
  "empty_resource": "沒有資源",
  "empty_weapon": "沒有武器",
  "all": "全部",
  "online": "在線的",

  "category": "類別",
  "animal_information": "動物信息",
  "select_animal": "請選擇動物",
  "achievement_information": "成就信息",
  "select_achievement": "請選擇成就",
  "namecard_information": "名片信息",
  "select_namecard": "請選擇名片",
  "craft": "工藝",
  "craft_information": "工藝信息",
  "select_craft": "請選擇工藝",
  "recipe": "食譜",
  "outfit_information": "服裝信息",
  "select_outfit": "請選擇服裝",
  "geography": "地理區域",
  "geography_information": "地理信息",
  "select_geography": "請選擇地理區域",
  "windglider_information": "機翼信息",
  "select_windglider": "請選擇機翼",
  "extract_failure": "提取數據時出錯",
  "delete_data_and_redownload": "刪除數據並重新加載",
  "data_failure_wait_for_new_update": "當前數據已損壞，請等待新的更新！",

  // date
  "day1": "週一",
  "day2": "週二",
  "day3": "週三",
  "day4": "週四",
  "day5": "週五",
  "day6": "週六",
  "day7": "週日",

  // game
  "FIGHT_PROP_ATTACK_PERCENT": "攻擊力 (%)",
  "FIGHT_PROP_ROCK_ADD_HURT": "岩元素傷害加成 (%)",
  "FIGHT_PROP_ICE_ADD_HURT": "冰元素傷害加成 (%)",
  "FIGHT_PROP_ELEC_ADD_HURT": "雷元素傷害加成 (%)",
  "FIGHT_PROP_FIRE_ADD_HURT": "火元素傷害加成 (%)",
  "FIGHT_PROP_WATER_ADD_HURT": "水元素傷害加成 (%)",
  "FIGHT_PROP_WIND_ADD_HURT": "風元素傷害加成 (%)",
  "FIGHT_PROP_GRASS_ADD_HURT": "草元素傷害加成 (%)",
  "FIGHT_PROP_HEAL_ADD": "治療加成 (%)",
  "FIGHT_PROP_DEFENSE_PERCENT": "防禦力 (%)",
  "FIGHT_PROP_PHYSICAL_ADD_HURT": "物理傷害加成 (%)",
  "FIGHT_PROP_ELEMENT_MASTERY": "元素精通",
  "FIGHT_PROP_CHARGE_EFFICIENCY": "元素充能效率 (%)",
  "FIGHT_PROP_HP_PERCENT": "生命值 (%)",
  "FIGHT_PROP_CRITICAL": "暴擊率 (%)",
  "FIGHT_PROP_CRITICAL_HURT": "暴擊傷害 (%)",

  // các loại chỉ số
  "attack": "攻擊力",
  "hp": "生命值",
  "def": "防禦力",
  "elemental_mastery": "元素精通",
  "energy_recharge": "元素充能效率",
  "crit_rate": "暴擊率",
  "crit_dame": "暴擊傷害",
  "dame_physical": "物理傷害加成",
  "dame_element": "元素傷害加成",
  "healing_bonus": "治療加成",

  // element
  "anemo": "風元素",
  "geo": "岩元素",
  "electro": "雷元素",
  "dendro": "草元素",
  "pyro": "火元素",
  "hydro": "水元素",
  "cryo": "冰元素",
  "none": "None",

  "e_anemo": "風元素",
  "e_geo": "岩元素",
  "e_electro": "雷元素",
  "e_dendro": "草元素",
  "e_pyro": "火元素",
  "e_hydro": "水元素",
  "e_cryo": "冰元素",

  // weapon
  "sword": "單手劍",
  "bow": "弓",
  "claymore": "雙手劍",
  "catalyst": "法器",
  "polearm": "長柄武器",

  // region
  "mondstadt": "蒙德",
  "sumeru": "須彌",
  "inazuma": "稻妻",
  "liyue": "璃月",
  "snezhnaya": "至冬",
};
