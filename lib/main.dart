import 'package:calculator/res/color.dart';
import 'package:calculator/ui/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);


  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  static const String title = 'Calculator';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(
      scaffoldBackgroundColor: ColorResources.background,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: const MainPage(title: title),
  );
}