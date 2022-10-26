import 'package:flutter/material.dart';

class CaptureData extends StatefulWidget {
  const CaptureData({super.key});

  @override
  State<CaptureData> createState() => _CaptureDataState();
}

class _CaptureDataState extends State<CaptureData> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _nameControllerForm = TextEditingController();
  final _lastNameControllerForm = TextEditingController();
  final _ageControllerForm = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _nameControllerForm.dispose();
    _lastNameControllerForm.dispose();
    _ageControllerForm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Captura de datos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Captura de datos usando TextFields",
                style: Theme.of(context).textTheme.headline6,
              ),
              _TextFields(
                nameController: _nameController,
                lastNameController: _lastNameController,
                ageController: _ageController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text("Captura de datos usando Form",
                    style: Theme.of(context).textTheme.headline6),
              ),
              _MyForm(
                  formKey: _formKey,
                  nameController: _nameControllerForm,
                  lastNameController: _lastNameControllerForm,
                  ageController: _ageControllerForm),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextFields extends StatefulWidget {
  const _TextFields(
      {required this.nameController,
      required this.lastNameController,
      required this.ageController});
  final TextEditingController nameController;
  final TextEditingController lastNameController;
  final TextEditingController ageController;

  @override
  State<_TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<_TextFields> {
  bool _nameIsInvalid = false;

  bool _lasNameIsInvalid = false;

  bool _ageIsInvalid = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: widget.nameController,
            decoration: InputDecoration(
              errorText: _nameIsInvalid ? "Nombre inválido" : null,
              border: const OutlineInputBorder(),
              labelText: 'Nombre',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: widget.lastNameController,
            decoration: InputDecoration(
              errorText: _lasNameIsInvalid ? 'Apellido inválido' : null,
              border: const OutlineInputBorder(),
              labelText: 'Apellido',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: widget.ageController,
            decoration: InputDecoration(
              errorText: _ageIsInvalid ? "Edad inválida" : null,
              border: const OutlineInputBorder(),
              labelText: 'Edad',
            ),
          ),
        ),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xFF6750A4)),
              minimumSize: MaterialStateProperty.all(const Size(200, 50)),
            ),
            onPressed: () => _validate(),
            child: const Text('Enviar', style: TextStyle(color: Colors.white))),
      ],
    );
  }

  void _validate() {
    setState(() {
      _nameIsInvalid = widget.nameController.text.isEmpty;
      _lasNameIsInvalid = widget.lastNameController.text.isEmpty;
      _ageIsInvalid = widget.ageController.text.isEmpty;
    });
    // show a snackbar with the data
    if (!_nameIsInvalid && !_lasNameIsInvalid && !_ageIsInvalid) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "Nombre: ${widget.nameController.text} ${widget.lastNameController.text} Edad: ${widget.ageController.text}"),
      ));
    }
  }
}

class _MyForm extends StatelessWidget {
  const _MyForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
    required TextEditingController lastNameController,
    required TextEditingController ageController,
  })  : _formKey = formKey,
        _nameController = nameController,
        _lastNameController = lastNameController,
        _ageController = ageController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _nameController;
  final TextEditingController _lastNameController;
  final TextEditingController _ageController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu nombre';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Apellido',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu apellido';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Edad',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu edad';
                }
                return null;
              },
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFF6750A4)),
                minimumSize: MaterialStateProperty.all(const Size(200, 50)),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Procesando datos')),
                  );
                }
              },
              child:
                  const Text('Enviar', style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}
