// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../controller/animation_controller.dart';

class AnimatedButtonVM extends BaseViewModel {
  late UKAnimController ukWidthAnim;
  late UKAnimController loadingOpacityController;
  late UKAnimController resultOpacityController;
  bool loadingInProgress = false;
  var successStatus;

  void initializeAnimationController() {
    ukWidthAnim =
        UKAnimController(duration: 300, tweenStart: 300, tweenEnd: 65);
    loadingOpacityController =
        UKAnimController(duration: 300, tweenStart: 0, tweenEnd: 1);
    resultOpacityController =
        UKAnimController(duration: 300, tweenStart: 0, tweenEnd: 1);

    ukWidthAnim.controller.addStatusListener((status) async {
      debugPrint("ukWidthAnim status: $status");
      // debugPrint("ukWidthAnim status: $status");
      if (status == AnimationStatus.completed) {
        if (loadingInProgress == true) {
          loadingOpacityController.controller.forward();
          await Future.delayed(const Duration(seconds: 1));

          resultOpacityController.controller.forward();
        } else {
          ukWidthAnim.controller.reverse();
        }
      }
    });

    loadingOpacityController.controller.addStatusListener((status) {
      debugPrint("ukProgresOpacityAnim status: $status");
      // if(status == AnimationStatus.completed){}
    });

    resultOpacityController.controller.addStatusListener((status) {
      debugPrint("resultOpacityController status: $status");

      if (status == AnimationStatus.dismissed) {
        ukWidthAnim.controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    ukWidthAnim.dispose();
    super.dispose();
  }

  callApi() async {
    ukWidthAnim.forward();
    loadingInProgress = true;
    await Future.delayed(const Duration(seconds: 1));
    loadingInProgress = false;
    // print("Loading complete .....");
    loadingOpacityController.controller.reverse();
    await Future.delayed(const Duration(seconds: 1));
    resultOpacityController.controller.reverse();
  }
}
