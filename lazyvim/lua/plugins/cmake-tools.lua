--[[
Плагин для управления CMake сборкой из Neovim.
Команды:
  :CMakeSelectConfigurePreset
  :CMakeBuild
  :CMakeRun
  :CMakeDebug
Проблема: с настройками по умолчанию реконфигурирует cmake после изменения 
CMakePresets.json
--]]
return {
  {
    "Civitasv/cmake-tools.nvim",
    enabled = false,
    opts = {
      -- отключает cmake configure после изменения CMakePresets.json
      cmake_regenerate_on_save = false,
    },
  },
}
