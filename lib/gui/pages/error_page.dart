import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/providers/session_provider.dart';

class ErrorPage extends ConsumerWidget {

  final String? errorText;

  const ErrorPage({
    super.key,
    this.errorText
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Center(
          child: Padding(
            padding: EdgeInsetsGeometry.all(100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Uh oh!",
                  style: TextStyle(fontFamily: "Anton", fontSize: 50),
                ),
                Text(
                  "It seems like we've encountered a problem.\nPlease restart!",
                ),
                Text(
                  "What's wrong: ${errorText ?? "unexpected"}"
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 50,
                  children: [
                    ElevatedButton(
                      child: Text("Restart"),
                      onPressed: () =>
                          ref.read(sessionProvider.notifier).restart(),
                    ),
                    ElevatedButton(
                      child: Text("Exit"),
                      onPressed: () =>
                          exit(0)
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
