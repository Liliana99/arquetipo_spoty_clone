import 'package:arquetipo_flutter_bloc/app/home/pages/song_page/blocs/song_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ButtonState {
  playing,
  pause,
}

class SongCubit extends Cubit<SongState>{

  SongCubit()
      : super(
           const SongState (
            progress: Duration(seconds: 0),
            buffered: Duration.zero,
            total: Duration.zero,
            isIconActive:false,
            buttonState: ButtonState.pause
          ),
        );

   void startProgress() {
    emit( SongState(
      progress: const Duration(seconds: 59),
      buffered: const Duration(seconds: 59),
      total: const Duration(seconds: 59),
      isIconActive: state.isIconActive,
      buttonState: ButtonState.pause
    ),);
  }

  void pauseProgress() {
    emit(SongState(
      progress: state.progress,
      buffered: state.buffered,
      total: state.total ,
      isIconActive: state.isIconActive,
      buttonState: ButtonState.playing,
    ));
  }

  void backProgress() {
    emit( SongState(
      progress: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
      isIconActive: state.isIconActive,
       buttonState: ButtonState.pause,
    ));
  }

  void forwardProgress() {
    final currentState = state;
    const newProgress = Duration(seconds: 55);
      emit(SongState(
        progress:  currentState.progress==const Duration(seconds: 0)?const Duration(seconds: 59):newProgress,
        buffered: currentState.buffered==const Duration(seconds: 0)?const Duration(seconds: 59):currentState.buffered,
        total: currentState.total==const Duration(seconds: 0)?const Duration(seconds: 59):currentState.total,
        isIconActive: state.isIconActive,
         buttonState: ButtonState.pause,
      ),);
    
  } 

  void resetButtonsMusic(ButtonState buttonState){
    emit(  SongState (
            progress: const Duration(seconds: 0),
            buffered: Duration.zero,
            total: Duration.zero,
            isIconActive:false,
            buttonState: buttonState,
          ),);
  }

  //* IconHeart
  void toogleHeartIcon(SongState state) => emit(SongState(isIconActive: !state.isIconActive, progress: state.progress, buffered: state.buffered, total: state.total, buttonState: state.buttonState));
  void resetIcon() => emit( SongState(isIconActive: false,progress: state.progress, buffered: state.buffered, total: state.total, buttonState: state.buttonState));

  //* ButtonMusic
  void play(SongState songState) {
    startProgress();
  }

 

  void toogleButtonMusic(SongState songState) {
    if (songState.buttonState == ButtonState.pause) {
      pauseProgress();
    } else {
      startProgress();
    }
  }
}