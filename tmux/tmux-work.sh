#!/usr/bin/env bash
# Создаёт рабочие сессии tmux и открывает первую доступную.
# Сначала идут общие функции, ниже — список сессий и их окон. При повторном
# запуске готовые сессии не меняются: создаются только отсутствующие.
# Если каталога проекта нет, его сессия пропускается.
#
# Часто используемые команды tmux:
# has-session -t "=имя" проверяет сессию с точным именем; 2>/dev/null скрывает
# сообщение об ошибке, когда такой сессии ещё нет.
# new-session -d -s имя -n окно -c каталог создаёт сессию в фоне с первым окном.
# new-window -t сессия -n окно -c каталог добавляет окно в нужном каталоге.
# send-keys -l вводит текст буквально; без C-m (Enter) команда не запускается.
# select-window выбирает окно, а attach или switch-client открывает сессию.

set -e

# Первая доступная сессия станет той, к которой подключится терминал.
first_session=''

# Оставляет подходящую команду в строке терминала указанного окна.
prefill_window() {
  local session=$1 window=$2 command

  case "$window" in
    nvim) command='lv' ;;
    matlab) command="matlab -nodesktop -r \"f=figure('Visible','off'); drawnow; close(f);\"" ;;
    codex) command='codex' ;;
    vial) command='./Downloads/Vial-v0.7.5-x86_64.AppImage' ;;
    build) return 0 ;; # В окне сборки команду выбираем вручную.
    *) printf 'Неизвестное окно: %s\n' "$window" >&2; return 1 ;;
  esac

  tmux send-keys -l -t "$session:$window" "$command"
}

# Создаёт сессию: первые три аргумента — имя, каталог и первое окно;
# остальные аргументы — следующие окна в нужном порядке.
create_session() {
  local session=$1 directory=$2 first_window=$3 window
  shift 3

  # Отсутствующий каталог пропускаем и сообщаем об этом пользователю.
  if [[ ! -d $directory ]]; then
    printf 'Пропускаю %s: нет каталога %s\n' "$session" "$directory" >&2
    return 0
  fi

  # Существующую сессию и введённые в её окнах команды не трогаем.
  if ! tmux has-session -t "=$session" 2>/dev/null; then
    tmux new-session -d -s "$session" -n "$first_window" -c "$directory"
    prefill_window "$session" "$first_window"

    for window in "$@"; do
      tmux new-window -t "$session" -n "$window" -c "$directory"
      prefill_window "$session" "$window"
    done

    # Новая сессия откроется на первом окне, а не на последнем созданном.
    tmux select-window -t "$session:$first_window"
  fi

  if [[ -z $first_session ]]; then
    first_session=$session
  fi
}

# Рабочие проекты: каждое окно начинает работу в каталоге своей сессии.
create_session quad_mesher "$HOME/dev/QuadMesher" nvim matlab build codex
create_session rsp "$HOME/dev/rsp" nvim
create_session surface_model "$HOME/dev/surface_model" nvim matlab build codex
create_session dotfiles "$HOME/dev/dotfiles" nvim codex
create_session plate_solver_project "$HOME/YandexDisk/work/disser/plate_solver_project" nvim matlab codex
create_session elasticity2d "$HOME/YandexDisk/work/disser/elasticity2d" nvim matlab codex

# Редко используемые программы держим в отдельной сессии из домашнего каталога.
create_session utils "$HOME" vial

# При обычном запуске first_session всегда задана: домашний каталог существует.
# Явная проверка покажет причину, если домашний каталог недоступен.
if [[ -z $first_session ]]; then
  printf 'Нет доступных каталогов для сессий tmux\n' >&2
  exit 1
fi

# Внутри tmux переключаем клиент; снаружи подключаем терминал к сессии.
if [[ -n ${TMUX:-} ]]; then
  tmux switch-client -t "$first_session"
else
  exec tmux attach -t "$first_session"
fi
