import 'dart:io';
import 'package:erp_easy_chat_state/pages/chat/model/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;


class FileMessageItem extends StatefulWidget {
  final Message message;
  const FileMessageItem({Key? key, required this.message}) : super(key: key);

  @override
  State<FileMessageItem> createState() => _FileMessageItemState();
}

class _FileMessageItemState extends State<FileMessageItem> {

  bool loading = false;

  Future<String?> downloadAudioFromUrl(String url) async {
    try {
      setState(() {
        loading = true;
      });
      final dir = await getApplicationDocumentsDirectory();
      final path = "${dir.path}/files/";

      final voiceDirectory = await Directory(path).create(recursive: true);
      final list = voiceDirectory.listSync();
      final _url = convertUrlToFlatString(url);

      for (var element in list) {
        if(element.path.contains(_url)){
          return element.path;
        }
      }

      final file = File('$path${convertUrlToFlatString(url)}');
      final response = await http.get(Uri.parse(url));
      await file.writeAsBytes(response.bodyBytes);

      setState(() {
        loading = false;
        if(response.bodyBytes.isNotEmpty){
          _isDownloaded = true;
        }
      });

      return file.path;
    }catch(e, s){
      Logger().e(e);
      Logger().e(s);
      return null;
    }
  }



  convertUrlToFlatString(String url){
    return url.replaceAll("/", "\$\$@@_").replaceAll(':', "\$\$\$@@@");
  }

  isDownloaded(String url) async {

    final dir = await getApplicationDocumentsDirectory();
    final path = "${dir.path}/files/";

    final voiceDirectory = await Directory(path).create(recursive: true);
    final list = voiceDirectory.listSync();
    final _url = convertUrlToFlatString(url);

    for (var element in list) {
      if(element.path.contains(_url)){
        _path = element.path;
        return true;
      }
    }
    return false;
  }


  fromLocal(){
    return !widget.message.text.contains("http");
  }


  bool _isDownloaded = false;
  String _path = "";

  init() async {
    _isDownloaded = await isDownloaded(widget.message.text);
    Logger().w(_isDownloaded);
    if(fromLocal()){
      _path = widget.message.text;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
     setState(() {

     });
    });

  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if(fromLocal()){
          OpenFilex.open(widget.message.text);
        }else if(_isDownloaded) {
          Logger().w(_path);
          OpenFilex.open(_path);
        }else{
          _path = await downloadAudioFromUrl(widget.message.text) ?? "";
        }

      },
      child: Row(
        children: [
           loading ? const CupertinoActivityIndicator(color: Colors.white,) : (!_isDownloaded ? const Icon(Icons.download_outlined, color: Colors.white,) : const Icon(Icons.file_present_rounded, color: Colors.white,)),
          10.horizontalSpace,
          Text(widget.message.text.split("/").last, style: const TextStyle(color: Colors.white),)
        ],
      ),
    );
  }
}
