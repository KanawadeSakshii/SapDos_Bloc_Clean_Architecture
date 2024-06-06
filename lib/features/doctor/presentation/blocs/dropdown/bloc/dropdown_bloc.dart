import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dropdown_event.dart';
part 'dropdown_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc() : super(DropdownCollapsed()) {
    on<ToggleDropdown>((event, emit) {
      if (state is DropdownCollapsed) {
        emit(DropdownExpanded());
      } else {
        emit(DropdownCollapsed());
      }
    });
  }
}
