// config/router/go_router_notifier.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:canoptico_app/features/auth/auth.dart';

class GoRouterNotifier extends ChangeNotifier {
  final AuthBloc _authBloc;
  late final StreamSubscription _subscription;

  GoRouterNotifier(this._authBloc) {
    _subscription = _authBloc.stream.listen((authState) {
      notifyListeners();
    });
  }

  AuthStatus get authStatus => _authBloc.state.status;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
