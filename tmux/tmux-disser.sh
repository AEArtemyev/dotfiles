#!/usr/bin/env bash
# Запускать скрипт через bash, который найден в PATH

SESSION="disser"
# Имя tmux-сессии, с которой будет работать скрипт

tmux has-session -t "$SESSION" 2>/dev/null && exec tmux attach -t "$SESSION"
# Проверяем, существует ли уже сессия с именем "work"
# 2>/dev/null скрывает сообщение об ошибке, если сессии нет
# Если сессия существует, сразу заменяем текущий процесс на:
# tmux attach -t work
# То есть просто подключаемся к уже готовой сессии и дальше код ниже не выполняется

tmux new-session -d -s "$SESSION" -n qm -c ~/plate_solver_project
# Создаём новую tmux-сессию в фоне:
# -d  => не подключаться сразу
# -s  => имя сессии
# -n  => имя первого окна: "qm"
# -c  => стартовая директория для окна: ~/plate_solver_project

tmux send-keys -t "$SESSION":qm 'lv' C-m
# Отправляем в окно "qm" команду lv и Enter
# C-m эквивалентен нажатию клавиши Enter

tmux new-window -t "$SESSION" -n codex -c ~/plate_solver_project
# Создаём второе окно внутри сессии "disser"
# Имя окна: "codex"
# Стартовая директория та же: ~/plate_solver_project

# tmux send-keys -t "$SESSION":codex 'codex' C-m
# В окне "codex" запускаем команду codex

exec tmux attach -t "$SESSION"
# В конце подключаемся к созданной сессии
# exec заменяет текущий shell-процесс на tmux attach
