import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class _RecorderControllerHook extends Hook<RecorderController> {
  const _RecorderControllerHook();

  @override
  __RecorderControllerHookState createState() => __RecorderControllerHookState();
}

class __RecorderControllerHookState
    extends HookState<RecorderController, _RecorderControllerHook> {

  late RecorderController record;

  @override
  void initHook() {
    // init Record controller
    record = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
    super.initHook();
  }

  @override
  void dispose() {
    record.dispose();
    super.dispose();
  }

  @override
  RecorderController build(BuildContext context) {
    return record;
  }
}

RecorderController useRecorderController() {
  return use(const _RecorderControllerHook());
}
