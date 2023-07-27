import 'package:bloc/bloc.dart';
import 'package:learn_bloc_with_b28/lesson%20one/contact_model.dart';
import 'package:learn_bloc_with_b28/lesson%20one/network_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'contact_state.dart';
part 'contact_cubit.freezed.dart';

/// cubit
class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(const InitialContactState());

  void addContact() {}

  void readContact() async {
    emit(const LoadingContactState());
    final json = await Network.methodGet(api: Network.apiContacts);
    if (json != null) {
      final list = Network.parseContact(json);
      emit(LoadedContactState(contacts: list));
    } else {
      emit(const ErrorContactState(message: "Some thing error!"));
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
