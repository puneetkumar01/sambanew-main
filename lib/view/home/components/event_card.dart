
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../theme/apptheme.dart';
// import '../../../util/config.dart';

// class EventCard extends StatelessWidget {
//   const EventCard({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 120.w,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             height:5.h,
//           ),
//           Container(
//             height: 160.h,
//             width: 110.w,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5),
//                 image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage(
//                         "assets/images/event4.png"))),
//           ),
//           SizedBox(
//             height: 5.h,
//           ),
//           Container(
//             width: 110.w,
//               decoration: BoxDecoration(
//                 color: AppTheme.homePagecolor3,
//                 borderRadius: BorderRadius.circular(50),
//               ),
//               child: Padding(
//                 padding:  EdgeInsets.only(top: 2.h,bottom: 2.h,left: 4.w),
//                 child: Text("Wed, 28 Jun onwards",
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodySmall!
//                         .copyWith(fontSize: 10)),
//               )),
//           Text("DJ Aqeel in Singapore",
//               textAlign: TextAlign.start,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: Theme.of(context)
//                   .textTheme
//                   .headlineMedium!.copyWith(fontSize: 14)),
//           Text("Hard Rock Cafe",
//               textAlign: TextAlign.start,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: Theme.of(context)
//                   .textTheme
//                   .headlineSmall!)
//         ],
//       ),
//     );
//   }
// }
