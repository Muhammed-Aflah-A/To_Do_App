import 'package:flutter/material.dart';
//imported home screen
import 'package:to_do_app/view/home_screen.dart';
//imported provider package
import 'package:provider/provider.dart';
//imported provider page
import 'notifier/provider.dart';

void main() {
  runApp(
    //multiple provider goes here------------------------------------------------------------------------------------------------>
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => TaskProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //app theme goes here------------------------------------------------------------------------------------------------------->
      theme: theme.isDark ? ThemeData.dark() : ThemeData.light(),
      title: "To Do Application",
      home: HomeScreen(),
    );
  }
}
