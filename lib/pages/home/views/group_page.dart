import 'package:avatar_stack/avatar_stack.dart';
import 'package:erp_easy_chat_state/config/light_theme_colors.dart';
import 'package:erp_easy_chat_state/pages/chat/views/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 25, right: 20, left: 20),
      physics: const BouncingScrollPhysics(),
      children: const [
        ListItem(name: "Michael Beher", seen: false, lastMessage: "Hi, Michael Beher", count: 14),
        ListItem(name: "Hamed Ali", seen: true, lastMessage: "Hi, Hamed Ali", count: 2),
        ListItem(name: "Samia Hussam", seen: false, lastMessage: "Hi, Samia Hussam", count: 25),
        ListItem(name: "Ameera Asad", seen: false, lastMessage: "Hi, Ameera Asad", count: 18),
        ListItem(name: "Walla Beher", seen: true, lastMessage: "Hi, Walla Beher", count: 3),
        ListItem(name: "Omar Tamer", seen: false, lastMessage: "Hi, Omar Tamer", count: 5),
      ],
    );
  }
}


class ListItem extends StatelessWidget {
  final String name;
  final String lastMessage;
  final bool seen;
  final int count;
  const ListItem({Key? key, required this.name, required this.lastMessage, required this.seen, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ChatViewMain(),
            ));
      },
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: Offset(-5, 0)
              )
            ]
        ),
        child: Row(
          children: [
            const SizedBox(
              height: 50,
              width: 50,
              child: CircleAvatar(
                backgroundImage: NetworkImage("https://www.assyst.de/cms/upload/sub/digitalisierung/18-F.jpg"),
              ),
            ),
            const SizedBox(width: 15,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: AvatarStack(
                          height: 25,
                          avatars: [
                            for (var n = 0; n < count; n++)
                              NetworkImage('https://i.pravatar.cc/150?img=$n'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5,),
                      const Text("09:25 PM", style: TextStyle(fontSize: 11, color: Colors.grey),),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset("assets/vectors/seen.svg", color: seen ? LightThemeColors.iconSecondaryColor: Colors.black12,),
                      const SizedBox(width: 5,),
                      Text(lastMessage, style: const TextStyle(fontSize: 12, color: Colors.grey),),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
