import '../../utils/common.dart';
import 'project_bar_state.dart';
import 'widgets/profile_card.dart';
import 'widgets/project_info.dart';

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
          IconButton(
            tooltip: 'Info',
            onPressed: () => _showInfo(context),
            icon: const Icon(Icons.info_outline),
          ),

          const _ProfileIcon(),
        ],
      ),
    );
  }

  void _showInfo(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return const Dialog(
          child: ProjectInfo(),
        );
      },
    );
  }
}

class _ProfileIcon extends StatefulWidget {
  const _ProfileIcon();

  @override
  State<_ProfileIcon> createState() => _ProfileIconState();
}

class _ProfileIconState extends State<_ProfileIcon> {
  final _controller = OverlayPortalController();
  final _layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: OverlayPortal(
        controller: _controller,
        overlayChildBuilder: (context) {
          return CompositedTransformFollower(
            link: _layerLink,
            followerAnchor: Alignment.topRight,
            targetAnchor: Alignment.bottomLeft,
            child: Align(
              alignment: Alignment.topRight,
              child: TapRegion(
                onTapOutside: (_) => _controller.hide(),
                child: const ProfileCard(),
              ),
            ),
          );
        },
        child: IconButton(
          onPressed: _controller.show,
          icon: const Icon(Icons.account_circle),
        ),
      ),
    );
  }
}
