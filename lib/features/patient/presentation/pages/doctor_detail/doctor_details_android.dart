// part of 'doctor_details_imports.dart';

// class DoctorDetailsAndroidState extends StatelessWidget {
//   final String doctorId;

//   const DoctorDetailsAndroidState({
//     super.key,
//     required this.doctorId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => DoctorDetailsBloc(
//         // serviceLocator<GetAllDoctorDetailsUseCase>(),
//         serviceLocator<GetDoctorByUIdUseCase>(),
//         serviceLocator<GetAvailableSlotsUseCase>(),
//         serviceLocator<BookAppointmentUseCase>(),
//       )..add(LoadDoctorById(doctorId)),
//       child: Scaffold(
//         appBar: AppBar(),
//         body: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: BlocBuilder<DoctorDetailsBloc, DoctorDetailsState>(
//             builder: (context, state) {
//               if (state.selectedDoctor == null) {
//                 if (state.error != null) {
//                   return Center(child: Text(state.error!));
//                 }
//                 return const Center(child: CircularProgressIndicator());
//               }
//               final DoctorModel doctorModel =
//                   DoctorModel.fromDoctor(state.selectedDoctor!);

//               final doctorDetailsBloc = context.read<DoctorDetailsBloc>();
//               return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: CircleAvatar(
//                         radius: 50,
//                         backgroundImage: AssetImage(doctorModel.doctorImage),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Expanded(
//                         child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             InfoRowWidget(
//                               icon: Icons.person,
//                               text: doctorModel.doctorName,
//                               textStyle: const TextStyle(
//                                 color: AppPallete.gradient1,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                             ),
//                             const SizedBox(width: 80),
//                             RatingBarIndicator(
//                               rating: doctorModel.rating,
//                               itemBuilder: (context, index) => const Icon(
//                                 Icons.star,
//                                 color: Colors.amber,
//                               ),
//                               itemCount: 5,
//                               itemSize: 20.0,
//                               direction: Axis.horizontal,
//                             ),
//                             const SizedBox(width: 10),
//                             const Text("521"),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         InfoRowWidget(
//                           icon: Icons.assignment_turned_in_outlined,
//                           text: doctorModel.doctorSpecialization,
//                           textStyle: const TextStyle(
//                             color: AppPallete.gradient1,
//                             fontWeight: FontWeight.normal,
//                             fontSize: 14,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 InfoRowWidget(
//                                   icon: Icons.content_paste_sharp,
//                                   text: doctorModel.education,
//                                   textStyle: const TextStyle(
//                                     color: AppPallete.gradient1,
//                                     fontWeight: FontWeight.normal,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 100),
//                                 Container(
//                                   decoration: const BoxDecoration(
//                                     color: AppPallete.gradient4,
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       const Icon(Icons.edit_document),
//                                       const SizedBox(width: 10),
//                                       Text(doctorModel.experience),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 20),
//                             const Text(
//                               "Description",
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             const SizedBox(height: 10),
//                             Text(doctorModel.description),
//                           ],
//                         ),
//                         const SizedBox(height: 40),
//                         const SizedBox(height: 20),
//                         AvailableSlotsWidget(
//                           doctorDetailsBloc: doctorDetailsBloc,
//                           state: state,
//                           screenWidth: MediaQuery.of(context).size.width,
//                           doctor: doctorModel,
//                         ),
//                         const SizedBox(height: 20),
//                         Center(
//                           child: BookAppointmentButton(
//                             doctorDetailsBloc: doctorDetailsBloc,
//                             state: state,
//                           ),
//                         ),
//                       ],
//                     ))
//                   ]);
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
