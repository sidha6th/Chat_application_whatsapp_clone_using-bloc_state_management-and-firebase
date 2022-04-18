import 'package:chat_app/bloc/profile/profile_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';
import 'package:chat_app/view/profile_setting_page/widgets/dp_showing_widget.dart';

class ProfileSettingPage extends StatelessWidget {
  const ProfileSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: homeColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: blueGrey,
        title: const TextWidget(
          text: 'Create your Profile',
          color: blue,
          size: 20,
          weight: FontWeight.bold,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: TextWidget(
                    text: 'You can find and edit this info in your Settings',
                    color: grey,
                    align: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  context.read<ProfileBloc>().add(
                        AddDpImage(),
                      );
                },
                child:  BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return UserProfileDpShowingWidget(
                                  profileState:state,
                                  radius: 60,
                                  icon: Icons.add_a_photo,
                                  size: 20,
                                );
                  },
                ),
              ),
              Form(
                key: ProfileState.profileFormKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: size.width,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 15,
                              left: 5,
                            ),
                            child: Icon(
                              Icons.person,
                              size: 30,
                              color: grey,
                            ),
                          ),
                          SizedBox(
                            width: size.shortestSide * 0.8,
                            child: TextFormFieldWidget(
                              errorValidator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your name';
                                } else {
                                  return null;
                                }
                              },
                              keybordType: TextInputType.name,
                              hint: 'Name',
                              textColor: grey,
                              textEditingController:
                                  ProfileState.usernameController,
                              color: grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 15,
                              left: 5,
                            ),
                            child: Icon(
                              Icons.info,
                              size: 30,
                              color: grey,
                            ),
                          ),
                          SizedBox(
                            width: size.shortestSide * 0.8,
                            child: TextFormFieldWidget(
                              errorValidator: (String? value) {
                                return null;
                              },
                              keybordType: TextInputType.name,
                              hint: 'about',
                              textColor: grey,
                              textEditingController:
                                  ProfileState.aboutFieldController,
                              color: grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 30,
            ),
            child: NextbuttonWidget(
              navigation: () {
                if (ProfileState.profileFormKey.currentState!.validate()) {
                  context.read<ProfileBloc>().add(
                        SaveUserDatas(
                          userName: ProfileState.usernameController.text,
                          userAbout: ProfileState.usernameController.text,
                        ),
                      );
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(),
                    ),
                    (
                      Route<dynamic> route,
                    ) =>
                        false,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
