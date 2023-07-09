import 'package:erp_easy_chat_state/components/drop_down_list.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? selectedStatus = "At the work";
  List<String> listStatus = ["At the work", "Busy", "Offline"];

  setStatus(String val) {
    selectedStatus = val;
    setState(() {});
  }

  String? selectedNumber = "+972 592 780 688";
  List<String> listNumber = ["+972 592 780 688"];

  setNumber(String val) {
    selectedNumber = val;
    setState(() {});
  }

  String? selectedSeen = "Nobody";
  List<String> listSeen = ["Nobody", "Everyone", "My contacts"];

  setSeen(String val) {
    selectedSeen = val;
    setState(() {});
  }

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
                  child: Image.asset(
                    "assets/images/profile-bg.png",
                    height: 300,
                    fit: BoxFit.fill,
                  )),
              Positioned(
                bottom: 23,
                right: 23,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: theme.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: Colors.white, width: 2)),
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
                        child: Image.network(
                            "https://www.assyst.de/cms/upload/sub/digitalisierung/18-F.jpg",
                            width: 180,
                            height: 180))),
              ),
              Positioned(
                bottom: 15,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Jessica",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    Text(
                      "Last seen today as 04:18 PM",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
              AppBar(
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Media",
                  style: TextStyle(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Row(
                  children: const [
                    Text(
                      "98",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: 10,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.only(right: 10),
                width: 100,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  DropDownList<String>(
                    title: "Status",
                    value: selectedStatus,
                    onSelect: (value) => setStatus(value),
                    list: listStatus,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropDownList<String>(
                    title: "Change number",
                    value: selectedNumber,
                    onSelect: (value) => setNumber(value),
                    list: listNumber,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropDownList<String>(
                    title: "My last seen",
                    value: selectedSeen,
                    onSelect: (value) => setSeen(value),
                    list: listSeen,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
