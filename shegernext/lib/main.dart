import 'package:flutter/material.dart';
import 'package:shegernext/core/config/app_router.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
    routerConfig: appRouter, 
    title: 'Sheger Next', 
    debugShowCheckedModeBanner: false,
    );
  }
}