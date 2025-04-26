import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/rate_service.dart';

class DailyRateScreen extends StatefulWidget {
  const DailyRateScreen({super.key});

  @override
  State<DailyRateScreen> createState() => _DailyRateScreenState();
}

class _DailyRateScreenState extends State<DailyRateScreen> {
  DateTime selectedDate = DateTime.now();
  Map<String, dynamic>? rateData;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchRates();
  }

  Future<void> _fetchRates() async {
    setState(() => _isLoading = true);

    try {
      final data = await RateService.fetchRatesByDate(
        DateFormat('yyyy-MM-dd').format(selectedDate),
      );
      setState(() {
        rateData = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching rates: $e')),
      );
    }

    setState(() => _isLoading = false);
  }

  Widget _buildRateCard(String label, dynamic value) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
            Text(
              value != null ? value.toString() : "N/A",
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Metal Rates'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date: ${DateFormat('dd MMM yyyy').format(selectedDate)}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 20),
                    rateData != null
                        ? Expanded(
                            child: ListView(
                              children: [
                                _buildRateCard("Gold 24K", rateData!['gold24k']),
                                _buildRateCard("Gold 22K", rateData!['gold22k']),
                                _buildRateCard("Gold 20K", rateData!['gold20k']),
                                _buildRateCard("Gold 18K", rateData!['gold18k']),
                                _buildRateCard("Silver", rateData!['silver']),
                              ],
                            ),
                          )
                        : const Center(
                            child: Text(
                              "No rates available for this date.",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}
