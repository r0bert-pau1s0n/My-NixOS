function flush_preferences() {
  if (section != "Preferences")
    return

  if (!written["General\\UseCustomUITheme"])
    print "General\\UseCustomUITheme=true"

  if (!written["General\\CustomUIThemePath"])
    print "General\\CustomUIThemePath=" theme_path
}

function flush_add_dialog() {
  if (section == "AddNewTorrentDialog" && !written["Attached"]) {
    print "Attached=true"
    written["Attached"] = 1
  }
}

/^[[:space:]]*\[/ {
  flush_preferences()
  flush_add_dialog()

  section = $0
  sub(/^[[:space:]]*\[/, "", section)
  sub(/\][[:space:]]*$/, "", section)

  if (section == "Preferences")
    seen_preferences = 1

  if (section == "AddNewTorrentDialog")
    seen_add_dialog = 1

  delete written
  print
  next
}

section == "Preferences" && $0 ~ /^[[:space:]]*General\\UseCustomUITheme[[:space:]]*=/ {
  print "General\\UseCustomUITheme=true"
  written["General\\UseCustomUITheme"] = 1
  next
}

section == "Preferences" && $0 ~ /^[[:space:]]*General\\CustomUIThemePath[[:space:]]*=/ {
  print "General\\CustomUIThemePath=" theme_path
  written["General\\CustomUIThemePath"] = 1
  next
}

section == "Preferences" && $0 ~ /^[[:space:]]*AddNewTorrentDialog\\Attached[[:space:]]*=/ {
  next
}

section == "AddNewTorrentDialog" && $0 ~ /^[[:space:]]*Attached[[:space:]]*=/ {
  print "Attached=true"
  written["Attached"] = 1
  next
}

{
  print
}

END {
  flush_preferences()
  flush_add_dialog()

  if (!seen_preferences) {
    print "[Preferences]"
    print "General\\UseCustomUITheme=true"
    print "General\\CustomUIThemePath=" theme_path
  }

  if (!seen_add_dialog) {
    print "[AddNewTorrentDialog]"
    print "Attached=true"
  }
}
