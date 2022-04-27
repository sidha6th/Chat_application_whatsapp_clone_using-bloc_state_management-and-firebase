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
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return ListView.separated(
          controller: state.scrollController,
          shrinkWrap: true,
          itemCount: state.contacts.length,
          itemBuilder: (context, index) {
            if (forAdd) {
              return state.contacts[index].isExistingUser
                  ? ListTile(
                      leading: const DpHoldingWidget(color: grey,encodedImg: ''),
                      title: TextWidget(text: state.contacts[index].name),
                      onTap: () {
                        context.read<GroupBloc>().add(AddGroupMembers(
                            memberName: state.contacts[index].name,
                            phoneNumber: state.contacts[index].phone));
                      },
                    )
                  : const SizedBox();
            } else {
              return ListTile(
                leading: const DpHoldingWidget(
                  encodedImg: '',
                  color: grey,
                ),
                title: TextWidget(text: state.contacts[index].name),
                trailing: state.contacts[index].isExistingUser
                    ? const SizedBox()
                    : Wrap(
                        children: const <Widget>[
                          TextWidget(text: 'Invite', color: green),
                          Icon(Icons.add,
                              color: white,
                              size: 15,
                              textDirection: TextDirection.rtl),
                        ],
                      ),
                onTap: () {
                  if (state.contacts[index].isExistingUser) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => IndividualChatScreen(
                          encodedDp: '',
                          isGroup: false,
                          chatRoomId: '',
                          isChatRoomCreated: false,
                          name: state.contacts[index].name,
                          phone: state.contacts[index].phone,
                        ),
                      ),
                    );
                  }
                },
              );
            }
          },
          separatorBuilder: (context, index) => const Divider(
            color: transp,
          ),
        );
      },
    );
  }
}
