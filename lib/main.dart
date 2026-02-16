import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Selector',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const WidgetDemo(),
    );
  }
}

class WidgetDemo extends StatefulWidget {
  const WidgetDemo({super.key});

  @override
  State<WidgetDemo> createState() => _WidgetDemoState();
}

class _WidgetDemoState extends State<WidgetDemo> {
  String _selectedCountry = 'Rwanda';
  
  // DropDown prop 1
  bool _isExpanded = false;
  
  // DropDown prop 2
  double _iconSize = 24.0;
  
  // DropDown prop 3
  Color _dropdownColor = Colors.white;

  final List<String> _countries = ['Rwanda', 'Kenya', 'Nigeria', 'Ghana'];
  final List<Color> _colorOptions = [Colors.white, Colors.yellow, Colors.lightBlue, Colors.lightGreen];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: const Text('Country Selector'),
        centerTitle: true,
        actions: [
          // IconButton usage
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isExpanded = false;
                _iconSize = 24.0;
                _dropdownColor = Colors.white;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Your Country',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            const SizedBox(height: 4),
            const Text('Choose from the available options below:', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),

            // DropdownButton with 3 properties
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.indigo, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: _selectedCountry,
                isExpanded: _isExpanded,       // DropDown prop 1
                iconSize: _iconSize,           // DropDown prop 2
                dropdownColor: _dropdownColor, // DropDown prop 3
                underline: const SizedBox(),
                items: _countries.map((country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedCountry = value!),
              ),
            ),
            const SizedBox(height: 12),
            Text('Selected: $_selectedCountry', style: const TextStyle(fontWeight: FontWeight.w500)),

            const Divider(height: 32),

            const Text(
              'Customize Appearance',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            const SizedBox(height: 12),

            // Property 1: isExpanded
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Expand Selector', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Default: false | Current: $_isExpanded', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                    const Text('Makes the dropdown fill all available horizontal space.', style: TextStyle(fontSize: 12)),
                    const Text('Useful for consistent width in forms.', style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Colors.grey)),
                    Switch(
                      value: _isExpanded,
                      onChanged: (val) => setState(() => _isExpanded = val),
                    ),
                  ],
                ),
              ),
            ),

            // Property 2: iconSize
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Icon Size', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Default: 24.0 | Current: ${_iconSize.toInt()}.0', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                    const Text('Controls the size of the dropdown arrow icon.', style: TextStyle(fontSize: 12)),
                    const Text('Increase for better visibility on larger screens.', style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Colors.grey)),
                    Slider(
                      value: _iconSize,
                      min: 16,
                      max: 48,
                      divisions: 8,
                      label: '${_iconSize.toInt()}',
                      onChanged: (val) => setState(() => _iconSize = val),
                    ),
                  ],
                ),
              ),
            ),

            // Property 3: dropdownColor
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Dropdown Background Color', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Default: white | Current: ${_getColorName(_dropdownColor)}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                    const Text('Sets the background color of the dropdown menu.', style: TextStyle(fontSize: 12)),
                    const Text('Match your app theme or highlight important selections.', style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Colors.grey)),
                    const SizedBox(height: 8),
                    Row(
                      children: _colorOptions.map((color) {
                        return GestureDetector(
                          onTap: () => setState(() => _dropdownColor = color),
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: color,
                              border: Border.all(
                                color: _dropdownColor == color ? Colors.indigo : Colors.grey,
                                width: _dropdownColor == color ? 3 : 1,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
