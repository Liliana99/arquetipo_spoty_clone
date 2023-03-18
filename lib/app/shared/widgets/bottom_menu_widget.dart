import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/authentication/authentication_cubit.dart';

class MenuItems {
  MenuItems(this.icon, this.label, this.route, {action = false});

  Icon icon;
  String label;
  String route;
}

List<MenuItems Function(BuildContext)> items = [
  (BuildContext context) =>
      MenuItems(const Icon(Icons.home), S.of(context)!.menuHome, '/home'),
  (BuildContext context) =>
      MenuItems(const Icon(Icons.extension), S.of(context)!.menuMore, '/more'),
  (BuildContext context) => MenuItems(
      const Icon(Icons.sports_bar), S.of(context)!.menuRandom, '/random'),
  (BuildContext context) => MenuItems(
      const Icon(Icons.settings), S.of(context)!.menuLogout, 'logout'),
];

class BottomMenu extends StatelessWidget {
  final int index;

  const BottomMenu(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: items
          .map((e) => BottomNavigationBarItem(
                icon: e(context).icon,
                label: e(context).label,
              ))
          .toList(),
      currentIndex: index,
      selectedItemColor: Theme.of(context).primaryColor,
      onTap: (index) {
        String route = items[index](context).route;
        const string = 'logout';
        if (route == string) {
          BlocProvider.of<AuthenticationCubit>(context)
              .authenticationLogoutRequested();
          return;
        }
        GoRouter.of(context).go(route);
      },
    );
  }
}
