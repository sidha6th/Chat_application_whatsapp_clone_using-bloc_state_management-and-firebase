import 'package:chat_app/extra/exports/exports.dart';


class DpHoldingWidget extends StatelessWidget {
  const DpHoldingWidget({
    this.radius = 40,
    required this.color,
    this.isPerson=true,
    this.size = const Size(40, 40),
    Key? key,
    
  }) : super(key: key);
  final Size size;
  final double radius;
  final bool isPerson;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Icon(isPerson?Icons.person:Icons.group,color: white,),
      backgroundColor: color,
    );
  }
}
