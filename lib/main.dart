import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:promaxbiz/apps/createchain/models/chain_list.dart';
import 'package:promaxbiz/apps/createchain/screens/add_chain_screen.dart';
import 'package:promaxbiz/pages/my_home_page.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        // Provider.value(
        //   value: localNotifyService,
        // ),
        // Provider.value(
        //   value: adState,
        // ),
        // Provider(
        //   //create: (context) => ChainList(context, adState),
        //   create: (context) => LocalNotificationService(),
        // ),
        ChangeNotifierProvider(
          //create: (context) => ChainList(context, adState),
          create: (context) => ChainList(context),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pro Max Biz',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.black,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.black,
          onPrimary: Colors.black,
          secondary: Colors.grey,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.grey,
          onSurface: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            ),
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (states) => Colors.white,
            ),
            foregroundColor: WidgetStateProperty.resolveWith<Color>(
              (states) => Colors.black,
            ),
            textStyle: WidgetStateProperty.resolveWith(
              (states) => Theme.of(context).textTheme.labelLarge,
            ),
            iconColor: WidgetStateProperty.resolveWith<Color>(
              (states) => Colors.black,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
            iconColor: WidgetStateProperty.all<Color>(Colors.white),
            foregroundColor: WidgetStateProperty.all<Color>(
              Colors.white,
            ),
            textStyle: WidgetStateProperty.all<TextStyle>(
              const TextStyle(
                decorationColor: Colors.white,
              ),
            ),
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(
              Colors.white,
            ),
            iconColor: WidgetStateProperty.all<Color>(
              Colors.white,
            ),
          ),
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            color: Colors.white,
          ),
          titleSmall: TextStyle(
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
          ),
          bodySmall: TextStyle(
            color: Colors.white,
          ),
          headlineMedium: TextStyle(
            color: Colors.white,
          ),
          headlineLarge: TextStyle(
            color: Colors.white,
          ),
          headlineSmall: TextStyle(
            color: Colors.white,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
          ),
          displayLarge: TextStyle(
            color: Colors.white,
          ),
          displaySmall: TextStyle(
            color: Colors.white,
          ),
          labelMedium: TextStyle(
            color: Colors.white,
          ),
          labelLarge: TextStyle(
            color: Colors.white,
          ),
          labelSmall: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      home: const MyHomePage(),
      routes: {
        AddChainScreen.routename: (context) => const AddChainScreen(),
      },
    );
  }
}
