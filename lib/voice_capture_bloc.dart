import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/util/wave_capture.dart';

enum LiveAudioState { idle, listening, readyToSend }

class LiveAudioBlocState {
  final LiveAudioState state;
  final String? filePath;

  const LiveAudioBlocState({required this.state, this.filePath});

 
}

abstract class LiveAudioEvent {}

class StartRecording extends LiveAudioEvent {}
class PauseRecording extends LiveAudioEvent {}
class ResumeRecording extends LiveAudioEvent {}

class CancelRecording extends LiveAudioEvent {}

class LiveAudioBloc extends Bloc<LiveAudioEvent, LiveAudioBlocState> {
  final WaveCapture _waveCapture = WaveCapture();

  LiveAudioBloc() : super(const LiveAudioBlocState(state: LiveAudioState.idle)) {

    on<StartRecording>((event, emit) async {
      await _waveCapture.init();
      await _waveCapture.startRecording(filePath: 'temp.aac');
      emit(const LiveAudioBlocState(state: LiveAudioState.listening));
    });

    on<PauseRecording>((event, emit) async {
      await _waveCapture.pauseRecording();
      emit(LiveAudioBlocState(state: LiveAudioState.readyToSend));
    });
      on<ResumeRecording>((event, emit) async {
      await _waveCapture.resumeRecording();
      emit(LiveAudioBlocState(state: LiveAudioState.listening));
    });

    on<CancelRecording>((event, emit) async {
      await _waveCapture.cancelRecording(); 
      emit(const LiveAudioBlocState(state: LiveAudioState.idle));
    });
  }


  Stream<double>? get amplitudeStream => _waveCapture.amplitudeStream;
}
