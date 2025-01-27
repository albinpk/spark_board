import '../utils/common.dart';

/// Widget that sets the title of the web app.
class WebTitle extends StatelessWidget {
  const WebTitle({
    required this.child,
    required this.title,
    super.key,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Title(
      color: Colors.white,
      title: '$title | SparkBoard',
      child: child,
    );
  }
}
