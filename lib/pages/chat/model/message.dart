enum MessageType { text, voice, image, video, file}
enum MessageStatus {sending, send, seen}


class Message {
  late String text;
  late bool isRead;
  late String dateTime;
  late int fromId;
  late bool fromMe;
  late MessageType messageType;
  late MessageStatus messageStatus;
  late Message? replayMessage;

  Message({
    required this.text,
    this.isRead = true,
    this.fromMe = true,
    required this.dateTime,
    required this.fromId,
    this.replayMessage,
    this.messageType = MessageType.text,
    this.messageStatus = MessageStatus.seen
  });

  Message.fromJson(Map<String, dynamic> json){
    text = json['text'];
    isRead = json['isRead'];
    dateTime = json['dateTime'];
    fromId = json['fromId'];
    fromMe = json['fromMe'];
    messageType = json['messageType'];
    replayMessage = json['replayMessage'] == null ? null : Message.fromJson(json['replayMessage']);
  }

  Map<String, dynamic> toJson(){
    return {
      "text": text,
      "isRead": isRead,
      "dateTime": dateTime,
      "fromId": fromId,
      "fromMe": fromMe,
      "messageType": messageType,
      "replayMessage": replayMessage != null ? replayMessage!.toJson() : null,
    };
  }


}