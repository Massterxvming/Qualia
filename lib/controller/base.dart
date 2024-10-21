
import 'package:flutter/material.dart';

import '../common/common.dart';

class ControllerBase extends GetxController{
  Rx<bool> pageNeedRebuildRx = Rx(false);

  Rx<ThemeMode> themeModeRx = Rx(ThemeMode.system);
}