import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show AuthException;
import 'package:supabase_pregum_sample/build_context_ex.dart';
import 'package:gotrue/gotrue.dart' as gotrue;

final _emailEditingControllerProvider =
    Provider.autoDispose<TextEditingController>(
        (ref) => TextEditingController());
final _passwordEditingControllerProvider =
    Provider.autoDispose<TextEditingController>(
        (ref) => TextEditingController());

class LoginEmailPasswordPage extends ConsumerStatefulWidget {
  const LoginEmailPasswordPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginEmailPasswordPage> createState() =>
      _LoginEmailPasswordPageState();
}

class _LoginEmailPasswordPageState
    extends ConsumerState<LoginEmailPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final emailEditingController = ref.watch(_emailEditingControllerProvider);
    final passwordEditingController =
        ref.watch(_passwordEditingControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In with password'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: emailEditingController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: passwordEditingController,
            decoration: const InputDecoration(labelText: 'password'),
          ),
          ElevatedButton(
            child: const Text('Sign In'),
            onPressed: () async {
              try {
                final authResponse = await supabase.auth.signInWithPassword(
                    password: passwordEditingController.text,
                    email: emailEditingController.text);
                print('${authResponse.user}');
              } on AuthException catch (error) {
                print('auth ex: ${error.message}');
              } catch (error) {
                print('error: $error');
              }
              // .getOAuthSignInUrl(provider: gotrue.Provider.github);
              // print('url: ${response.url}');
            },
          )
        ],
      ),
    );
  }
}
