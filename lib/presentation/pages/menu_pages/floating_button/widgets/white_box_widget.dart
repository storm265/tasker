import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';

class WhiteBoxWidget extends StatelessWidget {
  final Widget child;
  final double height;
  final VoidCallback? onClick;
  final ScrollController? scrollController;
  const WhiteBoxWidget({
    Key? key,
    required this.child,
    this.scrollController,
    this.onClick,
    this.height = 470,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick == null ? FocusScope.of(context).unfocus() : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFDDDDDD).withOpacity(0.5),
                blurRadius: 9,
                offset: const Offset(3, 3),
              )
            ],
            borderRadius: BorderRadius.circular(5),
          ),
          child: DisabledGlowWidget(
            child: SingleChildScrollView(
              controller: scrollController,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';

// class WhiteBoxWidget extends StatelessWidget {
//   final Widget child;
//   final double height;
//   final double width;
//   final ScrollController? scrollController;
//   const WhiteBoxWidget({
//     Key? key,
//     required this.child,
//     this.scrollController,
//     this.width = 350,
//     this.height = 470,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Container(
//         margin: const EdgeInsets.only(left: 25, top: 10),
//         width: 350,
//         height: height,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: const [
//             BoxShadow(
//               color: Color(0xFFDDDDDD),
//               blurRadius: 9,
//               offset: Offset(3, 3),
//             )
//           ],
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: DisabledGlowWidget(
//           child: SingleChildScrollView(
//             controller: scrollController,
//             child: child,
//           ),
//         ),
//       ),
//     );
//   }
// }
