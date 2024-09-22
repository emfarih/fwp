import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fwp/features/clm/domain/use_cases/get_checklist_use_case.dart'; // Import the use case
import 'package:fwp/features/clm/data/models/checklist.dart';

class ChecklistDetailScreen extends StatefulWidget {
  const ChecklistDetailScreen({super.key});

  @override
  _ChecklistDetailScreenState createState() => _ChecklistDetailScreenState();
}

class _ChecklistDetailScreenState extends State<ChecklistDetailScreen> {
  late Future<Checklist> _checklist;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final checklistId = ModalRoute.of(context)?.settings.arguments as int?;
    if (checklistId != null) {
      _checklist = Provider.of<GetChecklistUseCase>(context, listen: false)
          .executeById(checklistId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checklist Details')),
      body: FutureBuilder<Checklist>(
        future: _checklist,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found.'));
          }

          final checklist = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location: ${checklist.stationId ?? 'Unknown'}',
                    style: Theme.of(context).textTheme.titleLarge),
                Text(
                    'Inspection Date: ${checklist.date?.toLocal() ?? 'Unknown'}'),
                // Add more details here...
              ],
            ),
          );
        },
      ),
    );
  }
}
