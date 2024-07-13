import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SearchableDropdown extends StatefulWidget {
  late List<String> listItems;
  late String addTitle;
  late String labelTitle;
  late String hintSearchText;
  late String hintAddText;
  late TextEditingController dataController;
  late String errorText;

  SearchableDropdown({
    super.key,
    required this.listItems,
    required this.labelTitle,
    required this.addTitle,
    required this.hintSearchText,
    required this.hintAddText,
    required this.dataController,
    required this.errorText,
  });

  @override
  State<SearchableDropdown> createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  late List<String> listItems;
  late String addTitle;
  late String labelTitle;
  late String hintSearchText;
  late String hintAddText;
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    listItems = widget.listItems;
    addTitle = widget.addTitle;
    labelTitle = widget.labelTitle;
    hintSearchText = widget.hintSearchText;
    hintAddText = widget.hintAddText;
    selectedItem = widget.dataController.text.isNotEmpty ? widget.dataController.text : null;

    widget.dataController.addListener(_handleControllerChange);
  }

  @override
  void dispose() {
    widget.dataController.removeListener(_handleControllerChange);
    super.dispose();
  }

  void _handleControllerChange() {
    if (widget.dataController.text.isEmpty && selectedItem != null) {
      setState(() {
        selectedItem = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelTitle,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        DropdownSearch<String>(
          items: listItems,
          onChanged: (value) {
            setState(() {
              selectedItem = value;
              widget.dataController.text = value ?? '';
            });
          },
          selectedItem: selectedItem,
          popupProps: PopupProps.menu(
            showSelectedItems: true,
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: hintSearchText,
                errorText: widget.errorText.isEmpty ? null : widget.errorText,
              ),
            ),
            itemBuilder: (context, item, isSelected) {
              return ListTile(
                title: Text(item),
              );
            },
            emptyBuilder: (context, searchEntry) {
              return Center(
                child: TextButton(
                  onPressed: () async {
                    final newItem = await _showAddNewStatusDialog(context);
                    if (newItem != null && newItem.isNotEmpty) {
                      setState(() {
                        listItems.add(newItem);
                        selectedItem = newItem;
                        widget.dataController.text = newItem;
                      });
                    }
                  },
                  child: Text(addTitle),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<String?> _showAddNewStatusDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(addTitle),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: hintAddText),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
