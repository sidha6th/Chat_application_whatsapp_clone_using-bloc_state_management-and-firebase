import 'package:chat_app/bloc/group/group_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';

class ContactListHoldingWidget extends StatelessWidget {
  const ContactListHoldingWidget(
      {this.forAdd = false, required this.homeState, Key? key})
      : super(key: key);
  final HomeState homeState;
  final bool forAdd;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: homeState.scrollController,
      shrinkWrap: true,
      itemCount: homeState.contacts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const DpHoldingWidget(color: grey,),
          title: TextWidget(
            text: homeState.contacts[index].displayName ??
                homeState.contacts[index].phones![0].value.toString(),
          ),
          onTap: () {
            forAdd
                ? context.read<GroupBloc>().add(
                      AddGroupMembers(
                        memberName: homeState.contacts[index].displayName ??
                            homeState.contacts[index].phones![0].value
                                .toString(),
                        phoneNumber: homeState.contacts[index].phones![0].value
                            .toString(),
                      ),
                    )
                : {
                    if (homeState.contacts[index].phones?[0].value != null)
                      {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => IndividualChatScreen(
                              name: homeState.contacts[index].displayName ??
                                  homeState.contacts[index].phones![0].value
                                      .toString(),
                              phone: homeState.contacts[index].phones![0].value
                                  .toString(),
                            ),
                          ),
                        )
                      }
                  };
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(
        color: transp,
      ),
    );
  }
}
