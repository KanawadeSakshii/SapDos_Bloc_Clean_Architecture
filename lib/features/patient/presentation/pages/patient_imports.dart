import 'package:bloc_project/core/common/widget/drawer_widget.dart';
import 'package:bloc_project/core/common/widget/loader.dart';
import 'package:bloc_project/dependencies/dependescies_imports.dart';
import 'package:bloc_project/features/doctor/data/models/doctor_model.dart';
import 'package:bloc_project/features/doctor/presentation/widgets/dropdown_bar.dart';
import 'package:bloc_project/features/patient/presentation/blocs/doctor_details/bloc/doctor_details_bloc.dart';
import 'package:bloc_project/features/patient/presentation/blocs/patient_bloc/patient_bloc.dart';
import 'package:bloc_project/features/patient/presentation/pages/doctor_detail/doctor_details_imports.dart';
import 'package:bloc_project/features/patient/presentation/widgets/doctor_details_cart.dart';
import 'package:bloc_project/utils/setuplogger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/common_imports.dart';
part 'patient_screen.dart';
