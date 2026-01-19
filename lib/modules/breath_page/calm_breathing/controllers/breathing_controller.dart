import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum BreathPhase { inPhase, hold, reset }

class CalmBreathingController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _mainController;

  final Rx<BreathPhase> _phase = BreathPhase.inPhase.obs;
  final RxInt _cycle = 0.obs;
  final int _totalCycles = 4;

  // Expose values for UI
  BreathPhase get phase => _phase.value;
  int get cycle => _cycle.value;
  int get totalCycles => _totalCycles;

  AnimationController get mainController => _mainController;

  final RxInt _countdown = 1.obs;
  int get countdown => _countdown.value;

  @override
  void onInit() {
    super.onInit();

    // Main controller used for In phase scaling
    _mainController = AnimationController(vsync: this);

    _mainController.addListener(() {
      // Countdown logic:
      // In InPhase (5s): value 0->1. Seconds: (value * 5).toInt() + 1
      if (_phase.value == BreathPhase.inPhase) {
        final int val = (_mainController.value * 5).toInt() + 1;
        if (val != _countdown.value && val <= 5) _countdown.value = val;
      }
    });

    // Start
    _startSequence();
  }

  void _startSequence() {
    _cycle.value = 0;
    _startInhale();
  }

  void _startInhale() {
    if (_cycle.value >= _totalCycles) return;

    _phase.value = BreathPhase.inPhase;
    _mainController.reset();
    _mainController.duration = const Duration(seconds: 5);

    _mainController.forward().then((_) {
      // When inhale finishes
      _startHold();
    });
  }

  void _startHold() {
    _phase.value = BreathPhase.hold;
    // Stop controller at max (it should already be at 1.0 from forward, but ensuring)
    _mainController.value = 1.0;

    // Manual timer for Hold (5s) since we are not animating values
    int holdSeconds = 1;
    _countdown.value = 1;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      holdSeconds++;
      if (holdSeconds <= 5) {
        _countdown.value = holdSeconds;
      } else {
        timer.cancel();
        _finishCycle();
      }
    });
  }

  void _finishCycle() {
    // Increment cycle
    _cycle.value++;

    if (_cycle.value < _totalCycles) {
      // Instant Reset for next cycle
      _mainController.reset(); // 0s duration effectively
      _startInhale();
    } else {
      // Finished all cycles
      _mainController.reset();
      _phase.value = BreathPhase.reset; // Just a neutral state
    }
  }

  String get titleText {
    switch (_phase.value) {
      case BreathPhase.inPhase:
        return "Breathe In";
      case BreathPhase.hold:
        return "Hold";
      default:
        return "";
    }
  }

  String get subtitleText {
    switch (_phase.value) {
      case BreathPhase.inPhase:
        return "Fill your lungs slowly and deeply";
      case BreathPhase.hold:
        return "Hold your breath gently";
      default:
        return "Cycle Completed";
    }
  }

  @override
  void onClose() {
    _mainController.dispose();
    super.onClose();
  }
}
