import '../../../../export.dart';

class FormLabelAddress extends StatefulWidget {
  const FormLabelAddress(
      {super.key,
      required this.text,
      required this.label,
      this.viewForm = false,
      this.onChanged,
      this.isCompleted = false});
  final String text;
  final String label;
  final bool viewForm;
  final bool isCompleted;
  final Function(String)? onChanged;

  @override
  State<FormLabelAddress> createState() => _FormLabelAddressState();
}

class _FormLabelAddressState extends State<FormLabelAddress> {
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    if (widget.viewForm) {
      addressController = TextEditingController();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.viewForm) {
      addressController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "${widget.label} ",
                style: PrimaryFont.instance.copyWith(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              TextSpan(
                text: "(*)",
                style: PrimaryFont.instance.copyWith(
                  fontSize: 16.0,
                  color: errorColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              widget.isCompleted
                  ? const WidgetSpan(
                      child: Icon(Icons.check_circle, color: successfullyColor))
                  : const TextSpan(
                      text: "",
                    ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        !widget.viewForm
            ? DecoratedBox(
                decoration: BoxDecoration(
                  color: lightColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.2),
                      blurRadius: 7.0,
                    )
                  ],
                ),
                child: SizedBox(
                  height: 45.0,
                  width: double.maxFinite,
                  child: ListTile(
                    dense: true,
                    horizontalTitleGap: 0.0,
                    leading: const Icon(Icons.location_city),
                    title: Text(
                      widget.text,
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_drop_down),
                  ),
                ),
              )
            : DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.2),
                      blurRadius: 7.0,
                    )
                  ],
                ),
                child: TextFormField(
                  controller: addressController,
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: widget.text,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: horizontalPadding / 2),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                  ),
                  onChanged: (value) => widget.onChanged!(value),
                  maxLines: 3,
                ),
              )
      ],
    );
  }
}
