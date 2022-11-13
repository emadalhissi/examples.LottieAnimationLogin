import 'package:flutter/material.dart';

enum BunnyState {
  neutral,
  tracking,
  shy,
  peek,
}

class MyBunny {
  MyBunny(this.controller) {
    setNeutralState();
  }

  AnimationController controller;

  static const List<int> _neutralToTracking = [4, 22];
  static const List<int> _trackingToNeutral = [0, 0];

  static const List<int> _neutralToShy = [29, 39];
  static const List<int> _shyToNeutral = [44, 54];

  static const List<int> _neutralToPeek = [76, 68];
  static const List<int> _peekToNeutral = [68, 76];

  static const List<int> _shyToPeek = [59, 68];
  static const List<int> _peekToShy = [68, 59];

  BunnyState currentState = BunnyState.neutral;

  void setNeutralState() {
    switch (currentState) {
      case BunnyState.neutral:
        return;
      case BunnyState.tracking:
        setMinMaxFrame(_trackingToNeutral);
        break;
      case BunnyState.shy:
        setMinMaxFrame(_shyToNeutral);
        break;
      case BunnyState.peek:
        setMinMaxFrame(_peekToNeutral);
        break;
    }

    currentState = BunnyState.neutral;
  }

  void setShyState() {
    switch (currentState) {
      case BunnyState.neutral:
      case BunnyState.tracking:
        setMinMaxFrame(_neutralToShy);
        break;
      case BunnyState.shy:
        return;
      case BunnyState.peek:
        setMinMaxFrame(_peekToShy);
        break;
    }

    currentState = BunnyState.shy;
  }

  void setPeekState() {
    switch (currentState) {
      case BunnyState.neutral:
      case BunnyState.tracking:
        setMinMaxFrame(_neutralToPeek);
        break;
      case BunnyState.shy:
        setMinMaxFrame(_shyToPeek);
        break;
      case BunnyState.peek:
        return;
    }

    currentState = BunnyState.peek;
  }

  void setTrackingState() {
    switch (currentState) {
      case BunnyState.neutral:
        setMinMaxFrame(_trackingToNeutral);
        break;
      case BunnyState.tracking:
        return;
      case BunnyState.shy:
        setMinMaxFrame(_shyToNeutral);
        break;
      case BunnyState.peek:
        setMinMaxFrame(_peekToNeutral);
        break;
    }

    currentState = BunnyState.tracking;
  }

  void setEyesPosition(double progress) {
    if (currentState != BunnyState.tracking) {
      setMinMaxFrame(_trackingToNeutral);
      currentState = BunnyState.tracking;
      return;
    }
    if (progress > 1) {
      return;
    }

    final double frame =
        (_neutralToTracking[1] - _neutralToTracking[0]) * progress;
    controller.animateTo(
        framesToPercentage(frame.toInt() + _neutralToTracking[0]),
        duration: Duration.zero);
  }

  void setMinMaxFrame(List<int> frames) {
    controller.animateTo(framesToPercentage(frames[0]),
        duration: Duration.zero);

    controller.animateTo(framesToPercentage(frames[1]));
  }

  double framesToPercentage(int frame) {
    return frame / 77;
  }
}
