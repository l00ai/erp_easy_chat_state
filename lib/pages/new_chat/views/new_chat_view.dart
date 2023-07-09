import 'package:erp_easy_chat_state/pages/chat/views/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewChatView extends StatelessWidget {
  const NewChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              foregroundDecoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  opacity:  0.2,
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
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(40.r))
                    ),
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
                                border: Border.all(color: theme.primaryColor, width: 0)
                            ),
                          ),
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40.r))
                              ),
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
                  height: 90.h,
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppBar(
                          backgroundColor: Colors.transparent,
                          title: const Text("New Chat"),
                          actions: [
                            IconButton(onPressed: (){}, icon: const Icon(Icons.search))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(top: 25, right: 20, left: 20),
                    physics: const BouncingScrollPhysics(),
                    children: const [
                      ListItem(name: "Michael Beher",  bio: "Hi, Michael Beher"),
                      ListItem(name: "Hamed Ali", bio: "Hi, Hamed Ali"),
                      ListItem(name: "Samia Hussam",  bio: "Hi, Samia Hussam"),
                      ListItem(name: "Ameera Asad",  bio: "Hi, Ameera Asad"),
                      ListItem(name: "Walla Beher", bio: "Hi, Walla Beher"),
                      ListItem(name: "Omar Tamer",  bio: "Hi, Omar Tamer"),
                    ],
                  ),
                )
              ],
            ),
          ],
        )
    );
  }
}


class ListItem extends StatelessWidget {
  final String name;
  final String bio;
  const ListItem({Key? key, required this.name, required this.bio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //Get.toNamed(Routes.CHAT);
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
                  offset: const Offset(-5, 0)
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
                    ],
                  ),
                  Text(bio, style: const TextStyle(fontSize: 12, color: Colors.grey),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
