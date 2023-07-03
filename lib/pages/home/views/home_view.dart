import 'package:erp_easy_chat_state/pages/contacts/views/contacts_view.dart';
import 'package:erp_easy_chat_state/pages/new_call/views/new_call_view.dart';
import 'package:erp_easy_chat_state/pages/new_chat/views/new_chat_view.dart';
import 'package:erp_easy_chat_state/pages/new_group/views/new_group_view.dart';
import 'package:erp_easy_chat_state/pages/setting/views/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'call_page.dart';
import 'chat_page.dart';
import 'group_page.dart';
import 'status_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  bool showFab = true;

  tabControllerListener() {
    if (tabController.index == 1 || tabController.index == 2) {
      showFab = false;
    } else {
      showFab = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(tabControllerListener);
    super.initState();
  }

  @override
  void dispose() {
    tabController.removeListener(tabControllerListener);
    tabController.dispose();
    super.dispose();
  }

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
                  opacity: 0.2,
                  image: AssetImage("assets/images/bg_pattern.png"),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 145.h,
                    decoration: BoxDecoration(
                        color: theme.primaryColor,
                        border: Border.all(color: theme.primaryColor, width: 0),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(60.r))),
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
                                border: Border.all(
                                    color: theme.primaryColor, width: 0)),
                          ),
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(60.r))),
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
                  height: 145.h,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          10.verticalSpace,
                          GestureDetector(
                            // onTap: (){
                            //   Get.toNamed(Routes.PROFILE);
                            // },
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 50.w,
                                  width: 50.w,
                                  child: const CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://www.assyst.de/cms/upload/sub/digitalisierung/18-F.jpg"),
                                  ),
                                ),
                                10.horizontalSpace,
                                const Text(
                                  "Hi, Loai",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 15),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                    12.horizontalSpace,
                                    PopupMenuButton(
                                      itemBuilder: (context) {
                                        return [
                                          const PopupMenuItem<String>(
                                            value: "New_Group",
                                            child: Text('New Group'),
                                          ),
                                          const PopupMenuItem<String>(
                                            value: "Contacts",
                                            child: Text('Contacts'),
                                          ),
                                          const PopupMenuItem<String>(
                                            value: "Settings",
                                            child: Text('Settings'),
                                          ),
                                        ];
                                      },
                                      onSelected: (value) {
                                        if (value == "New_Group") {
                                          //Get.toNamed(Routes.NEW_GROUP);
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context) => const NewGroupView(),
                                              ));
                                        } else if (value == "Contacts") {
                                          //Get.toNamed(Routes.CONTACTS);
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context) => const ContactsView(),
                                              ));
                                        } else if (value == "Settings") {
                                          //Get.toNamed(Routes.SETTING);
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context) => const SettingView(),
                                              ));
                                        }
                                      },
                                      child: SvgPicture.asset(
                                          "assets/vectors/hamburger.svg",
                                          color: Colors.white,
                                          height: 20),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TabBar(
                                  controller: tabController,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  isScrollable: true,
                                  indicatorColor: Colors.white,
                                  indicatorWeight: 3,
                                  labelStyle: const TextStyle(
                                      fontWeight: FontWeight.w700),
                                  tabs: const [
                                    Tab(
                                      text: "Chat",
                                    ),
                                    Tab(
                                      text: "Group",
                                    ),
                                    Tab(
                                      text: "Status",
                                    ),
                                    Tab(
                                      text: "Call",
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: const [
                      ChatPage(),
                      GroupPage(),
                      StatusPage(),
                      CallPage(),
                    ],
                  ),
                )
              ],
            ),
            Visibility(
              visible: showFab,
              child: Positioned(
                top: 140.h - size.viewPadding.top,
                right: 15.w,
                child: FloatingActionButton(
                  onPressed: () {
                    if (tabController.index == 0) {
                      //Get.toNamed(Routes.NEW_CHAT);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const NewChatView(),
                          ));
                    } else if (tabController.index == 3) {
                      //Get.toNamed(Routes.NEW_CALL);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const NewCallView(),
                          ));
                    }
                  },
                  mini: true,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
