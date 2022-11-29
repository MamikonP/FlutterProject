// ignore_for_file: avoid_dynamic_calls

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../data/data_sources/local/shared_preferences.dart';
import '../../../data/settings_constants.dart';
import '../../../services/app_service.dart';
import '../../bloc/settings/settings_bloc.dart';
import '../../bloc/settings/theme_mode/theme_mode_bloc.dart';
import '../../shared/widgets.dart';

class AppSettings extends StatelessWidget with AppColors, AppGaps {
  AppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    late Map<String, int> settingsModel;
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (BuildContext context, SettingsState state) {
        if (state is SettingsInitial) {
          settingsModel = state.settingsModel;
        } else if (state is SettingsUpdated) {
          settingsModel = state.settingsModel;
        }
        return BaseAppLayout(
          imagePath: 'assets/images/profile.pdf',
          maxHeightHeaderPercent: 0.2,
          imageAlignment: Alignment.topCenter,
          bodyPadding: EdgeInsets.zero,
          children: context
              .read<SettingsBloc>()
              .toggles
              .entries
              .map((MapEntry<String, dynamic> e) {
            final String title = e.key;
            final List<dynamic> values = e.value as List<dynamic>;
            if (title == 'Nearest Stations') {
              return AppSlider(
                title: '$title count',
                min: (values.first as int).toDouble(),
                max: (values.last as int).toDouble(),
                current: settingsModel[title]?.toDouble() ?? 0,
                onChangedEnd: (dynamic value) {
                  _saveToLocal(
                    title,
                    (value as double).floor(),
                  );
                },
                onChanged: (dynamic value) {
                  final Map<String, int> updated =
                      Map<String, int>.from(settingsModel);
                  updated[title] = (value as double).floor();
                  _changeValue(
                    context,
                    updated,
                  );
                },
              );
            }
            final List<String> labels = _getLabels(title, values);
            return AppToggle(
              title: title,
              labels: labels,
              selectedIndex: settingsModel[title] ?? 0,
              hasPremiumAccess:
                  AppService().hasPremiumAccess(values.first as Object),
              selectedLabelIndex: (int index) {
                _selectedLabelIndex(context, index, settingsModel, title);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _selectedLabelIndex(BuildContext context, int index,
      Map<String, int> settingsModel, String title) {
    final Map<String, int> updated = Map<String, int>.from(settingsModel);
    updated[title] = index;
    _changeValue(context, updated);
    _saveToLocal(title, index);
    if (title == Mode.name) {
      context.read<ThemeModeBloc>().add(
            UpdateTheme(index == 0 ? ThemeMode.light : ThemeMode.dark),
          );
    }
  }

  List<String> _enumRepresentation<T>(List<dynamic> values) {
    final List<String> strEnums = <String>[];
    for (int i = 0; i < values.length; i++) {
      strEnums.add(values[i].message as String);
    }
    return strEnums;
  }

  List<String> _getLabels(String title, List<dynamic> values) {
    List<String> strEnums = <String>[];
    if (title == Temperature.name || title == ClockSystem.name) {
      strEnums = _enumRepresentation(values);
    } else {
      strEnums = EnumToString.toList(
        values,
        camelCase: _useCamelCase(title),
      );
    }
    return strEnums;
  }

  bool _useCamelCase(String title) {
    if (title == DistanceUnit.name || title == ClockSystem.name) {
      return true;
    }
    return false;
  }

  void _changeValue(BuildContext context, Map<String, int> settingsModel) =>
      context.read<SettingsBloc>().add(UpdateSettings(settingsModel));

  void _saveToLocal(String key, int value) =>
      GetIt.instance<LocalStorage>().setValue(key, value, int);
}
