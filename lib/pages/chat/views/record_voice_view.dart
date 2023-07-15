import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:erp_easy_chat_state/config/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecordVoiceView extends StatelessWidget {
  final RecorderController recorderController;
  final Function stopRecord;
  final Function deletePressed;

  const RecordVoiceView({
    Key? key,
    required this.recorderController,
    required this.stopRecord,
    required this.deletePressed,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AudioWaveforms(
            enableGesture: false,
            size: Size(150.w, 50),
            recorderController: recorderController,
            waveStyle: const WaveStyle(
              waveColor: Colors.white,
              extendWaveform: true,
              showMiddleLine: false,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.grey,
            ),
            padding: const EdgeInsets.only(left: 18),
            margin: const EdgeInsets.symmetric(horizontal: 15),
          ),
          ElevatedButton(
            onPressed: () => deletePressed(),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder()),
              padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
              backgroundColor: MaterialStateProperty.all(Colors.redAccent),
              // <-- Button color
              overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                if (states.contains(MaterialState.pressed))
                  return Colors.white.withOpacity(0.3); // <-- Splash color
              }),
            ),
            child: Icon(Icons.delete_outline),
          ),
          ElevatedButton(
            onPressed: () => stopRecord(),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder()),
              padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
              backgroundColor: MaterialStateProperty.all(
                  LightThemeColors.accentColor), // <-- Button color
              overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                if (states.contains(MaterialState.pressed))
                  return Colors.white.withOpacity(0.3); // <-- Splash color
              }),
            ),
            child: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
