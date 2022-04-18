import 'package:chat_app/bloc/group/group_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';
import 'package:chat_app/view/contacts/group_crea/widgets/stacked_dp_holding_widget.dart';
import 'package:chat_app/view/contacts/widgets/contact_holding_widget.dart';

class GroupCreatingPage extends StatelessWidget {
  const GroupCreatingPage({
    required this.homeState,
    Key? key,
  }) : super(key: key);
  final HomeState homeState;
  @override
  Widget build(BuildContext context) {
    ScrollController scrollcontroller=ScrollController();
    return Scaffold(
      backgroundColor: homeColor,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 50),
        child: const GroupCreationAppbarWidget(
          subtitle: 'Add participants',
          actionVisible: true,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: BlocBuilder<GroupBloc, GroupState>(
              builder: (context, state) {
                return Visibility(
                  visible: state.groupMembers.isEmpty ? false : true,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 90,
                    child: ListView.separated(
                      controller: scrollcontroller,
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Column(
                        children:<Widget>[
                          StackedDpHolderwidget(
                            index: index,
                          ),
                          TextWidget(
                            text:
                                state.groupMembers[index].memberName.length > 12
                                    ? state.groupMembers[index].memberName
                                        .substring(
                                        0,
                                        12,
                                      )
                                    : state.groupMembers[index].memberName,
                          ),
                        ],
                      ),
                      separatorBuilder: (
                        context,
                        index,
                      ) =>
                          const SizedBox(
                        width: 10,
                      ),
                      itemCount: state.groupMembers.length,
                    ),
                  ),
                );
              },
            ),
          ),
          ContactListHoldingWidget(
            forAdd: true,
            homeState: homeState,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: green,
        onPressed: () {
          // context.read<GroupState>().groupMembers.isEmpty
          //     ? ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(
          //           content: TextWidget(text: 'Atleast 1 contact should be selected'),
          //         ),
          //       )
          //     :
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => const GroupCreationFinalPage(),
            ),
          );
        },
        child: const Icon(
          Icons.arrow_forward,
          color: white,
        ),
      ),
    );
  }
}
