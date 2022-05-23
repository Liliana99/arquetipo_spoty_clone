import 'package:arquetipo_flutter_bloc/app/shared/blocs/authentication/authentication_bloc.dart';
import 'package:arquetipo_flutter_bloc/app/shared/blocs/authentication/authentication_event_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MenuItems {
  MenuItems(this.icon, this.label, this.route, {action = false});

  Icon icon;
  String label;
  String route;
}

List<MenuItems Function(BuildContext)> items = [
  (BuildContext context) =>
      MenuItems(Icon(Icons.home), S.of(context)!.menuHome, '/home'),
  (BuildContext context) =>
      MenuItems(Icon(Icons.extension), S.of(context)!.menuMore, '/more'),
  (BuildContext context) =>
      MenuItems(Icon(Icons.sports_bar), S.of(context)!.menuRandom, '/random'),
  (BuildContext context) =>
      MenuItems(Icon(Icons.settings), S.of(context)!.menuLogout, 'logout'),
];

class BottomMenu extends StatelessWidget {
  final int index;

  const BottomMenu(this.index);

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
        final string = 'logout';
        if (route == string) {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationLogoutRequested());
          return;
        }
        GoRouter.of(context).go(route);
      },
    );
  }
}
