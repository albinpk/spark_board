import '../../utils/common.dart';
import 'project_bar_state.dart';
import 'widgets/profile_card.dart';

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
    return const SizedBox(
      height: 40,
      child: Row(
        children: [
          Spacer(),

          // profile
          _ProfileIcon(),
        ],
      ),
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
