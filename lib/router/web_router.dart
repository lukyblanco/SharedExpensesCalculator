import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_calculator/ui/home_page.dart';
import 'package:web_calculator/ui/not_found_page.dart';
import 'package:web_calculator/ui/results.dart';

final webRouter = GoRouter(
  initialLocation: '/datos',
  errorPageBuilder: (context, state) => const MaterialPage(child: NotFoundPage()),
  routes: [
    GoRoute(
      // path: '/datos',
      path: '/datos',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      // path: '/results',
      path: '/results',
      builder: (context, state) => const ResultsPage(),
    ),
  ],
);
