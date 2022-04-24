import 'package:chat_app/extra/exports/exports.dart';
import 'package:chat_app/view/contacts/group_crea/group_creating_page.dart';
import 'package:chat_app/view/contacts/widgets/contact_holding_widget.dart';
import 'package:chat_app/view/profile_setting_page/widgets/dp_showing_widget.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeColor,
      appBar: AppBar(
        title: const TextWidget(
          text: 'Select Contact',
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.isDenied) {
              return const Center(
                child: TextWidget(
                  text: 'Permission Denied',
                ),
              );
            } else if (state.contacts.isEmpty) {
              return const Scaffold(
                backgroundColor: homeColor,
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return ListView(
                shrinkWrap: true,
                controller: state.scrollController,
                children: [
                  ListTile(
                    leading: const UserProfileDpShowingWidget(
                      backgroundColor: darkGreen,
                      icon: Icons.group,
                      radius: 20,
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => GroupCreatingPage(
                            homeState: state,
                          ),
                        ),
                      );
                    },
                    title: const TextWidget(
                      text: 'Create group',
                    ),
                  ),
                  ContactListHoldingWidget(
                    homeState: state,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
