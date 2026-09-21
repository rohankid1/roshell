pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import "../utils.js" as Utils

Singleton {
    id: root;

    enum ColorGenBackend {
        Matugen = 0
    }

    property int provider: 0;

    readonly property bool dark: SettingsService.get.wallpaper.colorGen.dark;
    readonly property alias md3: jsonAdapter.md3;
    readonly property alias base16: jsonAdapter.base16;
    readonly property alias palette: jsonAdapter.palette;

    Component.onCompleted: {
        Utils.initService("ColorGenService");
    }

    QtObject {
        id: internal;

        property string backend: SettingsService.get.wallpaper.colorGen.backend;
    }

    Process {
        id: proc;
        command: [];
        running: false;
        stdout: StdioCollector {
            onStreamFinished: {
                if (root.provider === ColorGenService.ColorGenBackend.Iris) {
                    root.setTheme(JSON.parse(this.text));
                }
            }
        }
    }

    FileView {
        id: fileView;

        path: Quickshell.shellPath("generated/colors.json");
        watchChanges: true;

        onFileChanged: this.reload();
        onAdapterUpdated: this.writeAdapter();

        adapter: JsonAdapter {
            id: jsonAdapter;

            property Md3 md3: Md3 {};
            property Base16 base16: Base16 {};
            property Palette palette: Palette {};
        }
    }

    function setTheme(themeObject): void {
        // jsonAdapter.bg = themeObject.bg;
        // jsonAdapter.fg = themeObject.fg;
        // jsonAdapter.surface = themeObject.surface;
        // jsonAdapter.dim = themeObject.dim;
        // jsonAdapter.accent = themeObject.accent;
        // jsonAdapter.red = themeObject.red;
        // jsonAdapter.green = themeObject.green;
        // jsonAdapter.yellow = themeObject.yellow;
    }

    function generate(imgPath: string): void {
        root.generateMatugen(imgPath);
    }

    function generateIris(imgPath: string): void {
        proc.command = [
        "iris", imgPath,
        "--json-only",
        "--dark", root.dark ? "1" : "0"
        ];
        proc.running = true;
    }

    function generateMatugen(imgPath: string): void {
        const s = SettingsService.get.wallpaper.colorGen.matugen;
        const mode = s.mode;
        const schemeType = s.schemeType;
        const contrast = s.contrast;
        const lightnessDark = s.lightnessDark;
        const lightnessLight = s.lightnessLight;
        const opacity = s.opacity;
        const prefer = mode === "dark" ?
            "darkness" :
             (mode === "light" ? "lightness" : "value");
    
        proc.command = [
            "matugen", "image",
            imgPath,
            "--prefer", prefer,
            "--mode", mode,
            "--type", schemeType,
            "--lightness-dark", lightnessDark,
            "--lightness-light", lightnessLight,
            "--opacity", opacity
        ];
        proc.running = true;
    }

    component Md3: JsonObject {
        property string background: "transparent"
        property string error: "transparent"
        property string error_container: "transparent"
        property string inverse_on_surface: "transparent"
        property string inverse_primary: "transparent"
        property string inverse_surface: "transparent"
        property string on_background: "transparent"
        property string on_error: "transparent"
        property string on_error_container: "transparent"
        property string on_primary: "transparent"
        property string on_primary_container: "transparent"
        property string on_primary_fixed: "transparent"
        property string on_primary_fixed_variant: "transparent"
        property string on_secondary: "transparent"
        property string on_secondary_container: "transparent"
        property string on_secondary_fixed: "transparent"
        property string on_secondary_fixed_variant: "transparent"
        property string on_surface: "transparent"
        property string on_surface_variant: "transparent"
        property string on_tertiary: "transparent"
        property string on_tertiary_container: "transparent"
        property string on_tertiary_fixed: "transparent"
        property string on_tertiary_fixed_variant: "transparent"
        property string outline: "transparent"
        property string outline_variant: "transparent"
        property string primary: "transparent"
        property string primary_container: "transparent"
        property string primary_fixed: "transparent"
        property string primary_fixed_dim: "transparent"
        property string scrim: "transparent"
        property string secondary: "transparent"
        property string secondary_container: "transparent"
        property string secondary_fixed: "transparent"
        property string secondary_fixed_dim: "transparent"
        property string shadow: "transparent"
        property string surface: "transparent"
        property string surface_bright: "transparent"
        property string surface_container: "transparent"
        property string surface_container_high: "transparent"
        property string surface_container_highest: "transparent"
        property string surface_container_low: "transparent"
        property string surface_container_lowest: "transparent"
        property string surface_dim: "transparent"
        property string surface_tint: "transparent"
        property string surface_variant: "transparent"
        property string tertiary: "transparent"
        property string tertiary_container: "transparent"
        property string tertiary_fixed: "transparent"
        property string tertiary_fixed_dim: "transparent"
    }

    component Palette: JsonObject {
        property string error0: "transparent"
        property string error5: "transparent"
        property string error10: "transparent"
        property string error15: "transparent"
        property string error20: "transparent"
        property string error25: "transparent"
        property string error30: "transparent"
        property string error35: "transparent"
        property string error40: "transparent"
        property string error50: "transparent"
        property string error60: "transparent"
        property string error70: "transparent"
        property string error80: "transparent"
        property string error90: "transparent"
        property string error95: "transparent"
        property string error98: "transparent"
        property string error99: "transparent"
        property string error100: "transparent"

        property string neutral0: "transparent"
        property string neutral5: "transparent"
        property string neutral10: "transparent"
        property string neutral15: "transparent"
        property string neutral20: "transparent"
        property string neutral25: "transparent"
        property string neutral30: "transparent"
        property string neutral35: "transparent"
        property string neutral40: "transparent"
        property string neutral50: "transparent"
        property string neutral60: "transparent"
        property string neutral70: "transparent"
        property string neutral80: "transparent"
        property string neutral90: "transparent"
        property string neutral95: "transparent"
        property string neutral98: "transparent"
        property string neutral99: "transparent"
        property string neutral100: "transparent"

        property string neutral_variant0: "transparent"
        property string neutral_variant5: "transparent"
        property string neutral_variant10: "transparent"
        property string neutral_variant15: "transparent"
        property string neutral_variant20: "transparent"
        property string neutral_variant25: "transparent"
        property string neutral_variant30: "transparent"
        property string neutral_variant35: "transparent"
        property string neutral_variant40: "transparent"
        property string neutral_variant50: "transparent"
        property string neutral_variant60: "transparent"
        property string neutral_variant70: "transparent"
        property string neutral_variant80: "transparent"
        property string neutral_variant90: "transparent"
        property string neutral_variant95: "transparent"
        property string neutral_variant98: "transparent"
        property string neutral_variant99: "transparent"
        property string neutral_variant100: "transparent"

        property string primary0: "transparent"
        property string primary5: "transparent"
        property string primary10: "transparent"
        property string primary15: "transparent"
        property string primary20: "transparent"
        property string primary25: "transparent"
        property string primary30: "transparent"
        property string primary35: "transparent"
        property string primary40: "transparent"
        property string primary50: "transparent"
        property string primary60: "transparent"
        property string primary70: "transparent"
        property string primary80: "transparent"
        property string primary90: "transparent"
        property string primary95: "transparent"
        property string primary98: "transparent"
        property string primary99: "transparent"
        property string primary100: "transparent"

        property string secondary0: "transparent"
        property string secondary5: "transparent"
        property string secondary10: "transparent"
        property string secondary15: "transparent"
        property string secondary20: "transparent"
        property string secondary25: "transparent"
        property string secondary30: "transparent"
        property string secondary35: "transparent"
        property string secondary40: "transparent"
        property string secondary50: "transparent"
        property string secondary60: "transparent"
        property string secondary70: "transparent"
        property string secondary80: "transparent"
        property string secondary90: "transparent"
        property string secondary95: "transparent"
        property string secondary98: "transparent"
        property string secondary99: "transparent"
        property string secondary100: "transparent"

        property string tertiary0: "transparent"
        property string tertiary5: "transparent"
        property string tertiary10: "transparent"
        property string tertiary15: "transparent"
        property string tertiary20: "transparent"
        property string tertiary25: "transparent"
        property string tertiary30: "transparent"
        property string tertiary35: "transparent"
        property string tertiary40: "transparent"
        property string tertiary50: "transparent"
        property string tertiary60: "transparent"
        property string tertiary70: "transparent"
        property string tertiary80: "transparent"
        property string tertiary90: "transparent"
        property string tertiary95: "transparent"
        property string tertiary98: "transparent"
        property string tertiary99: "transparent"
        property string tertiary100: "transparent"
    }

    component Base16: JsonObject {
        property string base00: "transparent"
        property string base01: "transparent"
        property string base02: "transparent"
        property string base03: "transparent"
        property string base04: "transparent"
        property string base05: "transparent"
        property string base06: "transparent"
        property string base07: "transparent"
        property string base08: "transparent"
        property string base09: "transparent"
        property string base0a: "transparent"
        property string base0b: "transparent"
        property string base0c: "transparent"
        property string base0d: "transparent"
        property string base0e: "transparent"
        property string base0f: "transparent"
    }
}
