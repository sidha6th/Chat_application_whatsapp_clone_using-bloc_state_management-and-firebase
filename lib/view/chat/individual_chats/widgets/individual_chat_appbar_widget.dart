import 'package:chat_app/extra/exports/exports.dart';

class IndividualChatAppBarWidget extends StatelessWidget {
  const IndividualChatAppBarWidget({
    Key? key,
    required this.isGroup,
    required this.titleName,
    required this.encodedDp,
  }) : super(key: key);
  final String titleName;
  final bool isGroup;
  final String encodedDp;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: blueGrey,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      automaticallyImplyLeading: true,
      leadingWidth: 90,
      leading: Row(
        children: <Widget>[
          IconButton(
            splashRadius: 1,
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (contxt) {
                return const MyHomePage();
              }), (route) => false);
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          DpHoldingWidget(
            encodedImg: encodedDp,
            isGroup: isGroup,
            color: grey,
            size: const Size(
              30,
              30,
            ),
            radius: 30,
          ),
        ],
      ),
      title: TextWidget(
        text: titleName,
        color: white,
        size: 20,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.videocam,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.phone,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert,
          ),
        ),
      ],
    );
  }
}
