import 'package:cloud_toq_system/core/route/app_pages.dart';
import 'package:cloud_toq_system/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    //if(sharedPreferences!.getString('UserName')!=null) return RouteSettings(name: Routes.PRODUCT);
    if (sharedPreferences!.getBool('splash') != null) {
      return const RouteSettings(name: Routes.ONBOARDING_VIEW);
    }
    return null;
  }
}

class MiddleWare2 extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (sharedPreferences!.getBool('onBoard') != null) {
      return const RouteSettings(name: Routes.LOGIN);
    }
    return null;
  }
}

class MiddleWare3 extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (sharedPreferences!.getInt('id') != null) {
      return const RouteSettings(name: Routes.BRANCH);
    }
    return null;
  }
}

class MiddleWare4 extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (sharedPreferences!.getString('Branch_Id') != null) {
      return const RouteSettings(name: Routes.PRODUCT);
    }
    return null;
  }
}
