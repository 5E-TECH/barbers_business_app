import 'package:bar_brons_app/core/enum/user_role.dart';
import 'package:bar_brons_app/features/customer/pages/bottom_navigation_pages/admin_get_bron_page.dart';
import 'package:bar_brons_app/features/customer/pages/bottom_navigation_pages/admin_history_page.dart';
import 'package:bar_brons_app/features/customer/pages/bottom_navigation_pages/admin_setting_page.dart';
import 'package:bar_brons_app/features/customer/pages/bottom_navigation_pages/admin_home_page.dart';
import 'package:bar_brons_app/pages/sign_in.dart';
import 'package:flutter/material.dart';

class RoleBasedRouter {
  static Widget getHomePageForRole(UserRole role) {
    switch (role) {
      case UserRole.ADMIN:
        return AdminHomePage();
      case UserRole.CUSTOMER:
        // TODO: Handle this case.
        throw UnimplementedError();
      case UserRole.PROVIDER:
        // TODO: Handle this case.
        throw UnimplementedError();
      default:
        return SignInPage();
    }
  }

  static List<Widget> getNavigationPagesForRole(UserRole role) {
    switch (role) {
      case UserRole.ADMIN:
        return [
          AdminHomePage(),
          AdminGetBronPage(),
          AdminHistoryPage(),
          AdminSettingsPage(),
        ];
      case UserRole.CUSTOMER:
        // TODO: Handle this case.
        throw UnimplementedError();
      case UserRole.PROVIDER:
        // TODO: Handle this case.
        throw UnimplementedError();
      default:
        return [SignInPage()];
    }
  }
}
