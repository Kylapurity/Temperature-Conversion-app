import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
        // Adding a decorative line under the header
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Divider(
            color: Colors.blueAccent,
            thickness: 2,
          ),
        ),
      ),
      body: const TempConverter(),
    ),
  ));
}

class TempConverter extends StatefulWidget {
  const TempConverter({super.key});

  @override
  TempConverterState createState() => TempConverterState();
}

class TempConverterState extends State<TempConverter> {
  String _temp = '';
  String _result = '';
  String _history = '';
  String _conversion = 'F to C';
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose(); // Dispose controller on widget removal
    super.dispose();
  }

  void _onPressed() {
    setState(() {
      _temp = _controller.text;

      // Validate user input
      if (_temp.isEmpty || double.tryParse(_temp) == null) {
        _result = 'Invalid input';
        return;
      }

      // Perform conversion based on selected option
      if (_conversion == 'F to C') {
        _result = ((double.parse(_temp) - 32) * 5 / 9).toStringAsFixed(2);
        _history = 'F to C: $_temp => $_result\n$_history'; // Use interpolation
      } else {
        _result = (double.parse(_temp) * 9 / 5 + 32).toStringAsFixed(2);
        _history = 'C to F: $_temp => $_result\n$_history';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF42A5F5), Color(0xFF1976D2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Select Conversion Type:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          DropdownButton<String>(
            value: _conversion,
            onChanged: (String? newValue) {
              setState(() {
                _conversion = newValue!;
              });
            },
            items: const <String>['F to C', 'C to F']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter temperature',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _onPressed,
              child: const Text('Convert'),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Result: $_result',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text(
            'History:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                _history,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
