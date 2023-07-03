import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);
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
                          title: const Text("About and help"),
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
                        ListItem(title: "Faq", icon: Icons.contact_support, onClicked: (){}),
                        const SizedBox(height: 15,),
                        ListItem(title: "Contact us", icon: Icons.perm_contact_cal_sharp, onClicked: (){}),
                        const SizedBox(height: 15,),
                        ListItem(title: "Terms and Privacy Policy", icon: Icons.privacy_tip, onClicked: (){}),
                        const SizedBox(height: 15,),
                        ListItem(title: "App info", icon: Icons.info, onClicked: (){}),
                        const SizedBox(height: 15,),
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
          ),
        ],
      ),
    );
  }
}


