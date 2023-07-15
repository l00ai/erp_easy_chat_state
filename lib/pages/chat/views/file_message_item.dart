import 'dart:io';
import 'package:erp_easy_chat_state/pages/chat/model/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FileMessageItem extends StatelessWidget {
  final Message message;
  const FileMessageItem({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final file = File(message.text);
    return Row(
      children: [
        const Icon(Icons.file_present_rounded, color: Colors.white,),
        10.horizontalSpace,
        Text(file.path.split("/").last, style: const TextStyle(color: Colors.white),)
      ],
    );
  }
}
