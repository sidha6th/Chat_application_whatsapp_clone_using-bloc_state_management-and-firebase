import 'dart:convert';
import 'package:chat_app/bloc/group/group_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';

class GroupCreationFinalPage extends StatelessWidget {
  const GroupCreationFinalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeColor,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 50),
        child: const GroupCreationAppbarWidget(
          subtitle: 'Add subject',
          actionVisible: false,
        ),
      ),
      body: BlocBuilder<GroupBloc, GroupState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: blueGrey,
                width: MediaQuery.of(context).size.width,
                height: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            context.read<GroupBloc>().add(AddImage());
                          },
                          child: CircleAvatar(
                            child: state.encodedGroupDp == null
                                ? const Icon(
                                    Icons.group,
                                    size: 20,
                                  )
                                : CircleAvatar(
                                    radius: 20,
                                    backgroundImage: MemoryImage(
                                      base64Decode(
                                        state.encodedGroupDp.toString(),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Form(
                            key: state.formKey,
                            child: TextFormFieldWidget(
                              keybordType: TextInputType.name,
                              errorValidator: (String? value) {
                                if (value != null && value.trim().isEmpty ||
                                    value == null) {
                                  return 'Fill the Group subject here';
                                } else {
                                  return null;
                                }
                              },
                              hint: 'Type group subject here...',
                              textEditingController: state.groupNameController,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.emoji_emotions_rounded,
                          color: grey,
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 10.0,
                      ),
                      child: TextWidget(
                        text:
                            'Provide a group subject and a optional group icon',
                        size: 13,
                        color: grey,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: TextWidget(
                  text: 'Participants: ${state.groupMembers.length}',
                ),
              ),
              SizedBox(
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    mainAxisExtent: 90,
                  ),
                  itemCount: state.groupMembers.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const DpHoldingWidget(
                          isPerson: true,
                          color: grey,
                          radius: 30,
                        ),
                        TextWidget(
                          text: state.groupMembers[index].memberName.length > 12
                              ? state.groupMembers[index].memberName.substring(
                                  0,
                                  12,
                                )
                              : state.groupMembers[index].memberName,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: BlocBuilder<GroupBloc, GroupState>(
        builder: (context, state) {
          return FloatingActionButton(
            backgroundColor: green,
            onPressed: () {
              if (state.formKey.currentState!.validate()) {
                context.read<GroupBloc>().add(
                      CreateGroup(context: context),
                    );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const MyHomePage(),
                  ),
                  (route) => false,
                );
              }
            },
            child: const Icon(
              Icons.done,
            ),
          );
        },
      ),
    );
  }
}
