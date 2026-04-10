import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenzi/modules/breath_page/controller/breathing_controller.dart';
import 'package:zenzi/modules/breath_page/controller/breathing_sessions_controller.dart';

class BoxBreathingController extends GetxController
    with GetTickerProviderStateMixin {
  BoxBreathingController({
    required int exerciseId,
    required int inhaleSeconds,
    required int holdSeconds,
    required int exhaleSeconds,
    required int totalCycles,
    required int totalSession,
  }) : _exerciseId = exerciseId,
       _inhaleSeconds = inhaleSeconds > 0 ? inhaleSeconds : 4,
       _holdSeconds = holdSeconds > 0 ? holdSeconds : 4,
       _exhaleSeconds = exhaleSeconds > 0 ? exhaleSeconds : 4,
       _totalCycles = totalCycles > 0 ? totalCycles : 5,
       _totalSession = totalSession;

  late AnimationController _mainController;
  late AnimationController _rotationController;

  final int _exerciseId;
  final int _inhaleSeconds;
  final int _holdSeconds;
  final int _exhaleSeconds;
  final int _totalSession;

  // Phase 1: Breathe In (4s)
  // Phase 2: Hold (4s)
  // Phase 3: Breathe Out (4s)
  // 0: Completed
  final RxInt _phase = 1.obs;
  final RxInt _cycle = 0.obs;
  final int _totalCycles;

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

    // Main cycle controller duration changes by phase.
    _mainController = AnimationController(
      vsync: this,
      duration: Duration(seconds: _inhaleSeconds),
    );

    _mainController.addListener(() {
      final int phaseSeconds = _getPhaseDurationSeconds(_phase.value);
      final int val = (_mainController.value * phaseSeconds).toInt() + 1;
      if (val != _countdown.value && val <= phaseSeconds) {
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

    final int phaseSeconds = _getPhaseDurationSeconds(pha);
    _mainController.duration = Duration(seconds: phaseSeconds);
    _countdown.value = 1;

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
        _sendBreathingSession();
      }
    }
  }

  Future<void> _sendBreathingSession() async {
    final sessionsController = Get.isRegistered<BreathingSessionsController>()
        ? Get.find<BreathingSessionsController>()
        : Get.put(BreathingSessionsController());

    await sessionsController.breathingCompletedToSend(
      _exerciseId,
      _cycle.value,
      _resolveTotalSeconds(),
    );

    if (Get.isRegistered<BreathingController>()) {
      Get.find<BreathingController>().fetchBreathingData();
    }

    await Future.delayed(const Duration(seconds: 3));
    if (!isClosed) {
      Get.back(closeOverlays: true);
    }
  }

  int _resolveTotalSeconds() {
    if (_totalSession > 0) {
      return _totalSession;
    }

    return (_inhaleSeconds + _holdSeconds + _exhaleSeconds) * _totalCycles;
  }

  int _getPhaseDurationSeconds(int phase) {
    if (phase == 1) return _inhaleSeconds;
    if (phase == 2) return _holdSeconds;
    if (phase == 3) return _exhaleSeconds;
    return _inhaleSeconds;
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
