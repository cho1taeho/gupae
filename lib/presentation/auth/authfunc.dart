import 'package:flutter/material.dart';

class AuthFunc extends StatelessWidget {
  final bool loggedIn;
  final VoidCallback signOut;

  const AuthFunc({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });

  @override
  Widget build(BuildContext context) {
    if (loggedIn) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('You’re logged in'),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: signOut,
            child: const Text('LOGOUT'),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('You’re not logged in'),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed('/sign-in'),
            child: const Text('LOGIN'),
          ),
        ],
      );
    }
  }
}
