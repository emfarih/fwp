import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_view_model.dart';

class ChecklistItemTile extends StatelessWidget {
  final ChecklistItem item;
  final ChecklistViewModel viewModel;

  const ChecklistItemTile({
    required this.item,
    required this.viewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print(
        'ChecklistItemTile: Building tile for item ID: ${item.id}, Description: ${item.description}, Status: ${item.status}');

    return ListTile(
      title: Text(item.description ?? "No Description"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCheckbox('Pass', item.status == 'pass', Colors.green, (value) {
            viewModel.updateChecklistItemStatus(
                item.id!, value! ? 'pass' : null);
          }),
          _buildCheckbox('Fail', item.status == 'fail', Colors.red, (value) {
            viewModel.updateChecklistItemStatus(
                item.id!, value! ? 'fail' : null);
          }),
        ],
      ),
    );
  }

  Widget _buildCheckbox(String label, bool isChecked, Color color,
      ValueChanged<bool?>? onChanged) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: onChanged,
          activeColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Text(label),
      ],
    );
  }
}
