import '../../../utils/common.dart';

typedef CreateProjectDialogResult = ({String name, String? description});

/// This dialog will pop with a [CreateProjectDialogResult] object.
class CreateProjectDialog extends StatefulWidget {
  const CreateProjectDialog({
    super.key,
  });

  @override
  State<CreateProjectDialog> createState() => _CreateProjectDialogState();
}

class _CreateProjectDialogState extends State<CreateProjectDialog> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Padding(
        padding: const EdgeInsets.all(Margin.xLarge),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Create project',
                      style: context.titleSmall,
                    ),
                  ),

                  // close button
                  CloseButton(onPressed: () => context.pop()),
                ],
              ),
              H.xxLarge,

              // name
              TextFormField(
                controller: _nameController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Project name',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(3),
                ]),
              ),
              H.xxLarge,

              // description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                ),
                maxLines: 4,
              ),
              H.xxLarge,

              // create button
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: _onCreate,
                  child: const Text('Create'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onCreate() {
    final form = _formKey.currentState!..save();
    if (!form.validate()) return;
    context.pop<CreateProjectDialogResult>(
      (
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().nullIfEmpty,
      ),
    );
  }
}
