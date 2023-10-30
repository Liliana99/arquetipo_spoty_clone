
import 'package:arquetipo_flutter_bloc/app/home/pages/song_page/blocs/song_cubit.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'song_state.g.dart';

@CopyWith()
class SongState extends Equatable {
final Duration progress;
final Duration buffered;
final Duration total;
final bool isIconActive;
final ButtonState buttonState;

  const SongState({ required this.progress, required this.buffered,  required this.total, required this.isIconActive, required this.buttonState});

  @override
  List<Object?> get props => [progress,buffered,total,isIconActive,buttonState];


  
}
