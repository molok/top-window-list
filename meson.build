project(
  'molok-top-window-list',
  version: '50.1',
  meson_version: '>= 1.1.0',
  license: 'GPL-2.0-or-later',
)

uuid = 'top-window-list.molok.github.io'
shelldir = get_option('prefix') / 'share' / 'gnome-shell'
extensiondir = shelldir / 'extensions' / uuid
schemadir = get_option('prefix') / 'share' / 'glib-2.0' / 'schemas'

install_data([
    'extension.js',
    'prefs.js',
    'metadata.json',
    'stylesheet-dark.css',
    'stylesheet-light.css',
    'stylesheet-workspace-switcher-dark.css',
    'stylesheet-workspace-switcher-light.css',
    'workspaceIndicator.js',
    'workspacePrefs.js',
  ],
  install_dir: extensiondir,
)

install_data(
  'top-window-list.molok.github.io.gschema.xml',
  install_dir: schemadir,
  rename: 'top-window-list.molok.github.io.gschema.xml',
)

gnome.post_install(glib_compile_schemas: true)
