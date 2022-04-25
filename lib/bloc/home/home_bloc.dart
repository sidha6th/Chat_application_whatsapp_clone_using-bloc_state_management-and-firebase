import 'package:chat_app/extra/exports/exports.dart';
import 'package:chat_app/extra/service/firebase_services.dart';
import 'package:chat_app/extra/service/user_service.dart';
import 'package:chat_app/model/chats_model.dart';
import 'package:chat_app/model/contacts_model.dart';
import 'package:chat_app/model/user_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(chatsDone: [], contacts: [])) {
    List<Contact> contacts = [];
    getContact(GetContacts event, Emitter<HomeState> emit) async {
      if (state.isGranted == false) {
        PermissionStatus status = await Permission.contacts.request();
        if (status == PermissionStatus.granted) {
          emit(
            HomeState(
              chatsDone: state.chatsDone,
              contacts: [],
              isGranted: true,
            ),
          );
        } else if (status == PermissionStatus.denied ||
            status == PermissionStatus.permanentlyDenied) {
          emit(
            HomeState(
              chatsDone: state.chatsDone,
              contacts: [],
              isDenied: true,
            ),
          );
        } else {
          emit(
            HomeState(
              chatsDone: state.chatsDone,
              contacts: [],
              isDenied: true,
            ),
          );
          await Permission.contacts.request();
        }
      }
      if (state.isGranted == true) {
        if (HomeState.allUsers.isEmpty) {
          await FireBaseServices.getAllUsers();
        }

        if (state.contacts.isEmpty) {
          contacts = await UserDataServices.getContacts();
        }
        if (contacts.isEmpty) {
          emit(
            HomeState(
              chatsDone: state.chatsDone,
              contacts: [],
            ),
          );
        } else {
          bool isExisting = false;
          ContactsModel contactModel;
          late String phone;
          for (var i = 0; i < contacts.length; i++) {
            for (var users in HomeState.allUsers) {
              if (UserDataServices.removeSpecialChar(
                        contacts[i].phones?[0].value.toString() ?? '0',
                      ).length >=
                      10 &&
                  users.phone.contains(UserDataServices.removeSpecialChar(
                    contacts[i].phones?[0].value.toString() ?? '',
                  ))) {
                phone = users.phone;
                isExisting = true;
                break;
              } else {
                isExisting = false;
              }
            }
            if (isExisting == true) {
              contactModel = ContactsModel(
                name: contacts[i].displayName ??
                    contacts[i].phones![0].value.toString(),
                phone: phone,
                isExistingUser: true,
              );
              state.contacts.add(
                contactModel,
              );
            } else {
              contactModel = ContactsModel(
                name: contacts[i].displayName ??
                    contacts[i].phones![0].value.toString(),
                phone: contacts[i].phones![0].value.toString(),
                isExistingUser: false,
              );
              state.contacts.add(
                contactModel,
              );
            }
          }
          emit(
            HomeState(
              chatsDone: state.chatsDone,
              contacts: state.contacts,
            ),
          );
        }
      }
    }

    on<GetContacts>(getContact);
    on<GetSearchResults>(
      (event, emit) {},
    );
  }
}










            // );
            // print(
            //   'its operation:::: ${item.phones![0].value!
            //     .replaceAll(' ', '')
            //     .replaceAll('-', '')
            //     .replaceAll('(', '')
            //     .replaceAll(')', '')
            //     .trim()}',
            // );