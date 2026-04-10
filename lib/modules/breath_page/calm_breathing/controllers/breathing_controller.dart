import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenzi/modules/breath_page/controller/breathing_controller.dart';
import 'package:zenzi/modules/breath_page/controller/breathing_sessions_controller.dart';

enum BreathPhase { inPhase, hold, outPhase, reset }

class CalmBreathingController extends GetxController
    with GetTickerProviderStateMixin {
  CalmBreathingController({
    required int exerciseId,
    required int inhaleSeconds,
    required int holdSeconds,
    required int exhaleSeconds,
    required int totalCycles,
    required int totalSession,
  }) : _exerciseId = exerciseId,
       _inhaleSeconds = inhaleSeconds > 0 ? inhaleSeconds : 5,
       _holdSeconds = holdSeconds > 0 ? holdSeconds : 5,
       _exhaleSeconds = exhaleSeconds >= 0 ? exhaleSeconds : 0,
       _totalCycles = totalCycles > 0 ? totalCycles : 4,
       _totalSession = totalSession;

  late AnimationController _mainController;

  final int _exerciseId;
  final int _inhaleSeconds;
  final int _holdSeconds;
  final int _exhaleSeconds;
  final int _totalSession;

  final Rx<BreathPhase> _phase = BreathPhase.inPhase.obs;
  final RxInt _cycle = 0.obs;
  final int _totalCycles;

  BreathPhase get phase => _phase.value;
  int get cycle => _cycle.value;
  int get totalCycles => _totalCycles;
  AnimationController get mainController => _mainController;

  final RxInt _countdown = 1.obs;
  int get countdown => _countdown.value;

  @override
  void onInit() {
    super.onInit();

    _mainController = AnimationController(vsync: this);
    _mainController.addListener(() {
      if (_phase.value == BreathPhase.inPhase ||
          _phase.value == BreathPhase.outPhase) {
        final int phaseSeconds = _phase.value == BreathPhase.inPhase
            ? _inhaleSeconds
            : (_exhaleSeconds > 0 ? _exhaleSeconds : _inhaleSeconds);
        final int val = (_mainController.value * phaseSeconds).toInt() + 1;
        if (val != _countdown.value && val <= phaseSeconds) {
          _countdown.value = val;
        }
      }
    });

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
    _mainController.duration = Duration(seconds: _inhaleSeconds);
    _countdown.value = 1;

    _mainController.forward().then((_) => _startHold());
  }

  void _startHold() {
    _phase.value = BreathPhase.hold;
    _mainController.value = 1.0;

    int holdCounter = 1;
    _countdown.value = 1;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      holdCounter++;
      if (holdCounter <= _holdSeconds) {
        _countdown.value = holdCounter;
      } else {
        timer.cancel();
        _startExhale();
      }
    });
  }

  void _startExhale() {
    if (_exhaleSeconds <= 0) {
      _finishCycle();
      return;
    }

    _phase.value = BreathPhase.outPhase;
    _mainController.reset();
    _mainController.duration = Duration(seconds: _exhaleSeconds);
    _countdown.value = 1;

    _mainController.forward().then((_) => _finishCycle());
  }

  void _finishCycle() {
    _cycle.value++;

    if (_cycle.value < _totalCycles) {
      _mainController.reset();
      _startInhale();
    } else {
      _mainController.reset();
      _phase.value = BreathPhase.reset;
      _sendBreathingSession();
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

    final int exhaleSeconds = _exhaleSeconds > 0 ? _exhaleSeconds : 0;
    return (_inhaleSeconds + _holdSeconds + exhaleSeconds) * _totalCycles;
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
