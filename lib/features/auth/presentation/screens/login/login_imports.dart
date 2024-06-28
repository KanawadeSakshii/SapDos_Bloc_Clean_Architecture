import 'package:bloc_project/core/common/widget/loader.dart';
import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:bloc_project/core/theme/theme.dart';
import 'package:bloc_project/dependencies/dependescies_imports.dart';
import 'package:bloc_project/features/auth/data/model/user_login_model.dart';
import 'package:bloc_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_project/features/auth/presentation/bloc/auth_event.dart';
import 'package:bloc_project/features/auth/presentation/bloc/auth_state.dart';
import 'package:bloc_project/features/auth/presentation/widgets/auth_button.dart';
import 'package:bloc_project/features/auth/presentation/widgets/auth_field.dart';
import 'package:bloc_project/features/auth/presentation/widgets/error_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
part 'login_screen.dart';
