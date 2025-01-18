import 'package:flutter/material.dart';
import 'dart:async';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  Timer? _timer;
  final Map<String, Map<String, dynamic>> modeData = {
    'Combat': {
      'color': const Color(0xFF019597),
      'image': 'assets/combat.png',
      'text': 'Combat',
      'duration': 2700,
    },
    'Focus': {
      'color': const Color(0xFFbd384b),
      'image': 'assets/focus.png',
      'text': 'Focus',
      'duration': 1500,
    },
    'Relax': {
      'color': const Color(0xFF54487E),
      'image': 'assets/relax.png',
      'text': 'Relax',
      'duration': 300,
    },
  };
    int _start = 0;

  @override
  void initState() {
    super.initState();
    _start = modeData['Combat']!['duration'];
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0)  {
      setState(() {
        _start--;
      });
      } else {
      setState(() {
        _timer?.cancel();
      });
      }
    });
    }

    void stopTimer() {
    setState(() {
      _timer?.cancel();
    });
    }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _showSettingsDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Settings'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Adjust Mode Durations',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ...modeData.keys.map((key) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          key,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setDialogState(() {
                                  setState(() {
                                    modeData[key]!['duration'] =
                                        (modeData[key]!['duration'] - 300).clamp(300, 10800);
                                    if (currentMode == key) {
                                      _start = modeData[key]!['duration'];
                                    }
                                  });
                                });
                              },
                              icon: const Icon(Icons.remove_circle, color: Colors.red),
                            ),
                            Text(
                              "${(modeData[key]!['duration'] ~/ 3600).toString().padLeft(2, '0')}:"
                              "${((modeData[key]!['duration'] % 3600) ~/ 60).toString().padLeft(2, '0')}:"
                              "${(modeData[key]!['duration'] % 60).toString().padLeft(2, '0')}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () {
                                setDialogState(() {
                                  setState(() {
                                    modeData[key]!['duration'] =
                                        (modeData[key]!['duration'] + 300).clamp(300, 10800);
                                    if (currentMode == key) {
                                      _start = modeData[key]!['duration'];
                                    }
                                  });
                                });
                              },
                              icon: const Icon(Icons.add_circle, color: Colors.green),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}


  // Current mode
  String currentMode = 'Combat';
  @override
  Widget build(BuildContext context) {
    final mode = modeData[currentMode]!;
    return Scaffold(
      backgroundColor: mode['color'],
      appBar: AppBar(title: Text(("${mode['text']} Mode")),
       actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showSettingsDialog, // Open the settings dialog
          ),
        ],),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             // Display image based on the mode
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 5),
              ),
              child: ClipOval(
              child: Image.asset(
                mode['image'],
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
                child: Text(
                '${(_start ~/ 3600).toString().padLeft(2, '0')}:${((_start % 3600) ~/ 60).toString().padLeft(2, '0')}:${(_start % 60).toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 48, color: Colors.white),
                ),
            ),
             const SizedBox(height: 20),
             Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey[200]!),
                color: Colors.grey[200],
              ),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: modeData.keys.map((key) {
                  final bool isSelected = key == currentMode; // Check if this is the selected mode
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentMode = key;
                        _start = modeData[key]!['duration'];
                      });
                      stopTimer();
                    },
                     style: ElevatedButton.styleFrom(
                      backgroundColor: modeData[key]!['color'],
                      elevation: isSelected ? 10 : 2, // Increase elevation for selected mode
                      shadowColor: isSelected ? modeData[key]!['color'] : Colors.transparent, // Add shadow with the mode color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Smooth rounded corners
                        side: isSelected
                            ? BorderSide(color: Colors.white, width: 2) // Add a subtle border for the selected mode
                            : BorderSide.none,
                      ),
                    ),
                      child: Text(
                        key,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500, // Bold text for selected
                          fontSize: isSelected ? 16 : 14, // Slightly larger text for selected
                        ),
                      ),
                  );
                }).toList(),
           ),
             ),
           const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              ElevatedButton(
                onPressed: () {
                  if (_timer == null || !_timer!.isActive) {
                    startTimer();
                  } else {
                    stopTimer();
                  }
                },
                style: ElevatedButton.styleFrom(
                   shadowColor:  Colors.transparent,
                  backgroundColor: Colors.amber,
                ),
                child: Icon(
                  _timer == null || !_timer!.isActive ? Icons.play_arrow : Icons.pause,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 5),
               ElevatedButton(
                        onPressed: () {
                          stopTimer();
                          setState(() {
                            _start = modeData[currentMode]!['duration'];
                          });
                        },
                         style: ElevatedButton.styleFrom(
                          shadowColor:  Colors.transparent,
                        ),
                        child: const Icon(Icons.restart_alt),
                      ),
            ],
          ),
      ],
        ),
      ),
    );
  }
}
