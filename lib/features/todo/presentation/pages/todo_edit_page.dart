import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pepper_cloud_test/core/di/di_container.dart';
import 'package:pepper_cloud_test/features/todo/domain/entities/todo.dart';
import 'package:pepper_cloud_test/features/todo/presentation/blocs/edit_todo/edit_todo_bloc.dart';

class EditTodoPage extends StatelessWidget {
  const EditTodoPage({super.key});

  static Route<void> route({Todo? initialTodo}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) =>
            sl<EditTodoBloc>()..add(EditTodoAddInitial(todo: initialTodo)),
        child: const EditTodoPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isNewTodo = context.select(
      (EditTodoBloc bloc) => bloc.state.isNewTodo,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewTodo ? "Add Todo" : "Edit Todo",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        onPressed: () {
          context.read<EditTodoBloc>().add(const EditTodoSubmitted());
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.check_rounded),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TitleField(),
            _DescriptionField(),
          ],
        ),
      ),
    );
  }
}

class _TitleField extends StatefulWidget {
  const _TitleField();

  @override
  State<_TitleField> createState() => _TitleFieldState();
}

class _TitleFieldState extends State<_TitleField> {
  final TextEditingController _controller = TextEditingController(text: "");

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditTodoBloc, EditTodoState>(
      listener: (context, state) {
        if (_controller.text.isEmpty) {
          _controller.text = state.initialTodo?.title ?? '';
        }
      },
      builder: (context, state) {
        return EditingTextField(
          controller: _controller,
          enabled: !state.status.isLoadingOrSuccess,
          hintText: state.initialTodo?.description ?? "",
          keyStr: "editTodoView_title_textFormField",
          label: "Title",
          onChanged: (value) {
            context.read<EditTodoBloc>().add(EditTodoTitleChanged(value));
          },
        );
      },
    );
  }
}

class _DescriptionField extends StatefulWidget {
  const _DescriptionField();

  @override
  State<_DescriptionField> createState() => _DescriptionFieldState();
}

class _DescriptionFieldState extends State<_DescriptionField> {
  final TextEditingController _controller = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditTodoBloc, EditTodoState>(
      listener: (context, state) {
        if (_controller.text.isEmpty) {
          _controller.text = state.initialTodo?.description ?? '';
        }
      },
      builder: (context, state) {
        return EditingTextField(
          controller: _controller,
          enabled: !state.status.isLoadingOrSuccess,
          hintText: state.description,
          keyStr: "description-field",
          label: "Description",
          maxLength: 300,
          maxLines: 4,
          onChanged: (value) => context
              .read<EditTodoBloc>()
              .add(EditTodoDescriptionChanged(value)),
        );
      },
    );
  }
}

class EditingTextField extends StatelessWidget {
  const EditingTextField({
    super.key,
    required TextEditingController controller,
    required this.enabled,
    required this.hintText,
    required this.label,
    required this.keyStr,
    required this.onChanged,
    this.maxLines,
    this.maxLength,
  }) : _controller = controller;

  final TextEditingController _controller;
  final bool enabled;
  final String hintText;
  final String label;
  final String keyStr;
  final int? maxLines;
  final int? maxLength;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key(keyStr),
      controller: _controller,
      decoration: InputDecoration(
          enabled: enabled,
          labelText: label,
          hintText: hintText,
          border: const OutlineInputBorder()),
      maxLength: maxLength ?? 100,
      maxLines: maxLines ?? 2,
      onChanged: onChanged,
    );
  }
}
