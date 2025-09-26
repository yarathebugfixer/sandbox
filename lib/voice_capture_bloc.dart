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

class StopRecording extends LiveAudioEvent {}

class SendRecording extends LiveAudioEvent {}

class CancelRecording extends LiveAudioEvent {}

class LiveAudioBloc extends Bloc<LiveAudioEvent, LiveAudioBlocState> {
  final WaveCapture _waveCapture = WaveCapture();

  LiveAudioBloc()
    : super(const LiveAudioBlocState(state: LiveAudioState.idle)) {
    on<StartRecording>((event, emit) async {
      await _waveCapture.init();
      await _waveCapture.startRecording(filePath: 'temp.aac');
      emit(const LiveAudioBlocState(state: LiveAudioState.listening));
    });

   on<StopRecording>((event, emit) async {
      await _waveCapture.stopRecording();
      emit(const LiveAudioBlocState(state: LiveAudioState.readyToSend));
      //send the audio somewhere and then
      // emit(const LiveAudioBlocState(state: LiveAudioState.idle));
    });

    on<SendRecording>((event, emit) async {
      //send the audio somewhere and then
      emit(const LiveAudioBlocState(state: LiveAudioState.idle));
    });

    on<CancelRecording>((event, emit) async {
      await _waveCapture.cancelRecording();
      emit(const LiveAudioBlocState(state: LiveAudioState.idle));
    });
  }

  Stream<double>? get amplitudeStream => _waveCapture.amplitudeStream;
}
