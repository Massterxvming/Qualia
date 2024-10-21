import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:qualia/controller/controller.dart';

import 'app_controller.dart';

abstract class AppStateBase<T extends StatefulWidget, C extends ControllerBase>
    extends State<T> {
  StreamSubscription? themeSub;
  StreamSubscription? pageNeedRebuildSub;
  C? controller;

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (!mounted) {
      return;
    }
    super.setState(() {});
  }

  @override
  void initState(){
    super.initState();
    themeSub = controller?.themeModeRx.listen((val){
      setState((){});
    });
    pageNeedRebuildSub = controller?.pageNeedRebuildRx.listen((val){
      setState((){});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    themeSub?.cancel();
    pageNeedRebuildSub?.cancel();
  }
}

abstract class AppPageBase<T extends StatefulWidget> extends AppStateBase<T,AppController>{
  @override
  // TODO: implement controller
  AppController? get controller => Get.find<AppController>();

}