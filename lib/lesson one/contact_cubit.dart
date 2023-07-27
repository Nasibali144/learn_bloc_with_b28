import 'package:bloc/bloc.dart';
import 'package:learn_bloc_with_b28/lesson%20one/network_service.dart';

import 'contact_model.dart';

/// state
abstract class ContactState {
  final List<Contact> contacts;
  final Status status;

  const ContactState({this.status = Status.read, this.contacts = const <Contact>[]});
}

class InitialContactState extends ContactState {
  const InitialContactState();
}

class LoadingContactState extends ContactState {
  const LoadingContactState();
}

class ErrorContactState extends ContactState {
  final String message;
  const ErrorContactState(this.message);
}

class LoadedContactState extends ContactState {
  const LoadedContactState({required super.contacts, super.status});
}

/// cubit
class ContactCubit extends Cubit<ContactState> {
  ContactCubit(): super(const InitialContactState());

  void addContact() {}

  void readContact() async {
    emit(const LoadingContactState());
    final json = await Network.methodGet(api: Network.apiContacts);
    if(json != null) {
      final list = Network.parseContact(json);
      emit(LoadedContactState(contacts: list));
    } else {
      emit(const ErrorContactState("Some thing error"));
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
