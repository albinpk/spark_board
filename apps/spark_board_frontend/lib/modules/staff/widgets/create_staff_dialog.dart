import '../../../services/api/models/staffs_response.dart';
import '../../../utils/common.dart';

typedef CreateStaffDialogResult = ({String name, String email});

/// This dialog will pop with a [CreateStaffDialogResult] object.
class CreateStaffDialog extends StatefulWidget {
  const CreateStaffDialog({
    super.key,
    this.staff,
  });

  final StaffResponse? staff;

  @override
  State<CreateStaffDialog> createState() => _CreateStaffDialogState();
}

class _CreateStaffDialogState extends State<CreateStaffDialog> {
  late final _nameController = TextEditingController(
    text: widget.staff?.name,
  );
  late final _emailController = TextEditingController(
    text: widget.staff?.email,
  );

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
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
                      widget.staff == null ? 'Create staff' : 'Update staff',
                      style: context.titleSmall,
                    ),
                  ),
                  const CloseButton(),
                ],
              ),
              H.xxLarge,

              // name
              TextFormField(
                controller: _nameController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(3),
                ]),
              ),
              H.xxLarge,

              // description
              TextFormField(
                controller: _emailController,
                enabled: widget.staff == null,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              H.xxLarge,

              // create button
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: _onSave,
                  child: Text(widget.staff == null ? 'Create' : 'Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSave() {
    final form = _formKey.currentState!..save();
    if (!form.validate()) return;
    context.pop<CreateStaffDialogResult>(
      (
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
      ),
    );
  }
}
