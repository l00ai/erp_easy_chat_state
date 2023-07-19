import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:erp_easy_chat_state/config/light_theme_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class VoiceMessageItem extends StatefulWidget {
  final String path;
  final bool fromMe;
  final bool isReplay;
  const VoiceMessageItem({Key? key, required this.path, required this.fromMe, required this.isReplay}) : super(key: key);

  @override
  State<VoiceMessageItem> createState() => _VoiceMessageItemState();
}

class _VoiceMessageItemState extends State<VoiceMessageItem> {

  late PlayerController playerController;

  IconData icon = Icons.play_arrow_outlined;

  statusChange(PlayerController playerController) async {
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

  String? path;
  bool loading = false;

  init() async {
    Logger().w(widget.path);
    playerController = PlayerController();

    if(widget.path.contains("http")){
      setState(() {
        loading = true;
      });
      path = await downloadAudioFromUrl(widget.path);
      setState(() {
        icon = Icons.play_arrow_outlined;
        loading = false;
      });
    }else{
      path = null;
    }

    playerController.preparePlayer(
      path: path ?? widget.path,
      shouldExtractWaveform: true,
    );
  }

  Future<String?> downloadAudioFromUrl(String url) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final path = dir.path;
      final file = File('$path/file.wav');
      final response = await http.get(Uri.parse(url));
      await file.writeAsBytes(response.bodyBytes);
      return file.path;
    }catch(e){
      return null;
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () {
            statusChange(playerController);
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all(const CircleBorder()),
            padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
            backgroundColor: MaterialStateProperty.all(LightThemeColors.accentColor), // <-- Button color
            overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
              if (states.contains(MaterialState.pressed)) return Colors.white.withOpacity(0.3); // <-- Splash color
            }),
          ),
          child: loading ? const CupertinoActivityIndicator(color: Colors.white,) : Icon(icon),
        ),
        AudioFileWaveforms(
            size: Size(
              widget.isReplay ? (size.width * 0.3) :(size.width * 0.5),
                40.0,
            ),
            playerController: playerController,
            enableSeekGesture: true,
            waveformType: widget.isReplay ? WaveformType.fitWidth : WaveformType.long,
            waveformData: playerController.waveformData,
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
