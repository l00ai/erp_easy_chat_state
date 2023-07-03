import 'package:erp_easy_chat_state/config/light_theme_colors.dart';
import 'package:flutter/material.dart';

class CallView extends StatelessWidget {
  const CallView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: LightThemeColors.primaryColor,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: 0,
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset("assets/images/bg_pattern.png", fit: BoxFit.cover,),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            spreadRadius: 5,
                            blurRadius: 10
                        )
                      ],
                      borderRadius: BorderRadius.circular(75)
                  ),
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: Image.network("https://www.assyst.de/cms/upload/sub/digitalisierung/18-F.jpg",)),
                ),
                const SizedBox(height: 25,),
                const Text("Harry lan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                const SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    ItemBottom(iconData: Icons.videocam_rounded),
                    SizedBox(width: 25,),
                    ItemBottom(iconData: Icons.pause),
                    SizedBox(width: 25,),
                    ItemBottom(iconData: Icons.person),
                  ],
                ),
                const SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    ItemBottom(iconData: Icons.mic),
                    SizedBox(width: 25,),
                    ItemBottom(iconData: Icons.apps_rounded),
                    SizedBox(width: 25,),
                    ItemBottom(iconData: Icons.volume_up_rounded),
                  ],
                ),
                const SizedBox(height: 35,),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.red,
                    ),
                    child: const Icon(Icons.call_end, color: Colors.white,),
                  ),
                )
              ],
            ),
          ],
        )
    );
  }
}

class ItemBottom extends StatelessWidget {
  final IconData iconData;
  const ItemBottom({Key? key, required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Icon(iconData, color: Colors.white, size: 29),
    );
  }
}
