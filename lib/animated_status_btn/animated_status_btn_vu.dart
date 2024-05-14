// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'animated_status_btn_vm.dart';

class AnimatedButtonVU extends StackedView<AnimatedButtonVM> {
  double loadingOpacity = 0.0;

  AnimatedButtonVU({super.key});

  @override
  void onViewModelReady(AnimatedButtonVM viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.initializeAnimationController();
  }

  @override
  Widget builder(
      BuildContext context, AnimatedButtonVM viewModel, Widget? child) {
    return Scaffold(
        appBar: AppBar(
          title:
              Title(color: Colors.black, child: Text("Animated State Button")),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              AnimatedBuilder(
                animation: viewModel.ukWidthAnim.controller,
                builder: (_, value) {
                  return SizedBox(
                    width: viewModel.ukWidthAnim.tween.value,
                    height: 65,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        viewModel.successStatus = Random.secure().nextBool()
                            ? successState(viewModel)
                            : failureState(viewModel),
                        loadingState(viewModel),
                        payNowBtn(viewModel),
                      ],
                    ),
                  );
                },
              ),
            ])));
  }

  AnimatedBuilder successState(
    AnimatedButtonVM viewModel,
  ) {
    return AnimatedBuilder(
        animation: viewModel.resultOpacityController.controller,
        builder: (context, _) {
          return Opacity(
            opacity: viewModel.resultOpacityController.tween.value,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(50)),
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Transform.scale(
                      scale: viewModel.resultOpacityController.tween.value,
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 36,
                      ))),
            ),
          );
        });
  }

  AnimatedBuilder failureState(
    AnimatedButtonVM viewModel,
  ) {
    return AnimatedBuilder(
        animation: viewModel.resultOpacityController.controller,
        builder: (context, _) {
          return Opacity(
            opacity: viewModel.resultOpacityController.tween.value,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(50)),
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Transform.scale(
                      scale: viewModel.resultOpacityController.tween.value,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 36,
                      ))),
            ),
          );
        });
  }

  AnimatedBuilder loadingState(AnimatedButtonVM viewModel) {
    return AnimatedBuilder(
        animation: viewModel.loadingOpacityController.controller,
        builder: (context, snapshot) {
          return Opacity(
            opacity: viewModel.loadingOpacityController.tween.value,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(50)),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: CircularProgressIndicator(
                  // backgroundColor: Colors.red,
                  color: Colors.white,
                  // strokeWidth: 10,
                ),
              ),
            ),
          );
        });
  }

  Widget payNowBtn(AnimatedButtonVM viewModel) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          textStyle: TextStyle(fontSize: 24, color: Colors.white),
          minimumSize: Size.fromHeight(72),
          shape: StadiumBorder()),
      child: FittedBox(
          child: AnimatedBuilder(
              animation: viewModel.ukWidthAnim.controller,
              builder: (context, snapshot) {
                return Opacity(
                    opacity: viewModel.ukWidthAnim.tween.value / 300,
                    child: Text("Pay Now"));
              })),
      onPressed: () async {
        viewModel.callApi();
      },
    );
  }

  @override
  AnimatedButtonVM viewModelBuilder(BuildContext context) {
    return AnimatedButtonVM();
  }
}
