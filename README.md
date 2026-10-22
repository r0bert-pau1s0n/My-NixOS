# My-NixOS

Декларативная конфигурация NixOS + Home Manager (модуль NixOS) для flake на базе
`nixos-unstable`.

> Реальная конфигурация находится **здесь** (`~/nix`). Каталог `/etc/nixos`
> содержит устаревший дефолтный `configuration.nix`, который **не используется**
> сборкой и оставлен только как артефакт установщика.

## Требования

- NixOS 26.11+ (`nix --version` >= 2.34), включены `nix-command` и `flakes`.
- flake pinned через `flake.lock` — сборка воспроизводима.

## Структура

```
flake.nix         точка входа: mkHost, formatter, devShell, checks
flake.lock        зафиксированные версии зависимостей
modules/          общие (не зависящие от машины) системные модули
hosts/<host>/     всё, что специфично для конкретной машины
home/             общий профиль Home Manager (пользователь robert)
```

- `modules/` — системные настройки, которые должны быть одинаковы на всех
  машинах (сеть, сервисы, docker, ssh, шрифты, пакеты, пользователи, оверлеи).
- `hosts/<host>/` — аппаратное обеспечение и host-специфика:
  - `default.nix` — точка входа хоста (импорт модулей + HM),
  - `hardware-configuration.nix` — сгенерирован `nixos-generate-config`, не править вручную,
  - `boot.nix`, `nvidia.nix` — загрузчик и GPU,
  - `host.nix` — hostname, часовой пояс, stateVersion,
  - `home.nix` — host-специфичная пользовательская среда (мониторы, автозапуск).
- `home/` — общий профиль пользователя; host-специфичные части лежат в
  `hosts/<host>/home.nix` и подключаются автоматически.

## Использование

Обновить систему и Home Manager (одна команда):

```bash
sudo nixos-rebuild switch --flake ~/nix#nixos
```

Проверить сборку без переключения:

```bash
nixos-rebuild build --flake ~/nix#nixos
```

Безопасная тестовая активация (действует до перезагрузки):

```bash
sudo nixos-rebuild test --flake ~/nix#nixos
```

Применить при следующей загрузке (текущая сессия не меняется):

```bash
sudo nixos-rebuild boot --flake ~/nix#nixos
```

## Noctalia: настройки из GUI в Git

Noctalia собирает настройки из трёх слоёв в порядке загрузки:

- `~/.config/noctalia/config.toml` — декларативный слой Home Manager
  (`home/programs/noctalia/noctalia.nix`): шаблоны с store-путями, хуки, каталог обоев и
  privacy-флаги;
- `~/.config/noctalia/host.toml` — host-specific мониторы, lockscreen и обои;
- `~/.local/state/noctalia/settings.toml` — слой, в который Noctalia пишет
  изменения из GUI. Загружается последним и перекрывает остальные слои.

В этом репозитории `settings.toml` — **отслеживаемый Git-файл**:

```
home/programs/noctalia/settings.toml          источник истины
        ▲
        │ Noctalia пишет атомарно сквозь симлинк
~/.local/state/noctalia/settings.toml
```

Activation после `linkGeneration` создаёт прямой симлинк из state-каталога на
`~/nix/home/programs/noctalia/settings.toml`. Повторные переключения идемпотентны:
правильная ссылка не трогается, старый двухступенчатый симлинк через
`/nix/store` заменяется прямым, а чужой файл или симлинк уходит в
`settings.toml.bak-<timestamp>`. Каталог на месте `settings.toml` не
заменяется — activation останавливается с ошибкой. После создания ссылки
объединённый config проверяется через `noctalia config validate`; в dry-run
проверка пропускается. Поэтому после изменения настроек в GUI достаточно
проверить и закоммитить diff:

```bash
git status
git diff
git add home/programs/noctalia/settings.toml
git commit -m "Update Noctalia settings"
```

Repo должен быть клонирован именно в `~/nix`: путь к `settings.toml` зашит в
`home/programs/noctalia/noctalia.nix`. При первом переключении существующий
`settings.toml` автоматически перемещается в
`settings.toml.bak-<timestamp>`; если миграция не удалась, activation
останавливается.

Host-specific настройки (мониторы, раскладка lockscreen) лежат в
`hosts/<host>/host.toml` и устанавливаются как
`~/.config/noctalia/host.toml`. На новой машине создайте свой файл с её
connector'ом или уберите строку `xdg.configFile."noctalia/host.toml"` из
`hosts/<host>/home.nix`. Устаревший `~/.config/noctalia/90-host.toml` при
первом переключении автоматически перемещается в
`90-host.toml.bak-<timestamp>`.

Ограничения:

- `settings.toml` не попадает в Nix store, поэтому его содержимое проверяется
  при activation (`noctalia config validate`), а не при сборке.
- Community-палитра `Alpenglow` и community-шаблоны скачиваются при первом
  запуске. Без интернета Noctalia временно использует встроенную палитру.
- Пути обоев записаны через `~` и раскрываются Noctalia при чтении. Если
  выбрать обои через GUI, Noctalia может снова записать абсолютный путь.
- Правки per-monitor ключей через GUI попадут в общий `settings.toml`. Чтобы
  они оставались только на этом хосте, переносите их в
  `hosts/<host>/host.toml` вручную.
- После первого переключения со старой установки может понадобиться
  перезапустить Noctalia или сессию: старый процесс держит host-specific
  overrides (например, раскладку lockscreen) в памяти и может записать их
  обратно при следующем изменении. После перезапуска host-файл работает как
  ожидается.

## Проверки качества

```bash
nix fmt              # nixfmt по всему дереву
nix flake check      # оценка + сборка checks (toplevel)
nix develop          # окружение с nixfmt, deadnix, statix
deadnix .            # поиск мёртвого кода
statix check .       # статический анализ
```

## Откат

```bash
sudo nixos-rebuild switch --rollback        # предыдущая генерация
nixos-rebuild list-generations               # список генераций
```

Home Manager откатывается вместе с системой (он собран как модуль NixOS).

## Добавление новой машины (например, ноутбука)

1. Сгенерировать аппаратную конфигурацию на новой машине:

   ```bash
   nixos-generate-config --show-hardware-config > hosts/<host>/hardware-configuration.nix
   ```

2. Скопировать `hosts/nixos/` → `hosts/<host>/` и поправить
   `hardware-configuration.nix`, `boot.nix`, `nvidia.nix` (`host.nix`, `home.nix`
   под новую машину).
3. Добавить в `flake.nix`:

   ```nix
   nixosConfigurations.<host> = mkHost "<host>";
   ```

4. Собрать: `sudo nixos-rebuild switch --flake ~/nix#<host>`.

> Конфигурация ноутбука **не создана**: отсутствует второе физическое
> устройство для проверки. Шаблон выше — рекомендация, а не протестированный
> результат.

## Новый хост

Пошаговый перенос конфигурации на другую машину. Порядок важен: сначала
собираем и проверяем без переключения, потом активируем.

1. Установить NixOS на новую машину (установщик создаст свой `/etc/nixos` — он
   не используется, можно игнорировать). Включить `nix-command` и `flakes`.

2. Склонировать репозиторий в домашний каталог и **не** копировать
   `hardware-configuration.nix` со старой машины — он содержит UUID разделов и
   ФС именно той машины:

   ```bash
   git clone <repo> ~/nix
   ```

3. Создать каталог нового хоста и отдельно сгенерировать под него железо:

   ```bash
   mkdir -p ~/nix/hosts/<host>
   nixos-generate-config --show-hardware-config > ~/nix/hosts/<host>/hardware-configuration.nix
   ```

   Файл сгенерирован автоматически — **не редактировать вручную**.

4. Настроить host-специфику (не копировать слепо из `hosts/nixos/`):
   - `host.nix` — `hostName`, часовой пояс, `stateVersion`;
   - `boot.nix` — загрузчик и его параметры;
   - `nvidia.nix` — нужен только если на новой машине GPU NVIDIA (иначе
     подключение этого модуля убрать);
   - `home.nix` — host-специфичная пользовательская среда (мониторы,
     автозапуск приложений и т.п.);
   - `host.toml` — host-specific Noctalia (мониторы, lockscreen);
     если файла нет, уберите соответствующую строку
     `xdg.configFile."noctalia/host.toml"` из `home.nix`.

5. Проверить `default.nix` нового хоста: он должен импортировать общие
   `modules/*` и `home/`, подключать Home Manager и указывать правильные
   аппаратные/boot-модули. Смотрите `hosts/nixos/default.nix` как образец.

6. Правила `stateVersion` (важно):
   - `system.stateVersion` в `host.nix` — **не менять** при переезде на новую
     машину без необходимости; это не версия системы, а точка совместимости;
   - `home.stateVersion` — «замораживается» один раз при первой установке
     профиля и далее не поднимается вместе с обновлениями;
   - для нового хоста допустимо поставить текущую версию, если профиль
     ставится «с нуля».

7. Секреты и внешние ресурсы на новой машине придётся подготовить заново:
   репозиторий их не содержит. Ключи лежат вне репо (`~/.ssh/*`), приложения
   с рантайм-клонированием (например, LazyVim) скачивают плагины из интернета
   при первом запуске. Доступ к кэшу Noctalia (`noctalia.cachix.org`) должен
   работать, иначе `noctalia` соберётся из исходников (долго, но корректно).

8. Зарегистрировать хост в `flake.nix`:

   ```nix
   nixosConfigurations.<host> = mkHost "<host>";
   ```

9. Собрать без переключения (ничего не меняет в системе) и проверить именно
   вывод нового хоста:

   ```bash
   nixos-rebuild build --flake ~/nix#<host>
   nix build ~/nix#nixosConfigurations.<host>.config.system.build.toplevel
   ```

10. Применить. Сначала безопасный вариант, действующий до перезагрузки
    (`test`) или только при следующей загрузке (`boot`), и лишь затем `switch`:

    ```bash
    sudo nixos-rebuild test --flake ~/nix#<host>
    sudo nixos-rebuild switch --flake ~/nix#<host>
    ```

11. Откат при проблемах:

    ```bash
    sudo nixos-rebuild switch --rollback
    nixos-rebuild list-generations
    ```

Оговорки:
- `hosts/nixos/nvidia.nix` и многие параметры `boot.nix`/`home.nix` заточены под
  текущую машину — на другом железе их нужно править, а не копировать как есть.
- `nixos-hardware` в проекте **не подключён**, поэтому под специфичное железо
  (ноутбуки, некоторые Wi-Fi/GPU) придётся добавить нужные модули вручную.
- Полный перенос на реальное второе устройство **не тестировался** (нет второго
  железа) — пункты выше основаны на статическом анализе конфигурации.
