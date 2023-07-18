
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/light_theme_colors.dart';

class InputText extends StatelessWidget {
  final TextEditingController controller;
  final Function sendMessage;
  final bool thereReplay;
  final bool isWriting;
  final Function startRecord;
  final Function selectImage;
  final Function selectFile;
  const InputText({
    Key? key,
    required this.controller,
    required this.sendMessage,
    required this.thereReplay,
    required this.isWriting,
    required this.startRecord,
    required this.selectImage,
    required this.selectFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    getTextBoxBorderRadius() {
      return !thereReplay
          ? BorderRadius.circular(20.0)
          : const BorderRadius.vertical(bottom: Radius.circular(20));
    }

    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: getTextBoxBorderRadius(),
        border: Border.all(color: theme.colorScheme.secondary)
      ),
      child: Row(
        children: [
          // 10.horizontalSpace,
          // UnconstrainedBox(
          //     child: Image.asset("assets/images/smile.png",
          //         height: 18.h, width: 16.w)),
          Expanded(
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.send,
              onSubmitted: (value) => sendMessage(value),
              decoration: InputDecoration(
                  errorStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.redAccent),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  hintText: "Type your message",
                  hintStyle: theme.textTheme.titleLarge!.copyWith(
                      color: theme.hintColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.normal),
                  // filled: true,
                  // fillColor: Colors.white,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
              ),
            ),
          ),
          UnconstrainedBox(
            child: Row(
              children: [
                GestureDetector(
                  onTap: ()=> selectFile(),
                  child: Icon(
                    Icons.file_present_outlined,
                    size: 18.h,
                    color: Colors.grey,
                  ),
                ),
                10.horizontalSpace,
                GestureDetector(
                  onTap: ()=> selectImage(),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 18.h,
                    color: Colors.grey,
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: isWriting ? ElevatedButton(
                    onPressed: () => sendMessage(controller.text),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      padding: MaterialStateProperty.all(const EdgeInsets.all(2)),
                      backgroundColor: MaterialStateProperty.all(
                          LightThemeColors.accentColor), // <-- Button color
                      overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white.withOpacity(0.3); // <-- Splash color
                        }
                      }),
                    ),
                    child: Icon(Icons.send, size: 18.h,),
                  ) :
                  ElevatedButton(
                    onPressed: () => startRecord(),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      padding: MaterialStateProperty.all(const EdgeInsets.all(2)),
                      backgroundColor: MaterialStateProperty.all(
                          LightThemeColors.accentColor), // <-- Button color
                      overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white.withOpacity(0.3); // <-- Splash color
                        }
                      }),
                    ),
                    child: Icon(Icons.keyboard_voice_outlined, size: 18.h,),
                  )
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
