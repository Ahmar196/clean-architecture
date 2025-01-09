
import 'package:apis_/example_two.dart';
  
import 'package:apis_/view_model.dart/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'repository/user_repository.dart'; // Add repository


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserViewModel(UserRepository()), // Inject repository
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MVVM with Repository',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ExampleTwo(),
    );
  }
}
