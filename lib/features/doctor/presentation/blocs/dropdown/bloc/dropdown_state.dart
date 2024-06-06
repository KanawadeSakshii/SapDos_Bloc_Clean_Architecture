part of 'dropdown_bloc.dart';

sealed class DropdownState extends Equatable {
  const DropdownState();

  @override
  List<Object> get props => [];
}

final class DropdownInitial extends DropdownState {}

class DropdownCollapsed extends DropdownState {}

class DropdownExpanded extends DropdownState {}
