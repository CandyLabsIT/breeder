import 'package:breeder/views/pages/max_iv_slots/max_iv_slots_text_form.dart';
import 'package:flutter/material.dart';

class MaxIVSlotsTextFormsWidget extends StatelessWidget {
  const MaxIVSlotsTextFormsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 40),
            child: const MaxIVSlotsTextForm(
              indexTextEditingControllerList: 0,
              ivTextInfo: '1 IV',
              maxLength: 2,
              maxSlots: 32,
              inputWeight: 1,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: const MaxIVSlotsTextForm(
              indexTextEditingControllerList: 1,
              ivTextInfo: '2 IVs',
              maxLength: 2,
              maxSlots: 16,
              inputWeight: 2,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: const MaxIVSlotsTextForm(
              indexTextEditingControllerList: 2,
              ivTextInfo: '3 IVs',
              maxLength: 1,
              maxSlots: 8,
              inputWeight: 4,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: const MaxIVSlotsTextForm(
              indexTextEditingControllerList: 3,
              ivTextInfo: '4 IVs',
              maxLength: 1,
              maxSlots: 4,
              inputWeight: 8,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const MaxIVSlotsTextForm(
              indexTextEditingControllerList: 4,
              ivTextInfo: '5 IVs',
              maxLength: 1,
              maxSlots: 2,
              inputWeight: 16,
            ),
          )
        ],
      ),
    );
  }
}
