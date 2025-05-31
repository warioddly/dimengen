#ifndef FLUTTER_PLUGIN_DIMENGEN_PLUGIN_H_
#define FLUTTER_PLUGIN_DIMENGEN_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace dimengen {

class DimengenPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  DimengenPlugin();

  virtual ~DimengenPlugin();

  // Disallow copy and assign.
  DimengenPlugin(const DimengenPlugin&) = delete;
  DimengenPlugin& operator=(const DimengenPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace dimengen

#endif  // FLUTTER_PLUGIN_DIMENGEN_PLUGIN_H_
