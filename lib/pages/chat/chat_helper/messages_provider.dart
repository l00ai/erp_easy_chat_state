import 'dart:collection';

import 'package:erp_easy_chat_state/pages/chat/model/message.dart';
import 'package:flutter/widgets.dart';

class MessagesProvider extends ChangeNotifier {

  final List<Message> _messages = [
    Message(
        text:
        "https://file-examples.com/storage/fee472ce6e64b122ba0c8b3/2017/11/file_example_WAV_1MG.wav",
        fromMe: true,
        messageType: MessageType.voice,
        dateTime: "May 11, 05:11 PM",
        isRead: true,
        fromId: 0),
    Message(
        text:
        "https://samplelib.com/lib/preview/mp3/sample-15s.mp3",
        fromMe: true,
        messageType: MessageType.voice,
        dateTime: "May 11, 05:11 PM",
        isRead: true,
        fromId: 0),
    Message(
        text: "I am good 💐",
        fromMe: true,
        messageType: MessageType.text,
        dateTime: "May 11, 05:11 PM",
        isRead: true,
        fromId: 0,
        messageStatus: MessageStatus.sending,
        replayMessage: Message(
            text: "Hi, How are you ?",
            fromMe: true,
            messageType: MessageType.text,
            dateTime: "May 11, 05:11 PM",
            isRead: true,
            fromId: 0)),
    Message(
        text: "https://th.bing.com/th/id/OIG.lVXjWwlHyIo4QdjnC1YE",
        fromMe: true,
        messageType: MessageType.image,
        dateTime: "May 11, 05:11 PM",
        isRead: true,
        fromId: 0),
    Message(
        text: "Hi, I am fine",
        fromMe: false,
        messageType: MessageType.text,
        dateTime: "May 11, 05:11 PM",
        isRead: true,
        fromId: 0),
    Message(
        text: "Hi, How are you ?",
        fromMe: true,
        messageType: MessageType.text,
        dateTime: "May 11, 05:11 PM",
        isRead: true,
        fromId: 0),
  ];

  UnmodifiableListView<Message> get messages => UnmodifiableListView(_messages);

  bool _voiceIsRecording = false;
  bool _isWriting = false;
  Message? _replayMessage;

  Message? get replayMessage => _replayMessage;

  bool get isWriting => _isWriting;

  bool get isRecording => _voiceIsRecording;

  void setReplayMessage(Message? message) {
    _replayMessage = message;
    notifyListeners();
  }

  void setIsWriting(bool value) {
    _isWriting = value;
    notifyListeners();
  }

  void setIsRecording(bool val) {
    _voiceIsRecording = val;
    notifyListeners();
  }

  void addMessage(Message message) {
    _messages.insert(0, message);
    notifyListeners();
  }
}
