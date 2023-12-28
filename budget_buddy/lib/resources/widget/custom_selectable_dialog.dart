import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/resources/widget/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class CustomSelectableDialog<T> extends StatefulWidget {
  final List<Option<T>> options;

  final Function(T?) onOptionSelect;

  final T initializeValue;

  const CustomSelectableDialog(
      {required this.options,
      required this.initializeValue,
      required this.onOptionSelect,
      Key? key})
      : super(key: key);

  @override
  State<CustomSelectableDialog<T>> createState() =>
      _CustomSelectableDialogState<T>();
}

class _CustomSelectableDialogState<T> extends State<CustomSelectableDialog<T>> {
  T? currentOptionValue;

  @override
  void initState() {
    super.initState();
    currentOptionValue = widget.initializeValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.v)),
      contentPadding: EdgeInsets.symmetric(vertical: 8.v),
      content: SizedBox(
        height: 180.v,
        width: double.maxFinite,
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List<Widget>.generate(
              widget.options.length,
              (index) => RadioListTile(
                    value: widget.options[index].value,
                    groupValue: currentOptionValue,
                    onChanged: selectNewValue,
                    title: Text(
                      widget.options[index].title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  )),
        ),
      ),
      actions: [
        CustomElevatedButton(
          width: 70.h,
          text: "OK",
          onPressed: () {
            widget.onOptionSelect(currentOptionValue);
            Navigator.pop(context);
          },
        ),
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text(
            AppLocalizations.of(context)!.cancel_btn,
            style: Theme.of(context).textTheme.labelLarge,
          )),
      ],
    );
  }

  void selectNewValue(T? value) {
    setState(() {
      currentOptionValue = value;
    });
  }
}

class Option<T> {
  final String title;
  final T value;
  Option(this.title, this.value);
}
