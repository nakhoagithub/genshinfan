class Role {
  static bool isRoleAdmin(List<int> roles) {
    if (roles.contains(10)) {
      return true;
    }
    return false;
  }

  static bool isRoleSensor(List<int> roles) {
    if (roles.contains(10)) {
      return true;
    }
    return false;
  }

  static bool isRoleMember(List<int> roles) {
    if (roles.contains(10)) {
      return true;
    }
    return false;
  }
}
