import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/rate_service.dart';

class RateEntryScreen extends StatefulWidget {
  const RateEntryScreen({super.key});

  @override
  State<RateEntryScreen> createState() => _RateEntryScreenState();
}

class _RateEntryScreenState extends State<RateEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _gold24kController = TextEditingController();
  final TextEditingController _gold22kController = TextEditingController();
  final TextEditingController _gold20kController = TextEditingController();
  final TextEditingController _gold18kController = TextEditingController();
  final TextEditingController _silverController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _gold24kController.dispose();
    _gold22kController.dispose();
    _gold20kController.dispose();
    _gold18kController.dispose();
    _silverController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _submitRates() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      try {
        final success = await RateService.updateRates(
          date: DateFormat('dd/MM/yyyy').format(selectedDate),
          gold24k: double.parse(_gold24kController.text),
          gold22k: double.parse(_gold22kController.text),
          gold20k: double.parse(_gold20kController.text),
          gold18k: double.parse(_gold18kController.text),
          silver: double.parse(_silverController.text),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success
                ? '✅ Rates updated successfully!'
                : '❌ Failed to update rates.'),
          ),
        );

        if (success) {
          _gold24kController.clear();
          _gold22kController.clear();
          _gold20kController.clear();
          _gold18kController.clear();
          _silverController.clear();
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }

      setState(() {
        _isSubmitting = false;
      });
    }
  }

  Widget _buildRateField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) return 'Enter $label rate';
          if (double.tryParse(value) == null) return 'Enter a valid number';
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Today\'s Rates')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "Selected Date: ${DateFormat('dd/MM/yyyy').format(selectedDate)}",
                ),
                trailing: ElevatedButton(
                  onPressed: _pickDate,
                  child: const Text("Pick Date"),
                ),
              ),
              const SizedBox(height: 16),
              _buildRateField("Gold 24K", _gold24kController),
              _buildRateField("Gold 22K", _gold22kController),
              _buildRateField("Gold 20K", _gold20kController),
              _buildRateField("Gold 18K", _gold18kController),
              _buildRateField("Silver", _silverController),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitRates,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: _isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Submit Rates",
                        style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 12),
              const Text(
                "⚠️ Rates are valid from 11:00 AM to 11:00 PM",
                style: TextStyle(
                    color: Colors.orange, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
