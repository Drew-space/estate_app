import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:flutter/material.dart';

final connectivityProvider = Provider<ConnectivityService>((ref) {
  final service = ConnectivityService();
  ref.onDispose(() => service.dispose());
  return service;
});

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  bool? _wasOnline; // null = unknown (first check, don't toast)

  ConnectivityService() {
    _subscription = _connectivity.onConnectivityChanged.listen(_handleChange);
  }

  void _handleChange(List<ConnectivityResult> results) {
    final isOnline = results.any((r) => r != ConnectivityResult.none);

    // Skip the very first event so we don't toast on app launch
    if (_wasOnline == null) {
      _wasOnline = isOnline;
      return;
    }

    if (_wasOnline == isOnline) return; // no actual change, ignore

    _wasOnline = isOnline;

    if (isOnline) {
      Fluttertoast.showToast(
        msg: "Back online",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } else {
      Fluttertoast.showToast(
        msg: "No internet connection",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void dispose() {
    _subscription.cancel();
  }
}
