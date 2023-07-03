import 'package:erp_easy_chat_state/components/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SettingChatView extends StatefulWidget{
  const SettingChatView({Key? key}) : super(key: key);

  @override
  State<SettingChatView> createState() => _SettingChatViewState();
}

class _SettingChatViewState extends State<SettingChatView> {

  String? selectedFont = "Small";
  List<String> listFont = ["Small", "Medium", "Large"];
  setFont(String val){
    selectedFont = val;
    setState(() {});
  }

  String? selectedLanguage = "English";
  List<String> listLanguage = ["English", "Arabic"];
  setLanguage(String val){
    selectedLanguage = val;
    setState(() {});
  }

  bool light = true;
  sentOnClicked(val){
    light = val;
    setState(() {});
  }

  bool media = false;
  mediaOnClicked(val){
    media = val;
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
                          title: const Text("Chat"),
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
                            const SizedBox(height: 15,),
                            Text("Who can see my personal info", style: TextStyle(color: theme.primaryColor, fontWeight: FontWeight.bold, fontSize: 18),),
                            const SizedBox(height: 15,),
                            SwitchButton(
                                title: "Enter is send",
                                subtitle: "Enter key will send your message",
                                value: light,
                              onClicked: (val)=> sentOnClicked(val),
                            ),
                            SwitchButton(
                              title: "Media visibility",
                              subtitle: "Show newly downloaded media in your phone's gallery",
                              value: media,
                              onClicked: (val)=> mediaOnClicked(val),
                            ),
                            const SizedBox(height: 15,),
                            DropDownList<String>(
                              title: "Font size",
                              value: selectedFont,
                              onSelect: (value)=> setFont(value),
                              list: listFont,
                            ),
                            const SizedBox(height: 10,),
                            DropDownList<String>(
                              title: "App Language",
                              value: selectedLanguage,
                              onSelect: (value)=> setLanguage(value),
                              list: listLanguage,
                            ),
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


class SwitchButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final Function onClicked;
  const SwitchButton({Key? key, required this.value, required this.onClicked, required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      contentPadding: EdgeInsets.zero,
      trailing: Theme(
        data: ThemeData(useMaterial3: true),
        child: Switch(
          // This bool value toggles the switch.
          value: value,
          activeColor: Colors.green,
          onChanged: (bool value) => onClicked(value),
        ),
      ),
    );
  }
}
