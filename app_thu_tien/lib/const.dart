import 'package:flutter/cupertino.dart';

class Const {
  static bool isAdmin = true;
  static BoxDecoration decoration = const BoxDecoration(
    color: CupertinoColors.systemBackground,
    borderRadius: BorderRadius.all(Radius.circular(7)),
    border: Border(
      left: BorderSide(color: CupertinoColors.placeholderText),
      top: BorderSide(color: CupertinoColors.placeholderText),
      right: BorderSide(color: CupertinoColors.placeholderText),
      bottom: BorderSide(color: CupertinoColors.placeholderText),
    ),
  );
}
