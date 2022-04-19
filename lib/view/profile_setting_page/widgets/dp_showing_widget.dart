import 'dart:convert';
import 'package:chat_app/bloc/group/group_bloc.dart';
import 'package:chat_app/bloc/profile/profile_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';

class UserProfileDpShowingWidget extends StatelessWidget {
  const UserProfileDpShowingWidget({
    this.iconColor=white,
    this.groupState,
    this.profileState,
    this.backgroundColor = grey,
    this.iconsize = 20,
    this.radius = 30,
    required this.icon,
    Key? key,
  }) : super(key: key);
  final double radius;
  final IconData icon;
  final double iconsize;
  final Color backgroundColor;
  final GroupState? groupState;
  final ProfileState? profileState;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: profileState?.encodededImg == null
          ? Icon(
              icon,
              size: iconsize,
              color: iconColor,
            )
          : CircleAvatar(
              radius: radius,
              backgroundImage: MemoryImage(
                base64Decode(
                  profileState!.encodededImg.toString(),
                ),
              ),
            ),
    );
  }
}
