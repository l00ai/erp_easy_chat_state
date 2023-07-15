import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:erp_easy_chat_state/config/light_theme_colors.dart';
import 'package:erp_easy_chat_state/pages/chat/chat_helper/player_controller_hook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class VoiceMessageItem extends HookWidget {
  final String path;
  final bool fromMe;
  final bool isReplay;
  const VoiceMessageItem({Key? key, required this.path, required this.fromMe, required this.isReplay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final playerController = usePlayerController(path: path);

    IconData icon = Icons.play_arrow_outlined;

    statusChange(PlayerController playerController, setState) async {
      if(playerController.playerState == PlayerState.initialized){
        playerController.startPlayer(forceRefresh: true, finishMode: FinishMode.pause);
        setState((){
          icon = Icons.pause;
        });
      }

      if(playerController.playerState == PlayerState.playing){
        playerController.pausePlayer();
        setState((){
          icon = Icons.play_arrow_outlined;
        });
      }

      if(playerController.playerState == PlayerState.paused){
        playerController.startPlayer(forceRefresh: true, finishMode: FinishMode.pause);
        setState((){
          icon = Icons.pause;
        });
      }

      if(playerController.playerState == PlayerState.stopped){
        //playerController.stopAllPlayers();
        playerController.startPlayer(forceRefresh: true, finishMode: FinishMode.pause);
        setState((){
          icon = Icons.pause;
        });
      }

      final playerStateSubscription = playerController.onPlayerStateChanged.listen((event)async {
        if(event == PlayerState.paused){
          setState((){
            icon = Icons.play_arrow_outlined;
          });
          //playerStateSubscription.cancel();
        }
      });
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatefulBuilder(
          builder: (context, setState) {
            return ElevatedButton(
              onPressed: () {
                statusChange(playerController, setState);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const CircleBorder()),
                padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
                backgroundColor: MaterialStateProperty.all(LightThemeColors.accentColor), // <-- Button color
                overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed)) return Colors.white.withOpacity(0.3); // <-- Splash color
                }),
              ),
              child: Icon(icon),
            );
          }
        ),
        AudioFileWaveforms(
            size: Size(
              isReplay ? (size.width * 0.3) :(size.width * 0.5),
                40.0,
            ),
            playerController: playerController,
            enableSeekGesture: true,
            waveformType: isReplay ? WaveformType.fitWidth : WaveformType.long,
            //waveformData: [],
            playerWaveStyle:  const PlayerWaveStyle(
                fixedWaveColor: Colors.white54,
                liveWaveColor: Colors.white,
                spacing: 5,
              showTop: true,
              scaleFactor: 100,
              scrollScale: 1.2,
              showBottom: true,
              seekLineColor: Colors.white,

            ),
        ),
      ],
    );
  }
}
