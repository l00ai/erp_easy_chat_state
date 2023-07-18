import 'dart:math';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:erp_easy_chat_state/pages/chat/chat_helper/messages_provider.dart';
import 'package:erp_easy_chat_state/pages/chat/views/message_item.dart';
import 'package:erp_easy_chat_state/pages/chat/views/record_voice_view.dart';
import 'package:erp_easy_chat_state/pages/chat/views/replay_item_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_tile/swipeable_tile.dart';
import 'package:tuple/tuple.dart';
import '../chat_helper/recorder_controller_hook.dart';
import '../model/message.dart';
import 'input_text.dart';

class ChatViewMain extends HookWidget {
  const ChatViewMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mProvider = Provider.of<MessagesProvider>(context);
    TextEditingController textEditingController = useTextEditingController();
    RecorderController record = useRecorderController();
    final theme = Theme.of(context);
    final size = MediaQuery.of(context);

    textEditingController.addListener(() {
      if(textEditingController.text.trim().isEmpty){
        mProvider.setIsWriting(false);
      }else{
        mProvider.setIsWriting(true);
      }
    });

    sendMessage(String text, {MessageType messageType = MessageType.text}) {
      if (text.isEmpty) {
        return;
      }

      final Message? tempMessage = mProvider.replayMessage != null
          ? Message.fromJson(mProvider.replayMessage!.toJson())
          : null;
      if (tempMessage != null) {
        tempMessage.replayMessage = null;
      }

      final message = Message(
          text: text,
          fromMe: true,
          messageType: messageType,
          dateTime: "May 11, 05:11 PM",
          isRead: false,
          fromId: 0,
          messageStatus: MessageStatus.sending,
          replayMessage: tempMessage);

      mProvider.addMessage(message);
      mProvider.setReplayMessage(null);

      textEditingController.clear();
    }

    // pick Image and push to chat
    selectImage() async {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
      if (photo == null) {
        return;
      }
      // add message to ui
      sendMessage(photo.path, messageType: MessageType.image);
    }

    // pick Files and push to chat
    selectFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null) {
        return;
      }
      // add message to ui
      sendMessage(result.files.single.path!, messageType: MessageType.file);
    }

    // stop recording voice message and push to ui
    Future<String?> stopRecordVoiceMessage() async {
      if (mProvider.isRecording) {
        record.reset();
      }
      // Stop recording
      final result = await record.stop(false);
      // check path is valid and recording already start
      if (result != null && mProvider.isRecording) {
        // push message to ui list
        sendMessage(
          result,
          messageType: MessageType.voice,
        );
      }
      mProvider.setIsRecording(false);
      return result;
    }

    // when message swipe to replay
    onSwipe(Message message) {
      mProvider.setReplayMessage(message);
    }

    // dismiss recorded voice
    deleteVoiceRecordPressed() {
      record.stop();
      mProvider.setIsRecording(false);
    }

    // voice message start recoding
    startRecordVoiceMessage() async {
      mProvider.setIsRecording(true);

      final appDirectory = await getApplicationDocumentsDirectory();
      String path =
          "${appDirectory.path}/audio_${Random().nextInt(999999)}}.m4a";

      // Check and request permission
      if (await record.checkPermission()) {
        // Start recording
        await record.record(path: path);
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              foregroundDecoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  opacity: 0.2,
                  image: AssetImage("assets/images/bg_pattern.png"),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 90.h,
                    decoration: BoxDecoration(
                        color: theme.primaryColor,
                        border: Border.all(color: theme.primaryColor, width: 0),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(40.r))),
                  ),
                  Expanded(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          child: Container(
                            width: size.size.width * 0.5,
                            decoration: BoxDecoration(
                                color: theme.primaryColor,
                                border: Border.all(
                                    color: theme.primaryColor, width: 0)),
                          ),
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40.r))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 91.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppBar(
                        backgroundColor: Colors.transparent,
                        title: const Text("New Chat"),
                        actions: [
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.search))
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Consumer<MessagesProvider>(
                      builder: (context, value, widget) {
                    return ListView.builder(
                      padding:
                          const EdgeInsets.only(top: 25, right: 20, left: 20),
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      itemCount: value.messages.length,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemBuilder: (context, index) => ListItem(
                          message: value.messages[index], onSwipe: onSwipe, index: index),
                    );
                  }),
                ),
                Selector<MessagesProvider, Message?>(
                    selector: (context, provider) => provider.replayMessage,
                    builder: (context, replayMessage, widget) {
                      if (replayMessage == null) {
                        return const SizedBox();
                      }
                      return ReplayItemView(
                          message: replayMessage,
                          onClose: () {
                            mProvider.setReplayMessage(null);
                          });
                    }),
                Selector<MessagesProvider, bool>(
                    selector: (context, provider) => provider.isRecording,
                    builder: (context, isRecording, widget) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: isRecording
                            ? RecordVoiceView(
                                recorderController: record,
                                stopRecord: stopRecordVoiceMessage,
                                deletePressed: deleteVoiceRecordPressed,
                              )
                            : const SizedBox(),
                      );
                    }),
                Selector<MessagesProvider, Tuple2<Message?, bool>>(
                    selector: (_, p0) => Tuple2(p0.replayMessage, p0.isWriting),
                    builder: (context, data, widget) {
                      return InputText(
                        controller: textEditingController,
                        sendMessage: sendMessage,
                        thereReplay: data.item1 != null,
                        isWriting: data.item2,
                        startRecord: startRecordVoiceMessage,
                        selectImage: selectImage,
                        selectFile: selectFile,
                      );
                    }),
              ],
            ),
          ],
        ));
  }
}

class ListItem extends StatelessWidget {
  final Function onSwipe;
  final Message message;
  final int index;

  const ListItem(
      {Key? key,
      required this.message,
      required this.onSwipe,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeableTile(
        color: Colors.transparent,
        swipeThreshold: 0.4,
        isElevated: false,
        direction: SwipeDirection.startToEnd,
        onSwiped: (direction) {},
        confirmSwipe: (direction) async {
          onSwipe(message);
          return false;
        },
        backgroundBuilder: (context, direction, progress) {
          return const SizedBox();
        },
        key: Key("key_$index"),
        child: MessageItem(
          message: message,
        ));
  }
}
