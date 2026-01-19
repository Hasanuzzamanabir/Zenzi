import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FourSevenEightBreathingController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _mainController;
  // No rotation needed for this new design

  // Phase 1: Breathe In (4s)
  // Phase 2: Hold (7s)
  // Phase 3: Breathe Out (8s)
  final RxInt _phase = 1.obs;
  final RxInt _cycle = 0.obs;
  final int _totalCycles = 4;

  // Expose values for UI
  int get phase => _phase.value;
  int get cycle => _cycle.value;
  int get totalCycles => _totalCycles;

  AnimationController get mainController => _mainController;

  final RxInt _countdown = 1.obs;
  int get countdown => _countdown.value;

  @override
  void onInit() {
    super.onInit();

    // Duration will be set dynamically per phase
    _mainController = AnimationController(vsync: this);

    _mainController.addListener(() {
      // Calculate countdown seconds relative to current phase duration
      // value goes 0.0 -> 1.0
      // Current Seconds = (value * totalSeconds).toInt() + 1
      double durationSecs = 4.0;
      if (_phase.value == 2) durationSecs = 7.0;
      if (_phase.value == 3) durationSecs = 8.0;

      final int val = (_mainController.value * durationSecs).toInt() + 1;

      // Safety clamp
      if (val != _countdown.value && val <= durationSecs) {
        _countdown.value = val;
      }
    });

    // Start
    _startPhaseSequence();
  }

  void _startPhaseSequence() {
    _cycle.value = 0;
    _phase.value = 1;
    _playPhase(1);
  }

  Future<void> _playPhase(int pha) async {
    if (_cycle.value >= _totalCycles) {
      _phase.value = 0; // Completed
      return;
    }

    _phase.value = pha;
    _mainController.reset();

    // Set duration based on strict 4-7-8 rule
    if (pha == 1) {
      _mainController.duration = const Duration(seconds: 4);
    } else if (pha == 2) {
      _mainController.duration = const Duration(seconds: 7);
    } else if (pha == 3) {
      _mainController.duration = const Duration(seconds: 8);
    }

    await _mainController.forward();

    // Determine next step
    if (pha == 1) {
      _playPhase(2); // In -> Hold
    } else if (pha == 2) {
      _playPhase(3); // Hold -> Out
    } else if (pha == 3) {
      // Out -> Complete Cycle
      _cycle.value++;

      if (_cycle.value < _totalCycles) {
        _playPhase(1); // Loop back
      } else {
        _phase.value = 0; // Done
      }
    }
  }

  String get titleText {
    switch (_phase.value) {
      case 1:
        return "Breathe In";
      case 2:
        return "Hold";
      case 3:
        return "Breathe Out";
      case 0:
        return "Completed";
      default:
        return "Ready";
    }
  }

  String get subtitleText {
    switch (_phase.value) {
      case 1:
        return "Fill your lungs slowly and deeply";
      case 2:
        return "Hold your breath gently";
      case 3:
        return "Release your breath slowly";
      case 0:
        return "Great job! Session finished.";
      default:
        return "";
    }
  }

  @override
  void onClose() {
    _mainController.dispose();
    super.onClose();
  }
}
