#include "include/dimengen/dimengen_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "dimengen_plugin.h"

void DimengenPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  dimengen::DimengenPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
