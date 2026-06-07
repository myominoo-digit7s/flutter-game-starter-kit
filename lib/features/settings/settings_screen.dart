import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_game_starter_kit/l10n/app_localizations.dart';

import '../../app/router/app_routes.dart';
import '../../core/ads/ad_placement.dart';
import '../../core/ads/widgets/banner_ad_widget.dart';
import '../../core/localization/locale_cubit.dart';
import '../../core/settings/settings_cubit.dart';
import '../../core/settings/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                final cubit = context.read<SettingsCubit>();
                return ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    SwitchListTile(
                      title: Text(l10n.sound),
                      value: state.soundEnabled,
                      onChanged: cubit.toggleSound,
                    ),
                    SwitchListTile(
                      title: Text(l10n.music),
                      value: state.musicEnabled,
                      onChanged: cubit.toggleMusic,
                    ),
                    SwitchListTile(
                      title: Text(l10n.vibration),
                      value: state.vibrationEnabled,
                      onChanged: cubit.toggleVibration,
                    ),
                    BlocBuilder<LocaleCubit, Locale>(
                      builder: (context, locale) {
                        return ListTile(
                          title: Text(l10n.language),
                          trailing: DropdownButton<String>(
                            value: locale.languageCode,
                            items: const [
                              DropdownMenuItem(
                                value: 'en',
                                child: Text('English'),
                              ),
                              DropdownMenuItem(
                                value: 'my',
                                child: Text('မြန်မာ'),
                              ),
                              DropdownMenuItem(value: 'th', child: Text('ไทย')),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                context.read<LocaleCubit>().changeLocale(value);
                              }
                            },
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.policy),
                      title: const Text('Privacy & Compliance'),
                      onTap: () => context.pushNamed(AppRoutes.compliance),
                    ),
                  ],
                );
              },
            ),
          ),
          const BannerAdWidget(placement: AdPlacement.settingsScreen),
        ],
      ),
    );
  }
}
