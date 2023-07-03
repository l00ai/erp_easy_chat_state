import 'package:erp_easy_chat_state/config/light_theme_colors.dart';
import 'package:erp_easy_chat_state/pages/call/views/call_view.dart';
import 'package:flutter/material.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 25, right: 20, left: 20),
      physics: const BouncingScrollPhysics(),
      children: const [
        ListItem(name: "Michael Beher", seen: false, lastMessage: "Just Now", icon: Icons.call_missed_outgoing_rounded, iconColor: LightThemeColors.iconSecondaryColor),
        ListItem(name: "Hamed Ali", seen: true, lastMessage: "Today 08:10 PM", icon: Icons.call_missed, iconColor: Colors.red),
        ListItem(name: "Omar Tamer", seen: false, lastMessage: "Today 10:00 PM", icon: Icons.call_missed_outgoing_rounded, iconColor: LightThemeColors.iconSecondaryColor),
        ListItem(name: "Samia Hussam", seen: false, lastMessage: "10:00 PM",  icon: Icons.call_missed, iconColor: Colors.red),
        ListItem(name: "Ameera Asad", seen: false, lastMessage: "10:00 PM",  icon: Icons.call_missed, iconColor: Colors.red),
        ListItem(name: "Walla Beher", seen: true, lastMessage: "10:00 PM", icon: Icons.call_missed_outgoing_rounded, iconColor: LightThemeColors.iconSecondaryColor),
      ],
    );
  }
}

class ListItem extends StatelessWidget {
  final String name;
  final String lastMessage;
  final bool seen;
  final IconData icon;
  final Color iconColor;
  const ListItem({Key? key, required this.name, required this.lastMessage, required this.seen, required this.icon, required this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //Get.toNamed(Routes.CALL);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CallView(),
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
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                  Row(
                    children: [
                      Icon(icon, color: iconColor,),
                      const SizedBox(width: 5,),
                      Text(lastMessage, style: const TextStyle(fontSize: 12, color: Colors.grey),),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(onPressed: (){
              //Get.toNamed(Routes.CALL);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CallView(),
                  ));
            }, icon: const Icon(Icons.call, color: Colors.grey,))
          ],
        ),
      ),
    );
  }
}

