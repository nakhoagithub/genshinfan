import 'package:flutter/material.dart';
import 'package:genshinfan/views/app_controller.dart';
import 'package:get/get.dart';

class Role {
  /// Quyền quản trị cao nhất
  static bool isRoleAdmin() {
    List<int>? roles = Get.find<AppController>().userApp.value?.roles;
    if (roles?.contains(1) == true) {
      return true;
    }
    return false;
  }

  /// Quyền quản lý người dùng
  static bool isRoleUserManager() {
    List<int>? roles = Get.find<AppController>().userApp.value?.roles;
    if (roles?.contains(2) == true) {
      return true;
    }
    return false;
  }

  /// Quyền kiểm duyệt bài đăng
  static bool isRoleSensor() {
    List<int>? roles = Get.find<AppController>().userApp.value?.roles;
    if (roles?.contains(5) == true) {
      return true;
    }
    return false;
  }

  /// Người dùng
  static bool isRoleMember() {
    List<int>? roles = Get.find<AppController>().userApp.value?.roles;
    if (roles?.contains(10) == true) {
      return true;
    }
    return false;
  }

  static bool viewMenuAdmin() {
    if (isRoleAdmin() || isRoleUserManager() || isRoleSensor()) {
      return true;
    }
    return false;
  }

  /// Hiển thị title quản lý dữ liệu về đóng góp
  static bool viewDataManagement() {
    if (isRoleAdmin() || isRoleSensor()) {
      return true;
    }
    return false;
  }

  static bool viewUserManagement() {
    if (isRoleAdmin() || isRoleUserManager()) {
      return true;
    }
    return false;
  }

  static Color? colorForRole(List<int>? roles) {
    if (roles?.contains(1) == true) {
      return Colors.red;
    }
    if (roles?.contains(2) == true) {
      return Colors.blue;
    }
    if (roles?.contains(5) == true) {
      return Colors.orange;
    }
    return null;
  }
}
