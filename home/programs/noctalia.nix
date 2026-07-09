# ~/nix/home/programs/noctaliashell.nix
{ ... }:

{
 
  # === plugins.json ===
  xdg.configFile."noctalia/plugins.json".text = ''
    {
        "sources": [
            {
                "enabled": true,
                "name": "Noctalia Plugins",
                "url": "https://github.com/noctalia-dev/noctalia-plugins"
            }
        ],
        "states": {
            "clipboard": {
                "enabled": true,
                "sourceUrl": "https://github.com/noctalia-dev/noctalia-plugins"
            },
            "weather-indicator": {
                "enabled": true,
                "sourceUrl": "https://github.com/noctalia-dev/noctalia-plugins"
            }
        },
        "version": 2
    }
  '';

  # === settings.json ===
  xdg.configFile."noctalia/settings.json".text = ''
    {
        "appLauncher": {
            "autoPasteClipboard": false,
            "clipboardWatchImageCommand": "wl-paste --type image --watch cliphist store",
            "clipboardWatchTextCommand": "wl-paste --type text --watch cliphist store",
            "clipboardWrapText": true,
            "customLaunchPrefix": "",
            "customLaunchPrefixEnabled": false,
            "density": "compact",
            "enableClipPreview": true,
            "enableClipboardChips": true,
            "enableClipboardHistory": true,
            "enableClipboardSmartIcons": true,
            "enableSessionSearch": false,
            "enableSettingsSearch": true,
            "enableWindowsSearch": false,
            "iconMode": "tabler",
            "ignoreMouseInput": true,
            "overviewLayer": false,
            "pinnedApps": [
            ],
            "position": "follow_bar",
            "screenshotAnnotationTool": "",
            "showCategories": false,
            "showIconBackground": true,
            "sortByMostUsed": true,
            "terminalCommand": "kitty -e",
            "viewMode": "list"
        },
        "audio": {
            "mprisBlacklist": [
            ],
            "preferredPlayer": "",
            "spectrumFrameRate": 30,
            "spectrumMirrored": true,
            "visualizerType": "linear",
            "volumeFeedback": false,
            "volumeFeedbackSoundFile": "",
            "volumeOverdrive": false,
            "volumeStep": 5
        },
        "bar": {
            "autoHideDelay": 500,
            "autoShowDelay": 150,
            "backgroundOpacity": 1,
            "barType": "floating",
            "capsuleColorKey": "none",
            "capsuleOpacity": 1,
            "contentPadding": 2,
            "density": "default",
            "displayMode": "always_visible",
            "enableExclusionZoneInset": true,
            "fontScale": 1,
            "frameRadius": 12,
            "frameThickness": 8,
            "hideOnOverview": false,
            "marginHorizontal": 4,
            "marginVertical": 4,
            "middleClickAction": "none",
            "middleClickCommand": "",
            "middleClickFollowMouse": false,
            "monitors": [
            ],
            "mouseWheelAction": "none",
            "mouseWheelWrap": true,
            "outerCorners": true,
            "position": "top",
            "reverseScroll": false,
            "rightClickAction": "controlCenter",
            "rightClickCommand": "",
            "rightClickFollowMouse": true,
            "screenOverrides": [
            ],
            "showCapsule": true,
            "showOnWorkspaceSwitch": true,
            "showOutline": false,
            "useSeparateOpacity": true,
            "widgetSpacing": 6,
            "widgets": {
                "center": [
                    {
                        "clockColor": "none",
                        "customFont": "",
                        "formatHorizontal": "HH:mm ddd MMM d",
                        "formatVertical": "HH mm - dd MM",
                        "id": "Clock",
                        "tooltipFormat": "HH:mm ddd, MMM dd",
                        "useCustomFont": false
                    }
                ],
                "left": [
                    {
                        "characterCount": 10,
                        "colorizeIcons": false,
                        "emptyColor": "none",
                        "enableScrollWheel": true,
                        "focusedColor": "none",
                        "followFocusedScreen": true,
                        "fontWeight": "medium",
                        "groupedBorderOpacity": 1,
                        "hideUnoccupied": true,
                        "iconScale": 0.8,
                        "id": "Workspace",
                        "labelMode": "index",
                        "occupiedColor": "none",
                        "pillSize": 0.55,
                        "showApplications": false,
                        "showApplicationsHover": false,
                        "showBadge": false,
                        "showLabelsOnlyWhenOccupied": true,
                        "unfocusedIconsOpacity": 1
                    },
                    {
                        "colorizeIcons": false,
                        "hideMode": "hidden",
                        "id": "ActiveWindow",
                        "maxWidth": 145,
                        "scrollingMode": "always",
                        "showIcon": true,
                        "showText": true,
                        "textColor": "none",
                        "useFixedWidth": false
                    },
                    {
                        "colorName": "none",
                        "hideWhenIdle": true,
                        "id": "AudioVisualizer",
                        "width": 150
                    }
                ],
                "right": [
                    {
                        "compactMode": false,
                        "diskPath": "/",
                        "iconColor": "none",
                        "id": "SystemMonitor",
                        "showCpuCores": false,
                        "showCpuFreq": false,
                        "showCpuTemp": true,
                        "showCpuUsage": true,
                        "showDiskAvailable": false,
                        "showDiskUsage": false,
                        "showDiskUsageAsPercent": false,
                        "showGpuTemp": false,
                        "showLoadAverage": false,
                        "showMemoryAsPercent": false,
                        "showMemoryUsage": true,
                        "showNetworkStats": false,
                        "showSwapUsage": true,
                        "textColor": "none",
                        "useMonospaceFont": true,
                        "usePadding": false
                    },
                    {
                        "displayMode": "alwaysShow",
                        "iconColor": "none",
                        "id": "Volume",
                        "middleClickCommand": "pwvucontrol || pavucontrol",
                        "textColor": "none"
                    },
                    {
                        "displayMode": "onhover",
                        "iconColor": "none",
                        "id": "Bluetooth",
                        "textColor": "none"
                    },
                    {
                        "hideWhenZero": false,
                        "hideWhenZeroUnread": false,
                        "iconColor": "none",
                        "id": "NotificationHistory",
                        "showUnreadBadge": true,
                        "unreadBadgeColor": "primary"
                    },
                    {
                        "defaultSettings": {
                            "density": "comfortable",
                            "maxHistorySize": 100,
                            "showImagePreviews": true
                        },
                        "id": "plugin:clipboard"
                    },
                    {
                        "deviceNativePath": "__default__",
                        "displayMode": "graphic-clean",
                        "hideIfIdle": false,
                        "hideIfNotDetected": true,
                        "id": "Battery",
                        "showNoctaliaPerformance": false,
                        "showPowerProfiles": false
                    },
                    {
                        "displayMode": "forceOpen",
                        "iconColor": "none",
                        "id": "KeyboardLayout",
                        "showIcon": false,
                        "textColor": "none"
                    },
                    {
                        "colorizeIcons": false,
                        "hideMode": "hidden",
                        "iconScale": 0.6,
                        "id": "Taskbar",
                        "maxTaskbarWidth": 40,
                        "onlyActiveWorkspaces": true,
                        "onlySameOutput": true,
                        "showPinnedApps": true,
                        "showTitle": false,
                        "smartWidth": true,
                        "titleWidth": 120
                    },
                    {
                        "colorizeDistroLogo": false,
                        "colorizeSystemIcon": "none",
                        "colorizeSystemText": "none",
                        "customIconPath": "",
                        "enableColorization": true,
                        "icon": "noctalia",
                        "id": "ControlCenter",
                        "useDistroLogo": false
                    }
                ]
            }
        },
        "brightness": {
            "backlightDeviceMappings": [
            ],
            "brightnessStep": 5,
            "enableDdcSupport": true,
            "enforceMinimum": true
        },
        "calendar": {
            "cards": [
                {
                    "enabled": true,
                    "id": "calendar-header-card"
                },
                {
                    "enabled": true,
                    "id": "calendar-month-card"
                },
                {
                    "enabled": true,
                    "id": "weather-card"
                }
            ]
        },
        "colorSchemes": {
            "darkMode": true,
            "generationMethod": "tonal-spot",
            "manualSunrise": "06:30",
            "manualSunset": "18:30",
            "monitorForColors": "",
            "predefinedScheme": "Kanagawa",
            "schedulingMode": "off",
            "syncGsettings": true,
            "useWallpaperColors": true 
        },
        "controlCenter": {
            "cards": [
                {
                    "enabled": true,
                    "id": "profile-card"
                },
                {
                    "enabled": true,
                    "id": "shortcuts-card"
                },
                {
                    "enabled": true,
                    "id": "audio-card"
                },
                {
                    "enabled": false,
                    "id": "brightness-card"
                },
                {
                    "enabled": true,
                    "id": "weather-card"
                },
                {
                    "enabled": true,
                    "id": "media-sysmon-card"
                }
            ],
            "diskPath": "/",
            "position": "top_center",
            "shortcuts": {
                "left": [
                    {
                        "id": "Network"
                    },
                    {
                        "id": "Bluetooth"
                    },
                    {
                        "id": "WallpaperSelector"
                    },
                    {
                        "id": "NoctaliaPerformance"
                    }
                ],
                "right": [
                    {
                        "id": "Notifications"
                    },
                    {
                        "id": "PowerProfile"
                    },
                    {
                        "id": "KeepAwake"
                    },
                    {
                        "id": "NightLight"
                    }
                ]
            }
        },
        "desktopWidgets": {
            "enabled": true,
            "gridSnap": false,
            "gridSnapScale": false,
            "monitorWidgets": [
                {
                    "name": "DP-3",
                    "widgets": [
                    ]
                }
            ],
            "overviewEnabled": true
        },
        "dock": {
            "animationSpeed": 1,
            "backgroundOpacity": 1,
            "colorizeIcons": false,
            "deadOpacity": 0.6,
            "displayMode": "always_visible",
            "dockType": "floating",
            "enabled": false,
            "floatingRatio": 1,
            "groupApps": false,
            "groupClickAction": "cycle",
            "groupContextMenuMode": "extended",
            "groupIndicatorStyle": "dots",
            "inactiveIndicators": false,
            "indicatorColor": "primary",
            "indicatorOpacity": 0.6,
            "indicatorThickness": 3,
            "launcherIcon": "",
            "launcherIconColor": "none",
            "launcherPosition": "end",
            "launcherUseDistroLogo": false,
            "monitors": [
            ],
            "onlySameOutput": true,
            "pinnedApps": [
            ],
            "pinnedStatic": false,
            "position": "bottom",
            "showDockIndicator": false,
            "showLauncherIcon": false,
            "sitOnFrame": false,
            "size": 1
        },
        "general": {
            "allowPanelsOnScreenWithoutBar": true,
            "allowPasswordWithFprintd": false,
            "animationDisabled": true,
            "animationSpeed": 1.5,
            "autoStartAuth": false,
            "avatarImage": "/home/robert/.face",
            "boxRadiusRatio": 1,
            "clockFormat": "hh\\nmm",
            "clockStyle": "custom",
            "compactLockScreen": false,
            "dimmerOpacity": 0.5,
            "enableBlurBehind": false,
            "enableLockScreenCountdown": true,
            "enableLockScreenMediaControls": false,
            "enableShadows": true,
            "forceBlackScreenCorners": true,
            "iRadiusRatio": 1,
            "keybinds": {
                "keyDown": [
                    "Down"
                ],
                "keyEnter": [
                    "Return",
                    "Enter"
                ],
                "keyEscape": [
                    "Esc"
                ],
                "keyLeft": [
                    "Left"
                ],
                "keyRemove": [
                    "Del"
                ],
                "keyRight": [
                    "Right"
                ],
                "keyUp": [
                    "Up"
                ]
            },
            "language": "en",
            "lockOnSuspend": true,
            "lockScreenAnimations": false,
            "lockScreenBlur": 0,
            "lockScreenCountdownDuration": 10000,
            "lockScreenMonitors": [
            ],
            "lockScreenTint": 0,
            "passwordChars": false,
            "radiusRatio": 1,
            "reverseScroll": false,
            "scaleRatio": 0.9500000000000001,
            "screenRadiusRatio": 1,
            "shadowDirection": "center",
            "shadowOffsetX": 0,
            "shadowOffsetY": 0,
            "showChangelogOnStartup": true,
            "showHibernateOnLockScreen": false,
            "showScreenCorners": true,
            "showSessionButtonsOnLockScreen": true,
            "smoothScrollEnabled": true,
            "telemetryEnabled": false
        },
        "hooks": {
            "colorGeneration": "",
            "darkModeChange": "",
            "enabled": false,
            "performanceModeDisabled": "",
            "performanceModeEnabled": "",
            "screenLock": "",
            "screenUnlock": "",
            "session": "",
            "startup": "",
            "wallpaperChange": ""
        },
        "idle": {
            "customCommands": "[]",
            "enabled": false,
            "fadeDuration": 5,
            "lockCommand": "",
            "lockTimeout": 660,
            "resumeLockCommand": "",
            "resumeScreenOffCommand": "",
            "resumeSuspendCommand": "",
            "screenOffCommand": "",
            "screenOffTimeout": 600,
            "suspendCommand": "",
            "suspendTimeout": 1800
        },
        "location": {
            "analogClockInCalendar": false,
            "autoLocate": false,
            "firstDayOfWeek": -1,
            "hideWeatherCityName": false,
            "hideWeatherTimezone": false,
            "name": "Perm",
            "showCalendarEvents": true,
            "showCalendarWeather": true,
            "showWeekNumberInCalendar": false,
            "use12hourFormat": false,
            "useFahrenheit": false,
            "weatherEnabled": true,
            "weatherShowEffects": true,
            "weatherTaliaMascotAlways": false
        },
        "network": {
            "bluetoothAutoConnect": true,
            "bluetoothDetailsViewMode": "grid",
            "bluetoothHideUnnamedDevices": false,
            "bluetoothRssiPollIntervalMs": 60000,
            "bluetoothRssiPollingEnabled": false,
            "disableDiscoverability": false,
            "networkPanelView": "wifi",
            "wifiDetailsViewMode": "grid"
        },
        "nightLight": {
            "autoSchedule": true,
            "dayTemp": "6500",
            "enabled": false,
            "forced": false,
            "manualSunrise": "06:30",
            "manualSunset": "18:30",
            "nightTemp": "4000"
        },
        "noctaliaPerformance": {
            "disableDesktopWidgets": true,
            "disableWallpaper": true
        },
        "notifications": {
            "backgroundOpacity": 1,
            "clearDismissed": true,
            "criticalUrgencyDuration": 15,
            "density": "compact",
            "enableBatteryToast": true,
            "enableKeyboardLayoutToast": false,
            "enableMarkdown": false,
            "enableMediaToast": false,
            "enabled": true,
            "location": "top_right",
            "lowUrgencyDuration": 3,
            "monitors": [
            ],
            "normalUrgencyDuration": 8,
            "overlayLayer": true,
            "respectExpireTimeout": false,
            "saveToHistory": {
                "critical": true,
                "low": true,
                "normal": true
            },
            "sounds": {
                "criticalSoundFile": "",
                "enabled": false,
                "excludedApps": "discord,firefox,chrome,chromium,edge",
                "lowSoundFile": "",
                "normalSoundFile": "",
                "separateSounds": false,
                "volume": 0.5
            }
        },
        "osd": {
            "autoHideMs": 2000,
            "backgroundOpacity": 1,
            "enabled": true,
            "enabledTypes": [
                0,
                1,
                2
            ],
            "location": "top",
            "monitors": [
            ],
            "overlayLayer": true
        },
        "plugins": {
            "autoUpdate": false,
            "notifyUpdates": true
        },
        "sessionMenu": {
            "countdownDuration": 10000,
            "enableCountdown": false,
            "largeButtonsLayout": "single-row",
            "largeButtonsStyle": false,
            "position": "top_center",
            "powerOptions": [
                {
                    "action": "shutdown",
                    "command": "",
                    "countdownEnabled": true,
                    "enabled": true,
                    "keybind": "1"
                },
                {
                    "action": "suspend",
                    "command": "",
                    "countdownEnabled": true,
                    "enabled": true,
                    "keybind": "2"
                },
                {
                    "action": "reboot",
                    "command": "",
                    "countdownEnabled": true,
                    "enabled": true,
                    "keybind": "3"
                },
                {
                    "action": "rebootToUefi",
                    "command": "",
                    "countdownEnabled": true,
                    "enabled": true,
                    "keybind": "4"
                },
                {
                    "action": "lock",
                    "command": "",
                    "countdownEnabled": true,
                    "enabled": true,
                    "keybind": "5"
                },
                {
                    "action": "hibernate",
                    "command": "",
                    "countdownEnabled": true,
                    "enabled": false,
                    "keybind": ""
                },
                {
                    "action": "logout",
                    "command": "",
                    "countdownEnabled": true,
                    "enabled": false,
                    "keybind": ""
                },
                {
                    "action": "userspaceReboot",
                    "command": "",
                    "countdownEnabled": true,
                    "enabled": false,
                    "keybind": ""
                }
            ],
            "showHeader": true,
            "showKeybinds": true
        },
        "settingsVersion": 59,
        "systemMonitor": {
            "batteryCriticalThreshold": 5,
            "batteryWarningThreshold": 20,
            "cpuCriticalThreshold": 90,
            "cpuWarningThreshold": 80,
            "criticalColor": "",
            "diskAvailCriticalThreshold": 10,
            "diskAvailWarningThreshold": 20,
            "diskCriticalThreshold": 90,
            "diskWarningThreshold": 80,
            "enableDgpuMonitoring": false,
            "externalMonitor": "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor",
            "gpuCriticalThreshold": 90,
            "gpuWarningThreshold": 80,
            "memCriticalThreshold": 90,
            "memWarningThreshold": 80,
            "swapCriticalThreshold": 90,
            "swapWarningThreshold": 80,
            "tempCriticalThreshold": 90,
            "tempWarningThreshold": 80,
            "useCustomColors": false,
            "warningColor": ""
        },
        "templates": {
            "activeTemplates": [
                {
                    "enabled": true,
                    "id": "niri"
                },
                {
                    "enabled": true,
                    "id": "btop"
                },
                {
                    "enabled": true,
                    "id": "yazi"
                },
                {
                    "enabled": true,
                    "id": "qt"
                },
                {
                    "enabled": true,
                    "id": "kitty"
                },
                {
                    "enabled": true,
                    "id": "pywalfox"
                },
                {
                    "enabled": true,
                    "id": "cava"
                },
                {
                    "enabled": true,
                    "id": "kcolorscheme"
                },
                {
                    "enabled": true,
                    "id": "discord"
                },
                {
                    "enabled": true,
                    "id": "gtk"
                },
                {
                    "enabled": true,
                    "id": "code"
                }
            ],
            "enableUserTheming": true
        },
        "ui": {
            "boxBorderEnabled": true,
            "fontDefault": "JetBrainsMono Nerd Font Mono",
            "fontDefaultScale": 1,
            "fontFixed": "JetBrainsMono Nerd Font Mono",
            "fontFixedScale": 1,
            "panelBackgroundOpacity": 1,
            "panelsAttachedToBar": true,
            "scrollbarAlwaysVisible": false,
            "settingsPanelMode": "attached",
            "settingsPanelSideBarCardStyle": true,
            "tooltipsEnabled": true,
            "translucentWidgets": false
        },
        "wallpaper": {
            "automationEnabled": false,
            "directory": "/home/robert/.config/wallpapers",
            "enableMultiMonitorDirectories": false,
            "enabled": true,
            "favorites": [
            ],
            "fillColor": "#000000",
            "fillMode": "crop",
            "hideWallpaperFilenames": false,
            "linkLightAndDarkWallpapers": true,
            "monitorDirectories": [
            ],
            "overviewBlur": 0.4,
            "overviewEnabled": false,
            "overviewTint": 0.6,
            "panelPosition": "top_center",
            "randomIntervalSec": 300,
            "setWallpaperOnAllMonitors": true,
            "showHiddenFiles": false,
            "skipStartupTransition": false,
            "solidColor": "#1a1a2e",
            "sortOrder": "name",
            "transitionDuration": 1500,
            "transitionEdgeSmoothness": 0.05,
            "transitionType": [
                "fade"
            ],
            "useOriginalImages": false,
            "useSolidColor": false,
            "useWallhaven": false,
            "viewMode": "single",
            "wallhavenApiKey": "",
            "wallhavenCategories": "110",
            "wallhavenOrder": "desc",
            "wallhavenPurity": "100",
            "wallhavenQuery": "",
            "wallhavenRatios": "",
            "wallhavenResolutionHeight": "",
            "wallhavenResolutionMode": "atleast",
            "wallhavenResolutionWidth": "",
            "wallhavenSorting": "relevance",
            "wallpaperChangeMode": "random"
        }
    }
  '';

  # === Шаблон Telegram (Физический файл) ===
  xdg.configFile."noctalia/templates/telegram.tdesktop-theme".text = ''
// Material You theme for Telegram Desktop
// Generated by Noctalia's Template Processor

COLOR_GRAY: {{colors.outline.default.hex}};
COLOR_DARK: {{colors.surface_variant.default.hex}};

windowBg: {{colors.background.default.hex}}; // Main background
sideMenuBg: {{colors.background.default.hex}}; // Фон узкой панели слева
sideMenuBgOver: {{colors.surface_variant.default.hex}}; // Фон панели при наведении
sideMenuFg: {{colors.on_surface.default.hex}}; // Цвет иконок (три полоски)
sideMenuFgOver: {{colors.on_surface_variant.default.hex}}; // Цвет иконок при наведении
sideBarBg: {{colors.background.default.hex}}; // Filters side bar background
sideBarBgActive: {{colors.primary_container.default.hex}}; // Filters side bar active
sideBarTextFgActive: {{colors.primary.default.hex}}; // Filters side bar active text
sideBarIconFgActive: {{colors.primary.default.hex}}; // Filters side bar active icon
sideBarBadgeBg: {{colors.primary.default.hex}}; // Filters side bar badge
sideBarTextFg: {{colors.on_surface.default.hex}}; // Filters side bar text
sideBarBadgeBgMuted: {{colors.surface_variant.default.hex}}; // Filters side bar unimp background
sideBarBgRipple: {{colors.surface_variant.default.hex}}; // Filters side bar ripple
sideBarIconFg: {{colors.on_surface_variant.default.hex}}; // Filters side bar icon
windowFg: {{colors.on_background.default.hex}}; // Main text
windowBgOver: {{colors.surface_variant.default.hex}}; // Generic background on hover
windowBgRipple: {{colors.surface_variant.default.hex}}; // Ripple effect
windowFgOver: {{colors.on_surface_variant.default.hex}}; // Text on hover
windowSubTextFg: {{colors.outline.default.hex}}; // Minor text
windowSubTextFgOver: {{colors.outline.default.hex}}; // Minor text on hover
windowBoldFg: {{colors.on_background.default.hex}}; // Bold text
windowBoldFgOver: {{colors.on_surface_variant.default.hex}}; // Bold text on hover
windowBgActive: {{colors.primary.default.hex}}; // Active items background
windowFgActive: {{colors.on_primary.default.hex}}; // Active items text
windowActiveTextFg: {{colors.primary.default.hex}}; // Active items text
windowShadowFg: {{colors.shadow.default.hex}}; // Window shadow
windowShadowFgFallback: {{colors.shadow.default.hex}}; // Fallback for shadow
historyOutIconFg: {{colors.primary.default.hex}};
historyIconFgInverted: {{colors.on_surface.default.hex}};
historyBg: {{colors.background.default.hex}}; // Chat background (solid color)
historyComposeAreaBg: {{colors.surface.default.hex}}; // Message input area
historyComposeAreaFg: {{colors.on_surface.default.hex}};
historyComposeAreaBorderFg: {{colors.outline.default.hex}};
historyScrollBg: {{colors.primary.default.hex}}40;
historyScrollBgOver: {{colors.primary.default.hex}}70;
historyUnreadBarBg: {{colors.primary.default.hex}};
historyUnreadBarFg: {{colors.on_primary.default.hex}};
historyToDownBg: {{colors.surface.default.hex}};
historyToDownBgOver: {{colors.surface_variant.default.hex}};
historyToDownFg: {{colors.on_surface.default.hex}};
historyReplyBg: {{colors.surface_variant.default.hex}};
historyReplyHoverBg: {{colors.surface_variant.default.hex}};
historyForwardChooseBg: {{colors.surface.default.hex}};
historyPinnedBg: {{colors.surface.default.hex}};
historyPinnedShadow: {{colors.shadow.default.hex}};

msgServiceBg: {{colors.primary_container.default.hex}};
msgServiceFg: {{colors.on_surface.default.hex}};
msgOutBg: {{colors.primary_container.default.hex}};
msgOutBgSelected : {{colors.tertiary_container.default.hex}};
msgOutServiceFg: {{colors.on_surface.default.hex}};
msgOutDateFg: {{colors.on_surface.default.hex}};
historySentIconFg: {{colors.on_surface.default.hex}};
msgOutDateFgSelected: {{colors.on_surface.default.hex}};
msgDateImgFg: {{colors.on_surface.default.hex}};
dialogsSentIconFg: {{colors.primary.default.hex}};
dialogsSentIconFgOver: {{colors.primary.default.hex}};
dialogsOnlineBadgeFg: {{colors.primary.default.hex}};

shadowFg: {{colors.shadow.default.hex}}; // General shadow
slideFadeOutBg: {{colors.background.default.hex}};
slideFadeOutShadowFg: {{colors.shadow.default.hex}};

imageBg: {{colors.surface.default.hex}};
imageBgTransparent: {{colors.surface.default.hex}};

activeButtonBg: {{colors.primary.default.hex}}; // Active button background
activeButtonBgOver: {{colors.primary_container.default.hex}}; // Active button hover background
activeButtonBgRipple: {{colors.on_primary_container.default.hex}}; // Active button ripple
activeButtonFg: {{colors.on_primary.default.hex}}; // Active button text
activeButtonFgOver: {{colors.on_primary_container.default.hex}}; // Active button hover text
activeButtonSecondaryFg: {{colors.on_primary.default.hex}}; // Active button secondary text
activeButtonSecondaryFgOver: {{colors.on_primary_container.default.hex}}; // Active button secondary hover text
activeLineFg: {{colors.on_surface.default.hex}};
dialogsBgActive: {{colors.primary.default.hex}};

lightButtonBg: {{colors.surface.default.hex}}; // Light button background
lightButtonBgOver: {{colors.surface_variant.default.hex}}; // Light button hover background
lightButtonBgRipple: {{colors.primary.default.hex}}; // Light button ripple
lightButtonFg: {{colors.on_surface.default.hex}}; // Light button text
lightButtonFgOver: {{colors.on_surface_variant.default.hex}}; // Light button hover text

attentionButtonFg: {{colors.error.default.hex}};
attentionButtonFgOver: {{colors.error.default.hex}};
attentionButtonBgOver: {{colors.error_container.default.hex}};
attentionButtonBgRipple: {{colors.on_error_container.default.hex}};

outlineButtonBg: {{colors.surface.default.hex}}; // Outline button background
outlineButtonBgOver: {{colors.surface_variant.default.hex}}; // Outline button hover background
outlineButtonOutlineFg: {{colors.primary.default.hex}}; // Outline button color
outlineButtonBgRipple: {{colors.primary.default.hex}}; // Outline button ripple

menuBg: {{colors.surface.default.hex}};
menuBgOver: {{colors.surface_variant.default.hex}};
menuBgRipple: {{colors.primary.default.hex}};
menuIconFg: {{colors.on_surface.default.hex}};
menuIconFgOver: {{colors.on_surface_variant.default.hex}};
menuSubmenuArrowFg: {{colors.outline.default.hex}};
menuFgDisabled: {{colors.outline.default.hex}};
menuSeparatorFg: {{colors.outline.default.hex}};

scrollBarBg: {{colors.primary.default.hex}}40; // Scroll bar background (40% opacity)
scrollBarBgOver: {{colors.primary.default.hex}}60; // Scroll bar hover background (60% opacity)
scrollBg: {{colors.surface_variant.default.hex}}40; // Scroll bar track (40% opacity)
scrollBgOver: {{colors.surface_variant.default.hex}}60; // Scroll bar track on hover (60% opacity)

smallCloseIconFg: {{colors.outline.default.hex}};
smallCloseIconFgOver: {{colors.on_surface_variant.default.hex}};

radialFg: {{colors.primary.default.hex}};
radialBg: {{colors.surface.default.hex}};

placeholderFg: {{colors.outline.default.hex}}; // Placeholder text
placeholderFgActive: {{colors.primary.default.hex}}; // Active placeholder text
inputBorderFg: {{colors.outline.default.hex}}; // Input border
filterInputBorderFg: {{colors.outline.default.hex}}; // Search input border
filterInputInactiveBg: {{colors.surface.default.hex}}; // Inactive search input background
checkboxFg: {{colors.primary.default.hex}}; // Checkbox color

titleBg: {{colors.surface.default.hex}}; // Window title background
titleShadow: {{colors.shadow.default.hex}};
titleButtonFg: {{colors.on_surface.default.hex}}; // Title button color
titleButtonBgOver: {{colors.surface_variant.default.hex}}; // Title button hover background
titleButtonFgOver: {{colors.on_surface_variant.default.hex}}; // Title button hover color
titleButtonCloseBgOver: {{colors.error.default.hex}};
titleButtonCloseFgOver: {{colors.on_error.default.hex}};
titleFgActive: {{colors.on_surface.default.hex}}; // Active title text
titleFg: {{colors.on_surface.default.hex}}; // Inactive title text

trayCounterBg: {{colors.error.default.hex}}; // Tray counter background
trayCounterBgMute: {{colors.outline.default.hex}}; // Muted tray counter background
trayCounterFg: {{colors.on_error.default.hex}}; // Tray counter text
trayCounterBgMacInvert: {{colors.error.default.hex}}; // Mac tray counter
trayCounterFgMacInvert: {{colors.on_error.default.hex}}; // Mac tray counter text

layerBg: {{colors.surface.default.hex}}99; // Layer background (60% opacity)

cancelIconFg: {{colors.error.default.hex}}; // Cancel icon
cancelIconFgOver: {{colors.error.default.hex}}; // Cancel icon on hover

boxBg: {{colors.surface.default.hex}}; // Box background
boxTextFg: {{colors.on_surface.default.hex}}; // Box text
boxTextFgGood: {{colors.primary.default.hex}}; // Box good text
boxTextFgError: {{colors.error.default.hex}}; // Box error text
boxTitleFg: {{colors.on_surface.default.hex}}; // Box title text
boxSearchBg: {{colors.surface.default.hex}}; // Box search field background
boxSearchCancelIconFg: {{colors.error.default.hex}}; // Box search cancel icon
boxSearchCancelIconFgOver: {{colors.error.default.hex}}; // Box search cancel icon on hover

contactsBg: {{colors.surface.default.hex}}; // Contacts background
contactsBgOver: {{colors.surface_variant.default.hex}}; // Contacts background on hover
contactsNameFg: {{colors.on_surface.default.hex}}; // Contact name
contactsStatusFg: {{colors.outline.default.hex}}; // Contact status
contactsStatusFgOver: {{colors.on_surface_variant.default.hex}}; // Contact status on hover
contactsStatusFgOnline: {{colors.primary.default.hex}}; // Online contact status

photoCropFadeBg: {{colors.surface.default.hex}}cc; // Photo crop fade background
photoCropPointFg: {{colors.primary.default.hex}}; // Photo crop points

chat_inBubbleSelected: {{colors.surface_variant.default.hex}}; // inbox selected chat background
chat_outBubbleSelected: {{colors.tertiary_container.default.hex}}; // outbox selected chat background
  '';

  # === user-templates.toml ===
  xdg.configFile."noctalia/user-templates.toml".text = ''
    [templates.nvim-base16]
    input_path = "~/.config/nvim/lua/matugen-template.lua"
    output_path = "~/.config/nvim/lua/matugen.lua"
    post_hook = 'pkill -SIGUSR1 nvim'

    [templates.telegram]
    input_path = "~/.config/noctalia/templates/telegram.tdesktop-theme"
    output_path = "/home/robert/.config/telegram-desktop/themes/noctalia.tdesktop-theme"
  '';
}
