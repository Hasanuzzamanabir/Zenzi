import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoxBreathingController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _rotationController;

  // Phase 1: Breathe In (4s)
  // Phase 2: Hold (4s)
  // Phase 3: Breathe Out (4s)
  // 0: Completed
  final RxInt _phase = 1.obs;
  final RxInt _cycle = 0.obs;
  final int _totalCycles = 5;

  // Expose values for UI
  int get phase => _phase.value;
  int get cycle => _cycle.value;
  int get totalCycles => _totalCycles;

  // Animation values
  AnimationController get mainController => _mainController;
  Animation<double> get rotationAnimation => _rotationController;

  // Derived timer value (1-4)
  // We use Rx to stream it efficiently or just use AnimatedBuilder in UI
  // But since we want to show strict integer seconds, an RxInt derived from listener is okay
  // or just let the UI derive it from controller value.
  // Let's provide a getter for simplicity in reactive context if needed,
  // but better to use AnimatedBuilder in the view for smooth text if we wanted ms,
  // for seconds, a simple listener here updating an Rx is fine.
  final RxInt _countdown = 1.obs;
  int get countdown => _countdown.value;

  @override
  void onInit() {
    super.onInit();

    // Main cycle controller - duration 4s always
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _mainController.addListener(() {
      // Calculate 1-4 seconds
      // value goes 0.0 -> 1.0 in 4 seconds
      // So: (value * 4).toInt() + 1
      final int val = (_mainController.value * 4).toInt() + 1;
      if (val != _countdown.value && val <= 4) {
        _countdown.value = val;
      }
    });

    // Rotation controller - loops continuously
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // Start the cycle
    _startPhaseSequence();
  }

  void _startPhaseSequence() {
    _cycle.value = 0;
    _phase.value = 1;
    _playPhase(1); // Start with Breathe In
  }

  Future<void> _playPhase(int pha) async {
    if (_cycle.value >= _totalCycles) {
      _phase.value = 0; // Completed
      return;
    }

    _phase.value = pha;
    _mainController.reset();

    // We animate 0->1 for ALL phases to drive the timer consistently
    // The VISUAL scale will be derived in the View/Painter based on the phase
    // In: Scale = value
    // Hold: Scale = 1.0 (static)
    // Out: Scale = 1.0 - value

    await _mainController.forward();

    // When finished:
    if (pha == 1) {
      // End of In
      _playPhase(2); // Go to Hold
    } else if (pha == 2) {
      // End of Hold
      _playPhase(3); // Go to Out
    } else if (pha == 3) {
      // End of Out
      // Cycle completed
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
        return "Tap to start";
    }
  }

  @override
  void onClose() {
    _mainController.dispose();
    _rotationController.dispose();
    super.onClose();
  }
}
