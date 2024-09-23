import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/checklist_item.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_detail_view_model.dart';

class ChecklistItemTile extends StatelessWidget {
  final ChecklistItem checklistItem;
  final ChecklistDetailViewModel viewModel;

  const ChecklistItemTile({
    required this.checklistItem,
    required this.viewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print(
        'ChecklistItemTile: Building tile for item ID: ${checklistItem.id}, Description: ${checklistItem.description}, Status: ${checklistItem.status}');

    return ListTile(
      title: Text(checklistItem.description ?? "No Description"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCheckbox('Pass', checklistItem.status == 'pass', Colors.green,
              (value) {
            viewModel.updateChecklistItemStatus(
                checklistItem.id!, value! ? 'pass' : null);
          }),
          _buildCheckbox('Fail', checklistItem.status == 'fail', Colors.red,
              (value) {
            viewModel.updateChecklistItemStatus(
                checklistItem.id!, value! ? 'fail' : null);
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
