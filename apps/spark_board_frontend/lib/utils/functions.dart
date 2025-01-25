import 'common.dart';

/// Show confirmation dialog.
Future<bool> confirmDialog({
  required BuildContext context,
  required String description,
  String? confirmText,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(description),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Cancel'),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: context.cs.error,
                ),
                onPressed: () => context.pop<bool>(true),
                child: Text(
                  confirmText ?? 'Yes',
                  style: TextStyle(
                    color: context.cs.onError,
                  ),
                ),
              ),
            ],
          );
        },
      ) ??
      false;
}
