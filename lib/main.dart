import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_pregum_sample/account_page.dart';
import 'package:supabase_pregum_sample/login_email_password_page.dart';
import 'package:supabase_pregum_sample/login_page.dart';
import 'package:supabase_pregum_sample/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: 'https://ubdzwcqymgcyzeinuqrc.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyNjk5OTQ1MSwiZXhwIjoxOTQyNTc1NDUxfQ.eB5z-D8DUKuwnwEy39UZ5AGFnb9KoVFquOEb3zz4948');

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // setup routing
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (_, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const SplashPage(),
        ),
      ),
      GoRoute(
        path: '/account',
        pageBuilder: (_, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const AccountPage(),
        ),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (_, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: '/login_email_password',
        pageBuilder: (context, state) => const MaterialPage<void>(
          // key: state.pageKey,
          child: LoginEmailPasswordPage(),
        ),
      )
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Supabase Flutter',
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      routeInformationProvider: _router.routeInformationProvider,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.green,
            // onSurface: Colors.,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            onSurface: Colors.green,
            onPrimary: Colors.white,
          ),
        ),
      ),
    );
  }
}
