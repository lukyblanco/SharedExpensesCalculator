import 'package:flutter/material.dart';
import 'package:web_calculator/providers/calculo_provider.dart';
import 'package:web_calculator/router/web_router.dart';
// import 'package:web_calculator/ui/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CalculoProvider(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: webRouter,
      debugShowCheckedModeBanner: false,
      title: 'Shared Expenses Calculator',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.indigo,
      ),
    );
  }
}








