import 'package:arquetipo_flutter_bloc/app/home/pages/song_page/blocs/song_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/song_page/blocs/song_state.dart';
import 'package:arquetipo_flutter_bloc/app/home/repositories/tasks_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  group('SongCubit', () {
    late SongCubit songCubit;

    setUp(() {
      songCubit = SongCubit();
    });

   tearDown(() {
      songCubit.close();
    });

    test('initial state is correct', () {
      expect(
        songCubit.state,
        const SongState(
          progress: Duration(seconds: 0),
          buffered: Duration.zero,
          total: Duration.zero,
          isIconActive: false,
          buttonState: ButtonState.pause,
        ),
      );
    });
   
   blocTest<SongCubit, SongState>(
      'emits correct state when startProgress is called',
      build: () => songCubit,
      act: (cubit) => cubit.startProgress(),
      expect: () => [
        const SongState(
          progress: Duration(seconds: 59),
          buffered: Duration(seconds: 59),
          total: Duration(seconds: 59),
          isIconActive: false,
          buttonState: ButtonState.pause,
        ),
      ],
    );
    blocTest<SongCubit, SongState>(
      'emits correct state when pauseProgress  is called',
      build: () => songCubit,
      seed: () => const SongState(
        progress: Duration(seconds: 59),
        buffered: Duration(seconds: 59),
        total: Duration(seconds: 59),
        isIconActive: false,
        buttonState: ButtonState.pause,
      ),
      act: (cubit) => cubit.pauseProgress(),
      expect: () => [
        const SongState(
          progress: Duration(seconds: 59),
          buffered: Duration(seconds: 59),
          total: Duration(seconds: 59),
          isIconActive: false,
          buttonState: ButtonState.playing,
        ),
      ],
    );

    blocTest<SongCubit, SongState>(
      'emits correct state when backProgress  is called',
      build: () => songCubit,
      seed: () => const SongState(
        progress: Duration.zero,
        buffered: Duration.zero,
        total: Duration.zero,
        isIconActive: false,
        buttonState: ButtonState.pause,
      ),
      act: (cubit) => cubit.pauseProgress(),
      expect: () => [
        const SongState(
          progress: Duration.zero,
          buffered: Duration.zero,
          total: Duration.zero,
          isIconActive: false,
          buttonState: ButtonState.playing,
        ),
      ],
    );

    blocTest<SongCubit, SongState>(
      'emits correct state when forwardProgress  is called',
      build: () => songCubit,
      seed: () => const SongState(
        progress: Duration.zero,
        buffered: Duration.zero,
        total: Duration.zero,
        isIconActive: false,
        buttonState: ButtonState.pause,
      ),
      act: (cubit) => cubit.pauseProgress(),
      expect: () => [
        const SongState(
          progress: Duration.zero,
          buffered: Duration.zero,
          total: Duration.zero,
          isIconActive: false,
          buttonState: ButtonState.playing,
        ),
      ],
    );

    // Cuando progress, buffered y total son 0
    blocTest<SongCubit, SongState>(
      'forwardProgress updates values when progress, buffered, and total are 0',
      build: () => songCubit,
      seed: () => const SongState(
        progress: Duration.zero,
        buffered: Duration.zero,
        total: Duration.zero,
        isIconActive: false,
        buttonState: ButtonState.playing,
      ),
      act: (cubit) => cubit.forwardProgress(),
      expect: () => [
        const SongState(
          progress: Duration(seconds: 59),
          buffered: Duration(seconds: 59),
          total: Duration(seconds: 59),
          isIconActive: false,
          buttonState: ButtonState.pause,
        ),
      ],
    );

    // Cuando progress, buffered y total no son 0
    blocTest<SongCubit, SongState>(
      'forwardProgress updates only progress when progress, buffered, and total are not 0',
      build: () => songCubit,
      seed: () => const SongState(
        progress: Duration(seconds: 10),
        buffered: Duration(seconds: 20),
        total: Duration(seconds: 30),
        isIconActive: false,
        buttonState: ButtonState.playing,
      ),
      act: (cubit) => cubit.forwardProgress(),
      expect: () => [
        const SongState(
          progress: Duration(seconds: 55),  
          buffered: Duration(seconds: 20),  
          total: Duration(seconds: 30),     
          isIconActive: false,
          buttonState: ButtonState.pause,
        ),
      ],
    );

    test('emits correct state when resetButtonMusic is called ', () {
      expect(
        songCubit.state,
        const SongState(
          progress: Duration(seconds: 0),
          buffered: Duration.zero,
          total: Duration.zero,
          isIconActive: false,
          buttonState: ButtonState.pause,
        ),
      );
    });

    blocTest<SongCubit, SongState>(
      'toogleHeartIcon sets isIconActive to false when it was originally true',
      build: () => songCubit,
      seed: () => const SongState(
        progress: Duration(seconds: 10),
        buffered: Duration(seconds: 20),
        total: Duration(seconds: 30),
        isIconActive: true,
        buttonState: ButtonState.pause,
      ),
      act: (cubit) => cubit.toogleHeartIcon(cubit.state),
      expect: () => [
        const SongState(
          progress: Duration(seconds: 10),
          buffered: Duration(seconds: 20),
          total: Duration(seconds: 30),
          isIconActive: false,  
          buttonState: ButtonState.pause,
        ),
      ],
    );

    blocTest<SongCubit, SongState>(
      'toogleHeartIcon sets isIconActive to true when it was originally false',
      build: () => songCubit,
      seed: () => const SongState(
        progress: Duration(seconds: 10),
        buffered: Duration(seconds: 20),
        total: Duration(seconds: 30),
        isIconActive: false,
        buttonState: ButtonState.pause,
      ),
      act: (cubit) => cubit.toogleHeartIcon(cubit.state),
      expect: () => [
        const SongState(
          progress: Duration(seconds: 10),
          buffered: Duration(seconds: 20),
          total: Duration(seconds: 30),
          isIconActive: true, 
          buttonState: ButtonState.pause,
        ),
      ],
    );

    blocTest<SongCubit, SongState>(
      'resetIcon always sets isIconActive to false',
      build: () => songCubit,
      seed: () => const SongState(
        progress: Duration(seconds: 10),
        buffered: Duration(seconds: 20),
        total: Duration(seconds: 30),
        isIconActive: true,
        buttonState: ButtonState.pause,
      ),
      act: (cubit) => cubit.resetIcon(),
      expect: () => [
        const SongState(
          progress: Duration(seconds: 10),
          buffered: Duration(seconds: 20),
          total: Duration(seconds: 30),
          isIconActive: false,  // Restablecido a false
          buttonState: ButtonState.pause,
        ),
      ],
    );
  
  blocTest<SongCubit, SongState>(
      'toogleButtonMusic should call pauseProgress when buttonState is ButtonState.pause',
      build: () => songCubit,
      seed: () => const SongState(
        progress: Duration(seconds: 10),
        buffered: Duration(seconds: 20),
        total: Duration(seconds: 30),
        isIconActive: true,
        buttonState: ButtonState.pause,
      ),
      act: (cubit) => cubit.toogleButtonMusic(cubit.state),
      expect: () => [
        const SongState(
          progress: Duration(seconds: 10),
          buffered: Duration(seconds: 20),
          total: Duration(seconds: 30),
          isIconActive: true,
          buttonState: ButtonState.playing,
        ),
      ],
    );

     blocTest<SongCubit, SongState>(
      'toogleButtonMusic should call startProgress when buttonState is not ButtonState.pause',
      build: () => songCubit,
      seed: () => const SongState(
        progress: Duration(seconds: 10),
        buffered: Duration(seconds: 20),
        total: Duration(seconds: 30),
        isIconActive: false,
        buttonState: ButtonState.playing,
      ),
      act: (cubit) => cubit.toogleButtonMusic(cubit.state),
      expect: () => [
        const SongState(
          progress: Duration(seconds: 59),
          buffered: Duration(seconds: 59),
          total: Duration(seconds: 59),
          isIconActive: false,
          buttonState: ButtonState.pause,
        ),
      ],
    );
   
  });
}
