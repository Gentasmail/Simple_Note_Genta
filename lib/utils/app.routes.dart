import 'package:flutter/material.dart';
import 'package:simple_note/pages/add_note_page.dart';
import 'package:simple_note/pages/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_note/models/note.dart';

class AppRoutes {
  static const home = "home";
  static const addNote = 'add-note';
  static const editNote = 'edit-note';

  static Page homePageBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return const MaterialPage(
      child: HomePage(),
    );
  }

  static Page addNotePageBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return const MaterialPage(
      child: AddNotePage(),
    );
  }

  static Page editNotePageBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return MaterialPage(
      child: AddNotePage(
        note: state.extra as Note,
      ),
    );
  }

  static GoRouter goRouter = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        name: home,
        path: "/",
        pageBuilder: homePageBuilder,
        routes: [
          GoRoute(
            name: addNote,
            path: "add-note",
            pageBuilder: addNotePageBuilder,
          ),
          GoRoute(
            name: editNote,
            path: "edit-note",
            pageBuilder: editNotePageBuilder,
          ),
        ],
      ),
    ],
  );
}
