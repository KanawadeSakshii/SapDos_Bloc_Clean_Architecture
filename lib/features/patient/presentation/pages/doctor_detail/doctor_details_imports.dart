import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:bloc_project/dependencies/dependescies_imports.dart';
import 'package:bloc_project/features/doctor/data/models/doctor_model.dart';
import 'package:bloc_project/features/doctor/domain/Usecase/get_doctor_usecase.dart';
import 'package:bloc_project/features/patient/data/model/available_slot_model.dart';
import 'package:bloc_project/features/patient/domain/usecases/book_appoitment_usecase.dart';
import 'package:bloc_project/features/patient/domain/usecases/get_all_doctor_usecase.dart';
import 'package:bloc_project/features/patient/domain/usecases/get_available_slots_usecase.dart';
import 'package:bloc_project/features/patient/presentation/blocs/doctor_details/bloc/doctor_details_bloc.dart';
import 'package:bloc_project/features/patient/presentation/widgets/common_imports.dart';
import 'package:bloc_project/utils/setuplogger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
part 'doctor_detail.dart';
//part 'doctor_details_android.dart';
