import 'package:flutter/material.dart';
import 'package:notes_app/pages/add_edit_note.dart';
import 'package:notes_app/pages/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          "/": (ctx) => Home(),
          "/add-edit": (ctx) => AddEditNote(currentNote: settings.arguments),
        };
        WidgetBuilder? builder = routes[settings.name]!;
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
    );
  }
}
