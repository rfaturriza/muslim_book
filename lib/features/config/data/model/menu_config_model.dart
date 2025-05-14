class MenuConfig {
  final bool show;
  final bool showBadge;
  final String badgeText;

  MenuConfig({
    required this.show,
    required this.showBadge,
    required this.badgeText,
  });

  factory MenuConfig.fromMap(Map<String, dynamic> map) {
    return MenuConfig(
      show: map['show'] ?? false,
      showBadge: map['showBadge'] ?? false,
      badgeText: map['badgeText'] ?? '',
    );
  }
}

class MenusConfig {
  final Map<String, MenuConfig> menus;

  MenusConfig(this.menus);

  factory MenusConfig.fromJson(Map<String, dynamic> json) {
    final rawMenus = json['menus'] as Map<String, dynamic>;
    final menus = rawMenus.map((key, value) =>
        MapEntry(key, MenuConfig.fromMap(value as Map<String, dynamic>)));
    return MenusConfig(menus);
  }

  MenuConfig getMenu(String key) => menus[key] ?? MenuConfig(show: false, showBadge: false, badgeText: '');
}