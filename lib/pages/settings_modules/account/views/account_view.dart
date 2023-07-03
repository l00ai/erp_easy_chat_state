import 'package:erp_easy_chat_state/components/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {

  String? selectedStatus = "At the work";
  List<String> listStatus = ["At the work", "Busy", "Offline"];
  setStatus(String val){
    selectedStatus = val;
    setState(() {});
  }


  String? selectedNumber = "+972 592 780 688";
  List<String> listNumber = ["+972 592 780 688"];
  setNumber(String val){
    selectedNumber = val;
    setState(() {});
  }


  String? selectedSeen = "Nobody";
  List<String> listSeen = ["Nobody", "Everyone", "My contacts"];
  setSeen(String val){
    selectedSeen = val;
    setState(() {});
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
                          title: const Text("Account"),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
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
                              const SizedBox(height: 15,),
                              Text("Who can see my personal info", style: TextStyle(color: theme.primaryColor, fontWeight: FontWeight.bold, fontSize: 18),),
                              const SizedBox(height: 15,),
                              DropDownList<String>(
                                title: "Status",
                                value: selectedStatus,
                                onSelect: (value)=> setStatus(value),
                                list: listStatus,
                              ),
                              const SizedBox(height: 10,),
                              DropDownList<String>(
                                title: "Change number",
                                value: selectedNumber,
                                onSelect: (value)=> setNumber(value),
                                list: listNumber,
                              ),
                              const SizedBox(height: 10,),
                              DropDownList<String>(
                                title: "My last seen",
                                value: selectedSeen,
                                onSelect: (value)=> setSeen(value),
                                list: listSeen,
                              ),
                              const SizedBox(height: 10,),
                              DropDownList<String>(
                                title: "Profile Photo",
                                value: selectedSeen,
                                onSelect: (value)=> setSeen(value),
                                list: listSeen,
                              ),
                              const SizedBox(height: 10,),
                              DropDownList<String>(
                                title: "About",
                                value: selectedSeen,
                                onSelect: (value)=> setSeen(value),
                                list: listSeen,
                              ),
                              const SizedBox(height: 10,),
                              DropDownList<String>(
                                title: "Groups",
                                value: selectedSeen,
                                onSelect: (value)=> setSeen(value),
                                list: listSeen,
                              ),

                            ],
                          ),
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
