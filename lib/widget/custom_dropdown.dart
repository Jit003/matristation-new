import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class CustomDropdownWidget extends StatelessWidget {
  final List<String> items;
  final String selectedItem;
  final void Function(String?) onChanged;

  const CustomDropdownWidget({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownSearch<String>(
        items: items,
        selectedItem: selectedItem,
        onChanged: onChanged,
        popupProps: PopupProps.menu(
          showSearchBox: true,
          fit: FlexFit.loose,
          itemBuilder: (context, item, isSelected) {
            return ListTile(
              title: Text(
                item,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: isSelected ? Colors.pink : Colors.black,
                ),
              ),
            );
          },
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: const InputDecoration.collapsed(hintText: "Search .."),
        ),
      ),
    );
  }
}
