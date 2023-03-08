import 'package:flutter/material.dart';
import 'dart:math' as math;

// 五角星widget
class Pentagon extends StatelessWidget {
  final double size;
  final Color color;
  Widget? child;

  Pentagon({
    super.key,
    this.size = 100,
    this.color = Colors.blue,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _PentagonClipper(),
      child: child,
    );
  }
}

class _PentagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path(); // 创建一个空的 Path 对象
    double width = size.width; // 获取传入的 Size 对象的宽度
    double height = size.height; // 获取传入的 Size 对象的高度
    // 计算半径，使用 math.min 函数获取 width 和 height 中较小的值，并除以 2
    double radius = math.min(width, height) / 2;
    double centerX = width / 2; // 计算中心点的 x 坐标
    double centerY = height / 2; // 计算中心点的 y 坐标
    /// 在这行代码中，2 * math.pi / 5 的作用是计算五边形的内角大小。
    /// 其中 math.pi 表示圆周率，2 * math.pi 表示一个完整的圆周角（360度），
    /// 而 / 5 则表示将圆周角等分为五个部分，即五边形的五个内角大小都相等。
    /// 因此，2 * math.pi / 5 的结果就是每个内角的大小。
    /// 乘以2的原因是因为计算机中通常使用弧度来表示角度，而不是度数。
    /// 弧度是一种角度度量方式，它表示圆周上的弧长与半径之比。
    /// 一个完整的圆周角对应的弧长是半径的2倍，因此将每个内角的弧度大小乘以2可以得到相应的圆周角度数大小。
    /// 这个圆周角度数的值可以作为 math.cos 和 math.sin 等三角函数的参数，用于计算五边形的顶点坐标。
    double angle = 2 * math.pi / 5; // 计算角度，这里使用的是弧度制，math.pi 是圆周率，除以 5 表示五边形
    /**
     * 这一行代码是在 Path 对象中设置起点的位置。
     * moveTo 方法将路径的起始点移动到指定的坐标位置。
     * 具体来说，这一句代码中，centerX 和 centerY 分别表示五边形的中心点的横纵坐标，radius 表示五边形的半径。
     * 而 math.cos(0) 和 math.sin(0) 则分别表示正弦函数和余弦函数在角度为 0 时的值，即 1 和 0。
     * 因此，这一句代码的作用是将起点移动到五边形的顶点之一，即中心点加上一个半径的距离，
     * 这个距离的横坐标和纵坐标分别为 radius * math.cos(0) 和 radius * math.sin(0)，也就是 (radius, 0) 的坐标。
     * 这个顶点的具体位置取决于五边形的半径和中心点的位置。
    */
    path.moveTo(centerX + radius * math.cos(0),
        centerY + radius * math.sin(0)); // 将起始点移动到五边形的顶点，使用三角函数计算坐标
    for (int i = 1; i <= 5; i++) {
      // 循环 5 次，画出五边形的每条边
      path.lineTo(centerX + radius * math.cos(angle * i),
          centerY + radius * math.sin(angle * i)); // 从当前点画一条线到下一个点，使用三角函数计算坐标
    }
    path.close(); // 关闭路径，将最后一个点与第一个点连接起来
    return path; // 返回 Path 对象
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
