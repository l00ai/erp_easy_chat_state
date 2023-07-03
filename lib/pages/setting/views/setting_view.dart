import 'package:erp_easy_chat_state/pages/settings_modules/about/views/about_view.dart';
import 'package:erp_easy_chat_state/pages/settings_modules/account/views/account_view.dart';
import 'package:erp_easy_chat_state/pages/settings_modules/invite/views/invite_view.dart';
import 'package:erp_easy_chat_state/pages/settings_modules/setting_chat/views/setting_chat_view.dart';
import 'package:erp_easy_chat_state/pages/settings_modules/setting_notification/views/setting_notification_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);
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
                          title: const Text("Settings"),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              height: 70,
                              width: 70,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage("https://www.assyst.de/cms/upload/sub/digitalisierung/18-F.jpg"),
                              ),
                            ),
                            const SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Jessica", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                SizedBox(height: 10,),
                                Text("At work", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 25,),
                        ListItem(title: "Account", icon: Icons.key, onClicked: (){
                          //Get.toNamed(Routes.ACCOUNT);
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const AccountView(),
                              ));
                        }),
                        const SizedBox(height: 15,),
                        ListItem(title: "Chat", icon: Icons.mail, onClicked: (){
                          //Get.toNamed(Routes.SETTING_CHAT);
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const SettingChatView(),
                              ));
                        }),
                        const SizedBox(height: 15,),
                        ListItem(title: "Notifications", icon: Icons.notifications, onClicked: (){
                          //Get.toNamed(Routes.SETTING_NOTIFICATION);
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const SettingNotificationView(),
                              ));
                        }),
                        const SizedBox(height: 15,),
                        ListItem(title: "Invite friends", icon: Icons.group, onClicked: (){
                          //Get.toNamed(Routes.INVITE);
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const InviteView(),
                              ));
                        }),
                        const SizedBox(height: 15,),
                        ListItem(title: "About and help", icon: Icons.quora, onClicked: (){
                          //Get.toNamed(Routes.ABOUT);
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const AboutView(),
                              ));
                        }),
                      ],
                    ),
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
  final String title;
  final IconData icon;
  final Function onClicked;
  const ListItem({Key? key, required this.title, required this.icon, required this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: ()=> onClicked(),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey.withOpacity(0.5))
            ),
            height: 55,
            child: Row(
              children: [
                const SizedBox(width: 40,),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: -10,
            child: Center(
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: theme.accentColor
                ),
                child: Icon(icon, color: Colors.white,),
              ),
            ),
          )
        ],
      ),
    );
  }
}

