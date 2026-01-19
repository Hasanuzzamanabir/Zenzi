import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum BreathPhase { inPhase, hold, outPhase, reset }

class EnergizingBreathingController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _mainController;

  final Rx<BreathPhase> _phase = BreathPhase.inPhase.obs;
  final RxInt _cycle = 0.obs;
  final int _totalCycles = 8;

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

    // Main controller used for In/Out phase scaling
    _mainController = AnimationController(vsync: this);

    _mainController.addListener(() {
      // Countdown logic (3s for In/Out)
      if (_phase.value == BreathPhase.inPhase ||
          _phase.value == BreathPhase.outPhase) {
        // Value goes 0->1 in 3 seconds
        final int val = (_mainController.value * 3).toInt() + 1;
        if (val != _countdown.value && val <= 3) _countdown.value = val;
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
    _mainController.duration = const Duration(seconds: 3);

    _mainController.forward().then((_) {
      _startHold();
    });
  }

  void _startHold() {
    _phase.value = BreathPhase.hold;
    _mainController.value = 1.0; // Ensure max size

    // Manual timer for Hold (3s)
    int holdSeconds = 1;
    _countdown.value = 1;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      holdSeconds++;
      if (holdSeconds <= 3) {
        _countdown.value = holdSeconds;
      } else {
        timer.cancel();
        _startExhale(); // Go to Exhale instead of finish
      }
    });
  }

  void _startExhale() {
    _phase.value = BreathPhase.outPhase;
    _mainController.duration = const Duration(seconds: 3);

    // We want to animate from 1.0 down to 0.0?
    // Usually animateTo(0.0) works, but let's simply reverse?
    // Or just animate 0->1 and map it in view?
    // Let's simple animate 1.0 -> 0.0

    _mainController.reverse(from: 1.0).then((_) {
      _finishCycle();
    });
  }

  void _finishCycle() {
    // Increment cycle
    _cycle.value++;

    if (_cycle.value < _totalCycles) {
      // Loop back
      _startInhale();
    } else {
      // Finished all cycles
      _mainController.reset();
      _phase.value = BreathPhase.reset;
    }
  }

  String get titleText {
    switch (_phase.value) {
      case BreathPhase.inPhase:
        return "Breathe In";
      case BreathPhase.hold:
        return "Hold";
      case BreathPhase.outPhase:
        return "Breathe Out";
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
      case BreathPhase.outPhase:
        return "Release your breath slowly";
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
