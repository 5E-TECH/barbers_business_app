import 'package:bar_brons_app/core/enum/user_role.dart';
import 'package:bar_brons_app/pages/sign_in.dart';
import 'package:bar_brons_app/role/barbershop/features/barbers/pages/barbers_page.dart';
import 'package:bar_brons_app/role/barbershop/features/barbershop/pages/barbershop_page.dart';
import 'package:flutter/material.dart';

class RoleBasedRouter {
  static Widget getHomePageForRole(UserRole role) {
    switch (role) {
      case UserRole.HAIRDRESSERS:
        return BarbersPage();
      case UserRole.BARBERSHOP:
        return BarbershopPage();
      default:
        return SignInPage();
    }
  }

  static List<Widget> getNavigationPagesForRole(UserRole role) {
    switch (role) {
      case UserRole.HAIRDRESSERS:
        return [BarbersPage()];
      case UserRole.BARBERSHOP:
        return [BarbershopPage()];
      default:
        return [SignInPage()];
    }
  }
}
