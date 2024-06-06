part of 'dropdown_bloc.dart';

sealed class DropdownEvent extends Equatable {
  const DropdownEvent();

  @override
  List<Object> get props => [];
}

class ToggleDropdown extends DropdownEvent {}
