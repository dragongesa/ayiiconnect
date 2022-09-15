import 'package:ayiconnect/app/modules/findhelper/view/findhelper_view.dart';
import 'package:ayiconnect/app/modules/initial/view/initial_view.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const InitialView(),
    ),
    GoRoute(
      path: '/find-helper',
      builder: (context, state) => const FindHelperView(),
    ),
  ],
  redirect: (state) {
    if (state.location == '/') {
      return '/find-helper';
    }
    return null;
  },
);
