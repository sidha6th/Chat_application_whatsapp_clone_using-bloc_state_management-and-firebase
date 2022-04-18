import 'package:chat_app/extra/exports/exports.dart';
import 'package:chat_app/model/chats_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(
          HomeState(chatsDone: [], contacts: []),
        ) {
    Future getContact(GetContacts event, Emitter<HomeState> emit) async {
      state.isGranted == false
          ? await Permission.contacts.status.isGranted
              ? {
                  state.isGranted = true,
                  state.contacts.clear(),
                  state.contacts = await ContactsService.getContacts(
                    photoHighResolution: false,
                  ),
                }
              : Permission.contacts.request()
          : state.isGranted;
      emit(
        HomeState(
          chatsDone: [],
          contacts: state.contacts,
        ),
      );
    }

    on<GetContacts>(getContact);
    on<GetSearchResults>(
      (event, emit) {},
    );
  }
}
