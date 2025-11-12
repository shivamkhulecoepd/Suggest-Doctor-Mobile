import 'package:flutter/material.dart';

/// A service class to handle navigation throughout the app
class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Navigate to a named route
  static Future<T?> pushNamed<T extends Object?>(String routeName, {Object? arguments}) async {
    final state = navigatorKey.currentState;
    if (state == null) return null;
    return state.pushNamed<T>(routeName, arguments: arguments);
  }

  /// Navigate to a named route and remove all previous routes
  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(String routeName, {Object? arguments}) async {
    final state = navigatorKey.currentState;
    if (state == null) return null;
    return state.pushNamedAndRemoveUntil<T>(
      routeName, 
      (route) => false,
      arguments: arguments,
    );
  }

  /// Navigate back to the previous screen
  static void pop<T extends Object?>({T? result}) {
    if (navigatorKey.currentState?.canPop() == true) {
      navigatorKey.currentState?.pop<T>(result);
    }
  }

  /// Navigate back to the previous screen with result
  static void popAndPushNamed(String routeName, {Object? arguments}) {
    if (navigatorKey.currentState?.canPop() == true) {
      navigatorKey.currentState?.popAndPushNamed(routeName, arguments: arguments);
    }
  }

  /// Check if the navigator can pop
  static bool canPop() {
    return navigatorKey.currentState?.canPop() ?? false;
  }

  /// Get the current route name
  static String? getCurrentRouteName() {
    final context = navigatorKey.currentContext;
    if (context == null) return null;
    final Route? currentRoute = ModalRoute.of(context);
    return currentRoute?.settings.name;
  }
}