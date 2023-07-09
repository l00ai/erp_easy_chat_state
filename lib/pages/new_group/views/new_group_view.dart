import 'package:erp_easy_chat_state/config/light_theme_colors.dart';
import 'package:flutter/material.dart';

class NewGroupView extends StatefulWidget {
  const NewGroupView({Key? key}) : super(key: key);

  @override
  State<NewGroupView> createState() => _NewGroupViewState();
}

class _NewGroupViewState extends State<NewGroupView> {

  // String? selectedStatus = "At the work";
  // List<String> listStatus = ["At the work", "Busy", "Offline"];
  // setStatus(String val){
  //   selectedStatus = val;
  //   setState(() {});
  // }
  //
  //
  // String? selectedNumber = "+972 592 780 688";
  // List<String> listNumber = ["+972 592 780 688"];
  // setNumber(String val){
  //   selectedNumber = val;
  //   setState(() {});
  // }
  //
  //
  // String? selectedSeen = "Nobody";
  // List<String> listSeen = ["Nobody", "Everyone", "My contacts"];
  // setSeen(String val){
  //   selectedSeen = val;
  //   setState(() {});
  // }
  //
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset("assets/images/profile-bg.png", height: 300, fit: BoxFit.fill,)),

              Positioned(
                bottom: 23,
                right: 23,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: theme.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: Colors.white, width: 2)
                  ),
                  child: Icon(Icons.camera_alt, color: Colors.white, size: 32),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                            width: 180,
                            height: 180,
                          decoration: BoxDecoration(
                            color: theme.backgroundColor
                          ),
                          child: Icon(Icons.camera_alt, color: theme.colorScheme.secondary, size: 120,),
                        ))),
              ),
              const Positioned(
                bottom: 15,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Jessica", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
                  ],
                ),
              ),
              AppBar(
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text("Group info", style: TextStyle(color: theme.primaryColor, fontWeight: FontWeight.bold, fontSize: 18),),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Short description of group"
                      ),
                    ),
                  ),
                  const SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Participants (0)", style: TextStyle(color: theme.primaryColor, fontWeight: FontWeight.bold, fontSize: 18),),
                        TextButton(onPressed: (){}, child: Text("Add more", style: TextStyle(color: theme.colorScheme.secondary),))
                      ],
                    ),
                  ),
                  const SizedBox(height: 50,),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Container(
                        width: 120,
                        height: 45,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [
                                  LightThemeColors.primaryColor,
                                  LightThemeColors.secondaryColor,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [
                                  0.2, 1.0
                                ]
                            ),
                          borderRadius: BorderRadius.circular(22)
                        ),
                        alignment: Alignment.center,
                        child: const Text("Save group", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  )

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
