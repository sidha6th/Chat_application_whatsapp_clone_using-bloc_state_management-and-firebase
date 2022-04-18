import 'package:chat_app/extra/exports/exports.dart';

class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({
    required this.controller,
    Key? key,
  }) : super(key: key);
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 100,
      pinned: true,
      title: const TextWidget(
        text: 'WhatsApp',
        size: 23,
        weight: FontWeight.bold,
        color: grey,
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            color: grey,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert,
            color: grey,
          ),
        ),
      ],
      toolbarHeight: 52,
      foregroundColor: blueGrey,
      backgroundColor: blueGrey,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      bottom: PreferredSize(
        preferredSize: Size(size.width,0),
        child: TabBar(
          controller: controller,
          unselectedLabelColor: grey,
          labelPadding: EdgeInsets.zero,
          indicatorWeight: 4,
          isScrollable: true,
          indicatorColor: green,
          labelColor: green,
          tabs: <Widget>[
            SizedBox(
              width: size.width * 0.1,
              child: IconButton(
                icon: const Icon(
                  Icons.camera_alt,
                  color: grey,
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: size.width * 0.3,
              child: const Tab(
                text: 'CHATS',
              ),
            ),
            SizedBox(
              width: size.width * 0.3,
              child: const Tab(
                text: 'STATUS',
              ),
            ),
            SizedBox(
              width: size.width * 0.3,
              child: const Tab(
                text: 'CALLS',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
