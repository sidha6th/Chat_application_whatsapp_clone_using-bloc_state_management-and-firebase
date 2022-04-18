import 'package:chat_app/extra/exports/exports.dart';

class GroupCreationAppbarWidget extends StatelessWidget {
  const GroupCreationAppbarWidget({required this.actionVisible,required this.subtitle, Key? key})
      : super(key: key);
  final String subtitle;
  final bool actionVisible;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
         const TextWidget(
            text: 'New group',
          ),
          TextWidget(
            text: subtitle,
            size: 13,
          ),
        ],
      ),
      actions: [
        actionVisible?IconButton(
          onPressed: () {},
          icon:const Icon(
            Icons.search,
          ),
        ):const SizedBox(),
      ],
    );
  }
}
