import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/home/homepage.dart';
import 'providers/portfolio_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PortfolioProvider()..loadPortfolioData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Portfolio',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const PortfolioHomePage(),
      ),
    );
  }
}
