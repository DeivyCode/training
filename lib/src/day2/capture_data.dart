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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Apellido',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
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
                  onPressed: () {},
                  child: const Text('Enviar',
                      style: TextStyle(color: Colors.white))),
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
