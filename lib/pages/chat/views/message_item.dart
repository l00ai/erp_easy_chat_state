import 'package:erp_easy_chat_state/config/light_theme_colors.dart';
import 'package:erp_easy_chat_state/pages/chat/views/image_message_item.dart';
import 'package:erp_easy_chat_state/pages/chat/views/voice_message_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import '../model/message.dart';
import 'file_message_item.dart';

class MessageItem extends StatelessWidget {
  final Message message;
  final bool isReplay;
  const MessageItem({Key? key, required this.message, this.isReplay = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: isReplay ? 5 : 10),
      child: Column(
        crossAxisAlignment:
            message.fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: message.messageType == MessageType.voice
                ? EdgeInsets.zero
                : EdgeInsets.symmetric(
                    horizontal:
                        message.messageType == MessageType.image ? 5 : 20,
                    vertical:
                        message.messageType == MessageType.image ? 5 : 10),
            constraints: BoxConstraints(
                maxWidth: size.size.width *
                    (message.messageType == MessageType.voice ? 0.9 : 0.7)),
            decoration: BoxDecoration(
                borderRadius: isReplay
                    ? BorderRadius.circular(10)
                    : BorderRadius.only(
                        bottomRight: Radius.circular(message.fromMe ? 0 : 20),
                        bottomLeft: Radius.circular(message.fromMe ? 20 : 0),
                        topRight: const Radius.circular(20),
                        topLeft: const Radius.circular(20),
                      ),
                color: isReplay
                    ? Colors.white.withOpacity(0.5)
                    : (message.fromMe
                        ? theme.primaryColor
                        : LightThemeColors.messageItemColor)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (message.replayMessage != null)
                  MessageItem(message: message.replayMessage!, isReplay: true),
                if (message.messageType == MessageType.text)
                  Text(
                    message.text,
                    style: TextStyle(
                        color: message.fromMe
                            ? Colors.white
                            : theme.textTheme.bodyLarge!.color),
                  ),
                if (message.messageType == MessageType.image)
                  ImageMessageItem(message: message),
                if (message.messageType == MessageType.voice)
                  IgnorePointer(
                    ignoring: isReplay,
                    child: VoiceMessageItem(
                      path: message.text,
                      fromMe: message.fromMe,
                      isReplay: isReplay,
                      key: Key(message.text),
                    ),
                  ),
                if (message.messageType == MessageType.file)
                  FileMessageItem(message: message,)
              ],
            ),
          ),
          if (!isReplay) ...[
            6.verticalSpace,
            Row(
              mainAxisAlignment: message.fromMe
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Text(
                  message.dateTime,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                if (message.fromMe) ...[
                  const SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    message.messageStatus == MessageStatus.sending ? "assets/vectors/send_sending.svg" : "assets/vectors/seen.svg",
                    color: message.messageStatus == MessageStatus.seen ?
                        LightThemeColors.iconSecondaryColor : LightThemeColors.dividerColor,
                    width: 16,
                  ),
                ]
              ],
            )
          ]
        ],
      ),
    );
  }
}
