// SPDX-License-Identifier: GPL-2.0-or-later

import Adw from 'gi://Adw';
import Gio from 'gi://Gio';
import GLib from 'gi://GLib';
import GObject from 'gi://GObject';
import Gtk from 'gi://Gtk';

import {ExtensionPreferences, gettext as _} from 'resource:///org/gnome/Shell/Extensions/js/extensions/prefs.js';

import {WorkspacesPage} from './workspacePrefs.js';

class MolokPanelPage extends Adw.PreferencesPage {
    static {
        GObject.registerClass(this);
    }

    constructor(settings) {
        super({
            title: _('Window List'),
            icon_name: 'focus-windows-symbolic',
        });

        this._actionGroup = new Gio.SimpleActionGroup();
        this.insert_action_group('molok-panel', this._actionGroup);

        this._settings = settings;
        this._actionGroup.add_action(
            this._settings.create_action('grouping-mode'));
        this._actionGroup.add_action(
            this._settings.create_action('show-on-all-monitors'));
        this._actionGroup.add_action(
            this._settings.create_action('display-all-workspaces'));
        this._actionGroup.add_action(
            this._settings.create_action('embed-previews'));

        const groupingGroup = new Adw.PreferencesGroup({
            title: _('Window Grouping'),
        });
        this.add(groupingGroup);

        const modes = [
            {mode: 'never', title: _('Never group windows')},
            {mode: 'auto', title: _('Group windows when space is limited')},
            {mode: 'always', title: _('Always group windows')},
        ];

        for (const {mode, title} of modes) {
            const check = new Gtk.CheckButton({
                action_name: 'molok-panel.grouping-mode',
                action_target: new GLib.Variant('s', mode),
            });
            const row = new Adw.ActionRow({
                activatable_widget: check,
                title,
            });
            row.add_prefix(check);
            groupingGroup.add(row);
        }

        const miscGroup = new Adw.PreferencesGroup();
        this.add(miscGroup);

        let row = new Adw.SwitchRow({
            title: _('Show on all monitors'),
            action_name: 'molok-panel.show-on-all-monitors',
        });
        miscGroup.add(row);

        row = new Adw.SwitchRow({
            title: _('Show windows from all workspaces'),
            action_name: 'molok-panel.display-all-workspaces',
        });
        miscGroup.add(row);
    }
}

export default class MolokPanelPrefs extends ExtensionPreferences {
    fillPreferencesWindow(window) {
        const settings = this.getSettings();
        window.add(new MolokPanelPage(settings));
        window.add(new WorkspacesPage(settings));
    }
}
