import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/quotes/quotes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyQuote extends StatefulWidget {
  const DailyQuote({super.key});

  @override
  State<DailyQuote> createState() => _DailyQuoteState();
}

class _DailyQuoteState extends State<DailyQuote> {
  late int currentDay;
  late int quoteIndex;
  late Map<String, String> currentQuote;

  Future<void> _getQuoteOfTheDay() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the current day as an integer (e.g., 1 for Monday, 2 for Tuesday, etc.)
    final int today = DateTime.now().day;

    // Get the stored day number and quote index
    final int? storedDay = prefs.getInt('quoteDay');
    final int? storedIndex = prefs.getInt('quoteIndex');

    if (storedDay == today && storedIndex != null) {
      // If the stored day matches today's date, use the stored index
      setState(() {
        quoteIndex = storedIndex;
        currentDay = today;
      });
    } else {
      // If the stored day does not match today's date, generate a new index
      final Random random = Random();
      final int randomIndex = random.nextInt(quotes.length);

      setState(() {
        quoteIndex = randomIndex;
        currentDay = today;
      });

      // Save the new index and day number to SharedPreferences
      await prefs.setInt('quoteDay', currentDay);
      await prefs.setInt('quoteIndex', quoteIndex);
    }
  }

  @override
  void initState() {
    super.initState();
    _getQuoteOfTheDay();
  }

  @override
  Widget build(BuildContext context) {
    currentQuote = quotes[quoteIndex];

    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Padding(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    '“',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 45, color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                Expanded(
                    flex: 9,
                    child: Column(
                      children: [
                        Text(
                          "${currentQuote["quote"]}",
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "- ${currentQuote["author"]}",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground),
                        ),
                      ],
                    )),
                Expanded(
                  child: Text(
                    '”',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 45, color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ])),
    );
  }
}
