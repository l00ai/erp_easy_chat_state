import 'dart:collection';

import 'package:erp_easy_chat_state/pages/chat/model/message.dart';
import 'package:flutter/widgets.dart';

class MessagesProvider extends ChangeNotifier {

  final List<Message> _messages = [
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

  setReplayMessage(Message? message){
    _replayMessage = message;
    notifyListeners();
  }

  setIsWriting(bool value){
    _isWriting = value;
    notifyListeners();
  }

  bool get isRecording => _voiceIsRecording;

  void setIsRecording(bool val){
    _voiceIsRecording = val;
    notifyListeners();
  }

  addMessage(Message message){
    _messages.insert(0, message);
    notifyListeners();
  }



}