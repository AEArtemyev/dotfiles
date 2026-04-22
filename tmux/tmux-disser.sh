#!/usr/bin/env bash
# Запускать скрипт через bash, который найден в PATH

SESSION="disser"
# Имя tmux-сессии, с которой будет работать скрипт

tmux has-session -t "$SESSION" 2>/dev/null && exec tmux attach -t "$SESSION"
# Проверяем, существует ли уже сессия с именем "disser"
# 2>/dev/null скрывает сообщение об ошибке, если сессии нет
# Если сессия существует, сразу заменяем текущий процесс на:
# tmux attach -t disser
# То есть просто подключаемся к уже готовой сессии и дальше код ниже не выполняется

tmux new-session -d -s "$SESSION" -n vial -c ~/
# Создаём новую tmux-сессию в фоне:
# -d  => не подключаться сразу
# -s  => имя сессии
# -n  => имя первого окна: "vial"
# -c  => стартовая директория для окна: ~/

tmux send-keys -t "$SESSION":vial './Downloads/Vial-v0.7.5-x86_64.AppImage' C-m
# Отправляем в окно "vial" команду и Enter

tmux new-window -t "$SESSION" -n psj -c ~/work/disser/plate_solver_project
# Создаём окно 2 внутри сессии "psj"
# Имя окна: "psj"
# Стартовая директория та же: ~/work/disser/plate_solver_project

tmux send-keys -t "$SESSION":psj 'lv' C-m
# Отправляем в окно "psj" команду lv и Enter
# C-m эквивалентен нажатию клавиши Enter

tmux new-window -t "$SESSION" -n psjMATLAB -c ~/work/disser/plate_solver_project
# Создаём окно 3 внутри сессии "disser"
# Имя окна: "psjMATLAB"
# Стартовая директория та же: ~/work/disser/plate_solver_project

tmux send-keys -t "$SESSION":psjMATLAB \
  "matlab -nodesktop -r \"f=figure('Visible','off'); drawnow; close(f);\"" C-m
# Отправляем в окно "psj" команду запуска MATLAB и команды открытия и закрытия
# figure для инициализации графики

tmux new-window -t "$SESSION" -n psjcodex -c ~/work/disser/plate_solver_project
# Создаём окно 5 внутри сессии "disser"
# Имя окна: "psjcodex"
# Стартовая директория та же: ~/work/disser/plate_solver_project

# tmux send-keys -t "$SESSION":psjcodex 'codex' C-m
# В окне "qmcodex" запускаем команду codex

tmux select-window -t 1
# Переключаемся на окно 1

exec tmux attach -t "$SESSION"
# В конце подключаемся к созданной сессии
# exec заменяет текущий shell-процесс на tmux attach
