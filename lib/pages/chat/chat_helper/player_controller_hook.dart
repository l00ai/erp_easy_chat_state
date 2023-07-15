import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:path_provider/path_provider.dart';

class _PlayerControllerHook extends Hook<PlayerController> {
  final String path;

  const _PlayerControllerHook({required this.path});

  @override
  __PlayerControllerHookState createState() => __PlayerControllerHookState();
}

class __PlayerControllerHookState
    extends HookState<PlayerController, _PlayerControllerHook> {
  late PlayerController playerController;

  init() async {
    playerController = PlayerController();
    // Prepare player with extracting waveform if index is even.
    playerController.preparePlayer(
      path: hook.path,
      shouldExtractWaveform: true,
    );
  }

  @override
  void initHook() {
    init();
    super.initHook();
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  @override
  PlayerController build(BuildContext context) {
    return playerController;
  }
}

PlayerController usePlayerController({required String path}) {
  return use(_PlayerControllerHook(path: path));
}
