import 'package:flutter/material.dart';
import 'package:promaxbiz/model/web_model.dart';
import 'package:promaxbiz/pages/load_screen.dart';
import 'package:promaxbiz/pages/my_home_page.dart';
import 'package:promaxbiz/theme/palette_dark.dart';
import 'package:promaxbiz/utils/my_error_widget.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //create: (context) => ChainList(context, adState),
          create: (context) => WebModel(context),
        ),
      ],
      child: const MyWeb(),
    ),
  );
}

class MyWeb extends StatelessWidget {
  const MyWeb({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WebModel webModel = Provider.of<WebModel>(context, listen: true);
    return MaterialApp(
      title: 'Pro Max Biz',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),

        useMaterial3: true,
        primarySwatch: PaletteDark.lightGrey,
        scaffoldBackgroundColor: PaletteDark.lightGrey.shade900,
        cardColor: PaletteDark.lightGrey.shade800,
        canvasColor: PaletteDark.lightGrey,
        colorScheme: ColorScheme.dark(
          surface: PaletteDark.lightGrey,
          primary: PaletteDark.lightGrey.shade700,
          onPrimary: Colors.amber,
        ),
        dialogBackgroundColor: PaletteDark.lightGrey,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (states) => PaletteDark.lightGrey,
            ),
            foregroundColor: WidgetStateProperty.resolveWith<Color>(
              (states) => Colors.amber,
            ),
            textStyle: WidgetStateProperty.resolveWith(
              (states) => Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
        listTileTheme: ListTileThemeData(
          tileColor: PaletteDark.lightGrey,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return PaletteDark.lightGrey;
              } else {
                return Colors.grey;
              }
            },
          ),
          trackColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.grey;
            } else {
              return PaletteDark.lightGrey;
            }
          }),
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: PaletteDark.lightGrey,
        ),
        dividerTheme: DividerThemeData(
          color: PaletteDark.lightGrey.shade700,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: PaletteDark.lightGrey,
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: PaletteDark.lightGrey.shade700,
        ),
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.grey.withOpacity(0.5),
          cursorColor: Colors.amber,
          selectionHandleColor: Colors.grey,
        ),
        snackBarTheme: const SnackBarThemeData(
          actionTextColor: Colors.amber,
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            color: Colors.amber,
          ),
          titleLarge: TextStyle(
            color: Colors.amber,
          ),
          titleSmall: TextStyle(
            color: Colors.amber,
          ),
          bodyMedium: TextStyle(
            color: Colors.amber,
          ),
          bodyLarge: TextStyle(
            color: Colors.amber,
          ),
          bodySmall: TextStyle(
            color: Colors.amber,
          ),
          headlineMedium: TextStyle(
            color: Colors.amber,
          ),
          headlineLarge: TextStyle(
            color: Colors.amber,
          ),
          headlineSmall: TextStyle(
            color: Colors.amber,
          ),
          displayMedium: TextStyle(
            color: Colors.amber,
          ),
          displayLarge: TextStyle(
            color: Colors.amber,
          ),
          displaySmall: TextStyle(
            color: Colors.amber,
          ),
          labelMedium: TextStyle(
            color: Colors.amber,
          ),
          labelLarge: TextStyle(
            color: Colors.amber,
          ),
          labelSmall: TextStyle(
            color: Colors.amber,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        Widget error = const Scaffold(body: Center(child: MyErrorWidget()));
        ErrorWidget.builder = (errorDetails) => error;
        if (child != null) {
          return ResponsiveBreakpoints.builder(
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
            child: child,
          );
        }
        throw ('widget is null');
      },
      // initialRoute: "/",
      home: FutureBuilder(
        future: Provider.of<WebModel>(context, listen: false).initialize(),
        builder: (ctx, snap) {
          if (!webModel.loaded) {
            return const LoadScreen();
          } else {
            return const MyHomePage();
          }
        },
      ),
      routes: {
        LoadScreen.name: (context) => const LoadScreen(),
        MyHomePage.name: (context) => const MyHomePage(),
      },
    );
  }
}
