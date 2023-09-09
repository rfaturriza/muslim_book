import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/themes/color.dart';
import '../../bloc/audioVerse/audio_verse_bloc.dart';

class BottomNavPlayer extends StatelessWidget {
  const BottomNavPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final audioBloc = context.read<AudioVerseBloc>();
    final colorIcon = defaultColor.shade50;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: secondaryColor.shade800,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<AudioVerseBloc, AudioVerseState>(
              buildWhen: (previous, current) {
                return previous.position != current.position ||
                    previous.duration != current.duration;
              },
              builder: (context, state) {
                final position = state.position;
                final duration = state.duration;
                return TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    tween: Tween<double>(
                      begin: 0,
                      end: position.inMilliseconds / duration.inMilliseconds,
                    ),
                    builder: (context, value, _) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: LinearProgressIndicator(
                          value: value,
                          backgroundColor: colorIcon,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(secondaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    audioBloc.add(const AudioVerseEvent.previousAudioVerse());
                  },
                  icon: const Icon(Icons.fast_rewind_outlined),
                  color: colorIcon,
                ),
                IconButton(
                  onPressed: () {
                    audioBloc.add(const AudioVerseEvent.seekAudioVerse(
                      position: Duration(seconds: -10),
                    ));
                  },
                  icon: const Icon(Icons.replay_10),
                  color: colorIcon,
                ),
                IconButton(
                  onPressed: () {
                    audioBloc.add(const AudioVerseEvent.stopAudioVerse());
                  },
                  icon: const Icon(Icons.stop_circle_outlined),
                  color: colorIcon,
                ),
                IconButton(
                  onPressed: () {
                    audioBloc.add(const AudioVerseEvent.seekAudioVerse(
                      position: Duration(seconds: 10),
                    ));
                  },
                  icon: const Icon(Icons.forward_10),
                  color: colorIcon,
                ),
                IconButton(
                  onPressed: () {
                    audioBloc.add(const AudioVerseEvent.nextAudioVerse());
                  },
                  icon: const Icon(Icons.fast_forward_outlined),
                  color: colorIcon,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
