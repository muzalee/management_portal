import 'package:flutter/material.dart';

import 'core/color_const.dart';
import 'injections.dart' as di;
import 'presentation/post/post_screen.dart';
import 'presentation/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Management Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: ColorConst.mainAppColor,
      ),
      navigatorKey: AppNavigator.navigatorKey,
      onGenerateRoute: AppNavigator.onGenerateRoute,
      home: const PostScreen(),
    );
  }
}