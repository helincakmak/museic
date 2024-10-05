import 'package:flutter/material.dart';
import 'package:museic/alternative/page/home_wrapper_page.dart';
import '../page/home_page.dart';
import '../page/search_page.dart';
import '../page/library_page.dart';
import '../page/profile_page.dart';
import '../page/signup_page.dart';
import '../page/start_page.dart';


class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePageWrapper:
        return MaterialPageRoute(builder: (_) => HomePageWrapper());
      case homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case searchPage:
        return MaterialPageRoute(builder: (_) => SearchPage());
      case libraryPage:
        return MaterialPageRoute(builder: (_) => LibraryPage());
      case profilePage:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case startPage:
        return MaterialPageRoute(builder: (_) => StartPage());
      case signupPage:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static const String homePageWrapper = '/homePageWrapper';
  static const String homePage = '/home';
  static const String searchPage = '/search';
  static const String libraryPage = '/library';
  static const String profilePage = '/profile';
  static const String startPage = '/start';
  static const String signupPage = '/signup';
}
