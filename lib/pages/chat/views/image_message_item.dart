import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/message.dart';

class ImageMessageItem extends StatelessWidget {
  final Message message;
  const ImageMessageItem({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    messageImageClicked(String imageUrl){
      ImageProvider<Object>? imageProvider;
      if(imageUrl.contains("http")){
        imageProvider = NetworkImage(
          imageUrl,
        );
      }else{
        imageProvider = FileImage(File(imageUrl));
      }
      showImageViewer(
          context,
          imageProvider,
          swipeDismissible: true,
          immersive: false,
          onViewerDismissed: () {});
    }

    return GestureDetector(
      onTap: ()=> messageImageClicked(message.text),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(message.fromMe ? 0 : 20),
          bottomLeft: Radius.circular(message.fromMe ? 20 : 0),
          topRight: const Radius.circular(20),
          topLeft: const Radius.circular(20),
        ),
        child: CachedNetworkImage(
          imageUrl: message.text,
          height: 180,
          fit: BoxFit.cover,
          placeholder: (context, url) => const SizedBox(
            width: 180,
            height: 180,
            child: CupertinoActivityIndicator(color: Colors.white),
          ),
          errorWidget: (context, url, error) {
            if(!url.contains('http')){
              return SizedBox(
                width: 180,
                height: 180,
                child: Image.file(File(url), fit: BoxFit.cover),
              );
            }
            return const SizedBox(
                width: 180,
                height: 180,
                child: Center(child: Icon(Icons.error_outline, color: Colors.white,)));
          },
        ),
      ),
    );
  }
}
