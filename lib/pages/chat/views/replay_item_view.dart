import 'package:erp_easy_chat_state/config/light_theme_colors.dart';
import 'package:erp_easy_chat_state/pages/chat/model/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReplayItemView extends StatelessWidget {
  final Message message;
  final Function onClose;
  const ReplayItemView({Key? key, required this.message, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String text = message.text;
    if(message.messageType == MessageType.image){
      text = "Photo";
    }else if(message.messageType == MessageType.voice){
      text = "Voice";
    }else if(message.messageType == MessageType.file){
      text = "File";
    }else if(message.messageType == MessageType.video){
      text = "Video";
    }
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          )),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(message.fromMe)
                  Row(
                    children: [
                      6.horizontalSpace,
                      Container(
                        height: 12,
                        width: 4,
                        color: LightThemeColors.secondaryColor,
                      ),
                      4.horizontalSpace,
                      Text("From you", style: TextStyle(color: theme.primaryColor)),
                    ],
                  ),
                Text(text),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                onClose();
              },
              icon: const Icon(Icons.cancel_outlined, color: Colors.black54,))
        ],
      ),
    );
  }
}
