{ pkgs, config, ... }:

let
  allowedDomains = [
    "https://duckduckgo.com"
    "https://rutracker.org"
    "https://mail.google.com"
    "https://proton.me"
    "https://www.youtube.com"
    "https://www.twitch.tv"
    "https://play.qobuz.com"
    "https://www.ozon.ru"
    "https://www.avito.ru"
    "https://aliexpress.ru"
    "https://www.lamoda.ru"
    "https://lesta.ru"
    "https://store.steampowered.com"
    "https://cybershoke.net"
    "https://pixstorm.ru"
    "https://store.epicgames.com"
    "https://chatgpt.com"
    "https://chat.z.ai"
    "https://grok.com"
    "https://chat.deepseek.com"
    "https://github.com"
    "https://hub.docker.com"
    "https://www.deepl.com"
    "https://discord.com"
    "https://x.com"
    "https://www.gosuslugi.ru"
    "https://app.medtochka.ru"
    "https://lkfl2.nalog.ru"
    "https://www.tbank.ru"
    "http://192.168.0.1"
  ];
in
{
  programs.librewolf = {
    enable = true;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;

      SearchEngines = {
        Default = "DuckDuckGo";
        Remove = [ "Google" "Bing" "Amazon.com" "eBay" "Twitter" "Perplexity" ];
      };

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
        };
        "sponsorBlocker@ajay.app" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
        };
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
        };
        "pywalfox@frewacom.org" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/pywalfox/latest.xpi";
        };
        "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/traduzir-paginas-web/latest.xpi";
        };
      };

      # Куки для доменов из закладок разрешены
      Cookies = {
        Default = true;
        Allow = allowedDomains;
        Block = [];
      };

      Bookmarks = [
        { Title = ""; URL = "https://rutracker.org/forum/index.php?addon_rnd=0.26349277671516336"; Placement = "toolbar"; }
        { Title = ""; URL = "https://yandex.ru/maps/50/perm/?ll=56.229441%2C58.010454&z=12"; Placement = "toolbar"; }
        { Title = ""; URL = "https://mail.google.com/mail/u/0/#inbox"; Placement = "toolbar"; }
        { Title = ""; URL = "https://proton.me/"; Placement = "toolbar"; }
        { Title = ""; URL = "https://www.youtube.com/"; Placement = "toolbar"; }
        { Title = ""; URL = "https://www.twitch.tv/"; Placement = "toolbar"; }
        { Title = ""; URL = "https://play.qobuz.com/discover"; Placement = "toolbar"; }
        { Title = ""; URL = "https://www.ozon.ru/"; Placement = "toolbar"; }
        { Title = ""; URL = "https://www.avito.ru/"; Placement = "toolbar"; }
        { Title = ""; URL = "https://aliexpress.ru/"; Placement = "toolbar"; }
        { Title = ""; URL = "https://www.lamoda.ru/women-home/"; Placement = "toolbar"; }
        { Title = ""; URL = "https://lesta.ru/ru"; Placement = "toolbar"; }
        { Title = ""; URL = "https://store.steampowered.com/"; Placement = "toolbar"; }
        { Title = ""; URL = "https://cybershoke.net/cs2/servers/dm/ru-moscow"; Placement = "toolbar"; }
        { Title = ""; URL = "https://pixstorm.ru/ru"; Placement = "toolbar"; }
        { Title = ""; URL = "https://store.epicgames.com/ru/"; Placement = "toolbar"; }
        { Title = ""; URL = "https://chatgpt.com/"; Placement = "toolbar"; }
        { Title = ""; URL = "https://chat.z.ai/"; Placement = "toolbar"; }
        { Title = ""; URL = "https://grok.com/"; Placement = "toolbar"; }
        { Title = ""; URL = "https://chat.deepseek.com/"; Placement = "toolbar"; }
        { Title = ""; URL = "https://github.com/r0bert-pau1s0n"; Placement = "toolbar"; }
        { Title = ""; URL = "https://hub.docker.com/"; Placement = "toolbar"; }
        { Title = ""; URL = "https://translate.yandex.ru/translator/%D0%90%D0%BD%D0%B3%D0%BB%D0%B8%D0%B9%D1%81%D0%BA%D0%B8%D0%B9-%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9"; Placement = "toolbar"; }
        { Title = ""; URL = "https://www.deepl.com/ru/translator"; Placement = "toolbar"; }
        { Title = ""; URL = "https://discord.com/"; Placement = "toolbar"; }
        { Title = ""; URL = "https://x.com/i/grok?conversation=1892935018915176636"; Placement = "toolbar"; }
        { Title = ""; URL = "https://www.gosuslugi.ru/"; Placement = "toolbar"; }
        { Title = ""; URL = "https://app.medtochka.ru/"; Placement = "toolbar"; }
        { Title = ""; URL = "https://lkfl2.nalog.ru/"; Placement = "toolbar"; }
        { Title = ""; URL = "https://www.tbank.ru/mybank/"; Placement = "toolbar"; }
        { Title = ""; URL = "http://192.168.0.1/"; Placement = "toolbar"; }
      ];
    };

    profiles.default = {
      id = 0;
      isDefault = true;

      settings = {
        # Запуск и сессия
        "browser.startup.page" = 3;

        # Внешний вид и шрифты
        "browser.theme.content-theme" = 0;
        "browser.theme.toolbar-theme" = 0;
        "browser.uidensity" = 1;
        "browser.display.use_document_fonts" = 0;
        "browser.translations.enable" = false;
        "font.language.group" = "x-western";
        "font.name.monospace.x-western" = "JetBrainsMono Nerd Font Mono";
        "font.name.sans-serif.x-western" = "JetBrainsMono Nerd Font Mono";
        "font.name.serif.x-western" = "JetBrainsMono Nerd Font Mono";

        # Масштаб
        "zoom.defaultPercent" = 90;

        # Полноэкранный режим
        "full-screen-api.transition-duration.enter" = "0";
        "full-screen-api.transition-duration.leave" = "0";
        "full-screen-api.warning.timeout" = 0;

        # Новая вкладка и адресная строка
        "browser.newtabpage.activity-stream.showSearch" = false;
        "browser.urlbar.shortcuts.actions" = true;

        # Прокси (v2rayN) и DNS
        "network.proxy.socks" = "127.0.0.1";
        "network.proxy.socks_port" = 10808;
        "network.trr.mode" = 3;
        "network.trr.uri" = "https://dns.quad9.net/dns-query";

        # Сетевая безопасность
        "network.captive-portal-service.enabled" = false;
        "network.connectivity-service.enabled" = false;
        "captivedetect.canonicalURL" = "";
        "network.early-hints.preconnect.max_connections" = 0;
        "network.http.http3.enable_0rtt" = false;
        "network.http.speculative-parallel-limit" = 0;
        "network.http.referer.disallowCrossSiteRelaxingDefault.top_navigation" = true;
        "network.prefetch-next" = false;
        "network.protocol-handler.expose.file" = true;
        "security.tls.enable_0rtt_data" = false;

        # Регион
        "browser.region.network.url" = "";
        "browser.region.update.enabled" = false;

        # Safebrowsing (отключено)
        "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
        "browser.safebrowsing.downloads.remote.block_uncommon" = false;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "browser.safebrowsing.downloads.remote.url" = "";
        "browser.safebrowsing.provider.google4.dataSharingURL" = "";

        # Защита от трекинга и фингерпринтинга (Strict)
        "browser.contentblocking.category" = "strict";
        "network.cookie.cookieBehavior" = 5;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.pbmode.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.socialtracking.block_cookies.enabled" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.spoof_english" = 2;
        "privacy.annotate_channels.strict_list.enabled" = true;
        "privacy.bounceTrackingProtection.mode" = 1;
        "privacy.query_stripping.enabled" = true;
        "privacy.query_stripping.enabled.pbmode" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.allow_list.baseline.enabled" = false;
        "privacy.trackingprotection.allow_list.convenience.enabled" = false;
        "privacy.globalprivacycontrol.was_ever_enabled" = true;
        "privacy.history.custom" = true;

        # Защита от утечек IP через WebRTC
        "media.peerconnection.ice.default_address_only" = true;
        "media.peerconnection.ice.no_host" = true;

        # HTTPS-Only Mode
        "dom.security.https_only_mode_ever_enabled" = true;
        "dom.security.https_only_mode_ever_enabled_pbm" = true;

        # DevTools
        "devtools.console.stdout.chrome" = false;
        "devtools.debugger.remote-enabled" = false;

        # Прочее
        "intl.accept_languages" = "en-US, en";
        "browser.download.lastDir" = "${config.home.homeDirectory}/Downloads";
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "permissions.manager.defaultsUrl" = "";
      };
    };
  };
}
