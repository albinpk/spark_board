import 'package:url_launcher/url_launcher_string.dart';

import '../../../providers/package_info_provider.dart';
import '../../../utils/common.dart';

class ProjectInfo extends ConsumerWidget {
  const ProjectInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 400,
      child: ref.watch(packageInfoProvider).when(
            error: (error, stackTrace) => const SizedBox.shrink(),
            loading: SizedBox.shrink,
            data: (data) {
              return Padding(
                padding: const EdgeInsets.all(Margin.xxLarge * 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'SparkBoard',
                      style: context.titleLarge,
                    ),

                    // version
                    Text('v${data.version}'),
                    H.large,

                    const Text('Created and maintained by Albin'),
                    H.large,

                    // links
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: linkedinUrl,
                          onPressed: () async {
                            if (!await launchUrlString(linkedinUrl)) {
                              AppSnackbar.warning('Could not open link');
                            }
                          },
                          icon: const FaIcon(FontAwesomeIcons.linkedin),
                        ),
                        W.large,
                        IconButton(
                          tooltip: sparkBoardRepoUrl,
                          onPressed: () async {
                            if (!await launchUrlString(sparkBoardRepoUrl)) {
                              AppSnackbar.warning('Could not open link');
                            }
                          },
                          icon: const FaIcon(FontAwesomeIcons.squareGithub),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }
}
