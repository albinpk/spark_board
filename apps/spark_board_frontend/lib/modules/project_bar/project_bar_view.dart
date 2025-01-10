import '../../utils/common.dart';
import 'project_bar_state.dart';

class ProjectBarView extends CoraConsumerView<ProjectBarState> {
  const ProjectBarView({
    required this.projectId,
    super.key,
  });

  final String projectId;

  @override
  ProjectBarState createState() => ProjectBarState();

  @override
  Widget build(BuildContext context, ProjectBarState state) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          const Spacer(),

          // profile
          CustomDrop<int>(
            menuPadding: EdgeInsets.zero,
            childBuilder: (context, show) {
              return IconButton(
                onPressed: show,
                icon: const Icon(Icons.account_circle),
              );
            },
            onSelected: (value) async {
              if (value == 1) {
                await state.ref.storage.clear();
                if (!context.mounted) return;
                const LoginRoute().go(context);
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 1,
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}
