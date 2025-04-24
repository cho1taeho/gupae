import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:gupae/presentation/google_map_screen/google_map_state.dart';
import 'package:provider/provider.dart';

import '../../presentation/google_map_screen/google_map_screen.dart';
import '../../presentation/google_map_screen/google_map_screen_root.dart';
import '../../presentation/google_map_screen/google_map_view_model.dart';
import '../di/di_set_up.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => GoogleMapScreenRoot(
        googleMapViewModel: getIt<GoogleMapViewModel>(),
      ),
      routes: [
        GoRoute(
          path: 'sign-in',
          builder: (context, state) => SignInScreen(
            providers: [EmailAuthProvider()],
            actions: [
              AuthStateChangeAction((context, state) {
                final user = switch (state) {
                  SignedIn state => state.user,
                  UserCreated state => state.credential.user,
                  _ => null,
                };
                if (user == null) return;
                if (state is UserCreated) {
                  user.updateDisplayName(user.email!.split('@')[0]);
                }
                if (!user.emailVerified) {
                  user.sendEmailVerification();
                  const snackBar = SnackBar(
                      content: Text('Check your email to verify your account.'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                context.pushReplacement('/');
              }),
            ],
          ),
        ),
      ],
    ),
  ],
);
