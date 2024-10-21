import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ColorPickerScreen(),
    );
  }
}

class ColorPickerScreen extends StatefulWidget {
  @override
  _ColorPickerScreenState createState() => _ColorPickerScreenState();
}

class _ColorPickerScreenState extends State<ColorPickerScreen> {
  Color seedColor = Colors.blue; // 初始种子色

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Theme Color'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => pickColor(context),
          child: Text('Pick Seed Color'),
        ),
      ),
    );
  }

  void pickColor(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ColorPicker(
          initialColor: seedColor,
          onColorChanged: (color) {
            setState(() {
              seedColor = color;
            });
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}

class ColorPicker extends StatefulWidget {
  final Color initialColor;
  final ValueChanged<Color> onColorChanged;

  ColorPicker({required this.initialColor, required this.onColorChanged});

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late HSVColor hsvColor;

  @override
  void initState() {
    super.initState();
    hsvColor = HSVColor.fromColor(widget.initialColor);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Pick a color',
            style: TextStyle(fontSize: 24),
          ),
        ),
        Slider(
          value: hsvColor.hue,
          min: 0.0,
          max: 360.0,
          onChanged: (value) {
            setState(() {
              hsvColor = hsvColor.withHue(value);
            });
          },
        ),
        Slider(
          value: hsvColor.saturation,
          min: 0.0,
          max: 1.0,
          onChanged: (value) {
            setState(() {
              hsvColor = hsvColor.withSaturation(value);
            });
          },
        ),
        Slider(
          value: hsvColor.value,
          min: 0.0,
          max: 1.0,
          onChanged: (value) {
            setState(() {
              hsvColor = hsvColor.withValue(value);
            });
          },
        ),
        ElevatedButton(
          onPressed: () {
            widget.onColorChanged(hsvColor.toColor());
          },
          child: Text('Done'),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
