import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AddStorySection(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text("New Status", style: TextStyle(color: theme.primaryColor, fontSize: 16, fontWeight: FontWeight.bold),),
          ),
          const StatusSection(
            image: "https://images.firstpost.com/wp-content/uploads/2018/11/samworthington-380.jpg",
            name: "Norma Andong",
          ),
          const StatusSection(
            image: "https://global-uploads.webflow.com/600af1368b0b4075be07c984/606b12059a08b630af565ae0_gPZwCbdS%20(1).jpeg",
            name: "Sami Anatony",
          ),
          const StatusSection(
            image: "https://specials-images.forbesimg.com/imageserve/60676384c5f722607f2ae0df/416x416.jpg?background=000000&cropX1=0&cropX2=1078&cropY1=2&cropY2=1080",
            name: "Ali Abraha",
          )
        ],
      ),
    );
  }
}

class StatusSection extends StatelessWidget {
  final String name;
  final String image;
  const StatusSection({Key? key, required this.name, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              DottedBorder(
                borderType: BorderType.Circle,
                padding: const EdgeInsets.all(4),
                dashPattern: const [2 , 5],
                strokeWidth: 2,
                strokeCap: StrokeCap.round,
                color: theme.colorScheme.secondary,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.network(image, fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(width: 17,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 7,),
                  const Row(
                    children: [
                      Icon(Icons.access_time_filled, size: 15, color: Colors.grey,),
                      SizedBox(width: 4,),
                      Text("Today, 07:00 PM", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600),),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              const Row(
                children: [
                  Icon(Icons.remove_red_eye_rounded, size: 20, color: Colors.grey,),
                  SizedBox(width: 7,),
                  Text("73", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600),),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 15,),
        SizedBox(
          height: 100,
          child: ListView.builder(
            itemCount: 10,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.only(right: 10),
              width: 100,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 20,),
      ],
    );
  }
}


class AddStorySection extends StatelessWidget {
  const AddStorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: (){

      },
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            Stack(
              children: [
                DottedBorder(
                  borderType: BorderType.Circle,
                  padding: const EdgeInsets.all(4),
                  dashPattern: const [2 , 5],
                  strokeWidth: 2,
                  strokeCap: StrokeCap.round,
                  color: theme.colorScheme.secondary,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.network("https://www.assyst.de/cms/upload/sub/digitalisierung/18-F.jpg"),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: theme.colorScheme.secondary,
                      border: Border.all(color: Colors.white, width: 2)
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.add, color: Colors.white, size: 18),
                  ),
                )
              ],
            ),
            const SizedBox(width: 17,),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("My Status", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),),
                SizedBox(height: 7,),
                Text("Tap to add status update", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
