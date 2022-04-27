import 'package:chat_app/bloc/group/group_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';

class StackedDpHolderwidget extends StatelessWidget {
  const StackedDpHolderwidget({
    required this.index,
    Key? key,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 45,
      child: Stack(
        children: [
          const DpHoldingWidget(
            encodedImg: '',
            color: grey,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: white,
              child: IconButton(
                splashColor: transp,
                padding: EdgeInsets.zero,
                // iconSize: 10,
                onPressed: () {
                  context.read<GroupBloc>().add(
                        RemoveMember(
                          index: index,
                        ),
                      );
                },
                icon: const TextWidget(
                  text: 'x',
                  color: black,
                  size: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
