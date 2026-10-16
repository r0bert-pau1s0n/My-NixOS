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
