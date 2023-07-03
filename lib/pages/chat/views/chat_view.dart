import 'dart:convert';
import 'dart:io';

import 'package:erp_easy_chat_state/pages/call/views/call_view.dart';
import 'package:erp_easy_chat_state/pages/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:uuid/uuid.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {


  List<types.Message> mMessages = [];
  final user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );


  void addMessage(types.Message message) {
    mMessages.insert(0, message);
    setState(() {});
  }

  void handleAttachmentPressed(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      addMessage(message);
    }
  }

  void handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      addMessage(message);
    }
  }

  void handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
          mMessages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
          (mMessages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );


          mMessages[index] = updatedMessage;
          setState(() {});


          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
          mMessages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
          (mMessages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );


          mMessages[index] = updatedMessage;
          setState(() {});

        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
      ) {
    final index = mMessages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (mMessages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );


    mMessages[index] = updatedMessage;
    setState(() {});
  }

  void handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    addMessage(textMessage);
  }

  void loadMessages() async {
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();


    mMessages = messages;
    setState(() {});
  }

  @override
  void initState() {
    loadMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProfileView(),
                  ));
            },
            child: const Text("Michael Beher")),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CallView(),
                  ));
            },
            icon: const Icon(Icons.videocam_rounded),
          ),
          IconButton(
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CallView(),
                  ));
            },
            icon: const Icon(Icons.call),
          ),
        ],
      ),
      body:  Chat(
            messages: mMessages,
            onAttachmentPressed: ()=> handleAttachmentPressed(context),
            onMessageTap: handleMessageTap,
            onPreviewDataFetched: handlePreviewDataFetched,
            onSendPressed: handleSendPressed,
            showUserAvatars: true,
            showUserNames: true,
            user: user,
            theme: DefaultChatTheme(
                primaryColor: theme.primaryColor,
                backgroundColor: Colors.white,
                inputBackgroundColor: Colors.white,
                inputContainerDecoration: BoxDecoration(
                  border: Border.all(
                    color: theme.primaryColor
                  ),
                  borderRadius: BorderRadius.circular(35),
                ),
                inputMargin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                inputTextColor: Colors.black,
            ),
          ),
    );
  }
}
