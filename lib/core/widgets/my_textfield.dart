// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:memories/core/themes/my_colors.dart';
// import 'package:memories/core/themes/my_textstyles.dart';

// class MyTextField extends StatefulWidget {
//   const MyTextField(this.controller, this.labelText, this.focusNode,
//       {Key? key,
//       this.topLabel,
//       this.height,
//       this.nextNode,
//       this.errorMessage = "Please enter a valid value.",
//       this.keyboardType = TextInputType.text,
//       this.readOnly = false,
//       this.onTap,
//       this.required = true,
//       this.inputFormatters})
//       : super(key: key);

//   final TextEditingController controller;
//   final String labelText, errorMessage;
//   final double? height;
//   final String? topLabel;
//   final FocusNode focusNode;
//   final FocusNode? nextNode;
//   final TextInputType keyboardType;
//   final VoidCallback? onTap;
//   final bool readOnly, required;
//   final List<TextInputFormatter>? inputFormatters;

//   @override
//   State<MyTextField> createState() => _MyTextFieldState();
// }

// class _MyTextFieldState extends State<MyTextField> {
//   TextStyle innerTextStyle() => GoogleFonts.ibmPlexSans(
//       textStyle: MyTStyles.kTS18Medium.copyWith(color: MyColors.pink));

//   var hasCurrentFocus = false.obs;
//   var hasInput = false.obs;

//   @override
//   void initState() {
//     widget.focusNode.addListener(() {
//       hasCurrentFocus.value = widget.focusNode.hasFocus;
//     });

//     widget.controller.addListener(() {
//       hasInput.value = widget.controller.text.isNotEmpty;
//     });

//     super.initState();
//   }

//   bool showFloatingLabel() => hasCurrentFocus() || hasInput();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 10.h, top: 5.h),
//       child: TextFormField(
//         readOnly: widget.readOnly,
//         onTap: widget.onTap,
//         cursorColor: MyColors.pink,
//         controller: widget.controller,
//         focusNode: widget.focusNode,
//         inputFormatters: widget.inputFormatters,
//         textInputAction: widget.nextNode == null
//             ? TextInputAction.done
//             : TextInputAction.next,
//         style: innerTextStyle(),
//         keyboardType: widget.keyboardType,
//         decoration: InputDecoration(
//           label: Obx(
//             () => Container(
//               padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5.w),
//                 border: Border.all(
//                   width: 2.w,
//                   color: showFloatingLabel() ? MyColors.pink : MyColors.white,
//                 ),
//               ),
//               child: Text(
//                 showFloatingLabel()
//                     ? widget.topLabel ?? widget.labelText.toUpperCase()
//                     : widget.labelText,
//                 style: TextStyle(
//                   color: showFloatingLabel() ? MyColors.pink : Colors.grey,
//                 ),
//               ),
//             ),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(5.w),
//             borderSide: BorderSide(
//               color: MyColors.pink,
//               width: 1.5.w,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(5.w),
//             borderSide: BorderSide(
//               color: MyColors.pink,
//               width: 2.5.w,
//             ),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(5.w),
//             borderSide: BorderSide(
//               color: Colors.red,
//               width: 2.5.w,
//             ),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(5.w),
//             borderSide: BorderSide(
//               color: Colors.red,
//               width: 2.5.w,
//             ),
//           ),
//           suffixIcon: Obx(() => hasInput.value
//               ? IconButton(
//                   icon: const Icon(Icons.close, color: MyColors.pink),
//                   onPressed: () => widget.controller.clear(),
//                 )
//               : const SizedBox()),
//         ),
//         onFieldSubmitted: (value) {
//           if (widget.nextNode != null) {
//             widget.nextNode?.requestFocus();
//           } else {
//             widget.focusNode.unfocus();
//           }
//         },
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         validator: widget.required
//             ? (value) {
//                 if (value?.isEmpty ?? false) {
//                   return widget.errorMessage;
//                 }
//                 return null;
//               }
//             : null,
//       ),
//     );
//   }
// }
