import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/theme/theme_provider.dart';
import 'package:myapp/core/theme/app_theme.dart';
import 'package:myapp/features/home/presentation/pages/home_page.dart';
import 'package:myapp/core/utils/strings.dart';
import 'package:myapp/features/home/presentation/bloc/home_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        BlocProvider(create: (context) => HomeBloc()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: AppStrings.appTitle,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
