import 'dart:async';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class WaveCapture {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  Stream<double>? _amplitudeStream;
  double amplitudes = 0.0;
  StreamSubscription<RecordingDisposition>? _subscription;

  // What my custom painter will draw later
  Stream<double>? get amplitudeStream => _amplitudeStream;

  // open up the recorder
  Future<void> init() async {
    final micStatus = await Permission.microphone.request();
    if (!micStatus.isGranted) {
      throw Exception('Microphone permission not granted');
    }
    await _recorder.openRecorder();
    await _recorder.setSubscriptionDuration(Duration(milliseconds: 50));
  }

  /// Start recording;
  /// We just need the amplitude. I need to find out how to handle the actual recording later;
  Future<void> startRecording({required String filePath}) async {
    await _recorder.startRecorder(toFile: filePath, codec: Codec.aacADTS);
    _amplitudeStream = _recorder.onProgress!.map((event) {
      final db =
          event.decibels ??
          0.0; //event decibels are can no longer be negative values;
      return ((db) / 120).clamp(0.0, 1.0);
    });
  }

  Future<void> cancelRecording() async {
    _subscription?.cancel();
    _subscription = null;
    await _recorder.stopRecorder();
    await _recorder.closeRecorder();
  }

  Future<void> pauseRecording() async {
    if (!_recorder.isPaused) {
      await _recorder.pauseRecorder();
    } 
  }

   Future<void> resumeRecording() async {
    if (!_recorder.isRecording) {
      await _recorder.resumeRecorder();
    } 
  }
}
