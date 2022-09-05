import 'package:court_finder/modules/admin/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {Key? key, required this.child, required this.title, this.floatingAction})
      : super(key: key);

  final Widget child;
  final String title;
  final Widget? floatingAction;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: AppBar(title: Text(title)),
      drawer: (size.width > 1218.0) ? null : const Drawer(child: AdminMenu()),
      body: (size.width > 1218.0)
          ? Row(
              children: [
                const AdminMenu(),
                const Divider(),
                SizedBox(width: size.width * 0.80, child: child),
              ],
            )
          : child,
      floatingActionButton: floatingAction,
    );
  }
}
