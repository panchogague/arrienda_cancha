import 'package:court_finder/modules/auth/services/services.dart';
import 'package:court_finder/modules/user/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      height: 200,
      child: Row(
        children: [
          const UserAvatar(
            width: 60,
            height: 60,
            showShadow: false,
            imgUrl:
                'https://www.eaglesvine.com/wp-content/uploads/2021/06/Gabbie-Carter_05.jpg',
          ),
          const SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                authService.userLogin!.firstName,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              const SizedBox(height: 10),
              Text(
                authService.userLogin!.email,
                style: const TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class HeaderDiagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    //Properties
    paint.color = const Color(0xff264653);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    //Draw
    final path = Path();
    path.moveTo(0, size.height * 0.35);
    path.lineTo(size.width, size.height * 0.30);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
