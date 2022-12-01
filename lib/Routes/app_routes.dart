import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pharmatask/features/Authentication/presentation/screens/sign_in_page.dart';
import 'package:pharmatask/features/Authentication/presentation/screens/sign_up_page.dart';
import 'package:pharmatask/features/Dashboard/Presentation/screens/dashboard_page.dart';
import 'package:pharmatask/features/Movies/Presentation/Screens/movies_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case 'sign_up':
        return MaterialPageRoute(
          builder: (context) => SignUpPage(),
        );
      case 'sign_in':
        return MaterialPageRoute(
          builder: (context) => SignInPage(),
        );
      case 'dashboard':
        return MaterialPageRoute(builder: (context) {
          log(args.toString());
          return DashboardPage(username: args.toString());
        });
      case 'movies':
        return MaterialPageRoute(
          builder: (context) => const MoviesPage(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: const Text("Error")),
          body: const Center(child: Text("Page not found")),
        );
      },
    );
  }
}
