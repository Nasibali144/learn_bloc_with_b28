import 'package:bloc/bloc.dart';
import 'package:learn_bloc_with_b28/lesson%20one/contact_model.dart';
import 'package:learn_bloc_with_b28/lesson%20one/network_service.dart';
part 'contact_state.dart';

/// cubit
class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(const ContactState());

  void addContact() {}

  void readContact() async {
    emit(state.copyWith(cubitState: StatesCubit.loading));
    final json = await Network.methodGet(api: Network.apiContacts);
    if (json != null) {
      final list = Network.parseContact(json);
      emit(state.copyWith(contacts: list, cubitState: StatesCubit.loaded));
    } else {
      emit(state.copyWith(message: "Something Error", contacts: state.contacts, cubitState: StatesCubit.error));
    }
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
