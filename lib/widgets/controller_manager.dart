import 'package:flutter/cupertino.dart';

class ControllerManager {
  static final ControllerManager _instance = ControllerManager._internal();

  factory ControllerManager() => _instance;

  ControllerManager._internal();

  final TextEditingController pickFieldController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  final FocusNode pickFieldFocusNode = FocusNode();
  final FocusNode destinationFocusNode = FocusNode();
}
