// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

_AppUtils appUtils = _AppUtils.instance;

class _AppUtils {
  _AppUtils._();

  static final _AppUtils instance = _AppUtils._();

  showToast(context, String message) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
