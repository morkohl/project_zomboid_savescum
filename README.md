# 💾 Zomboid Save Scum

**Save responsibly. Scum efficiently.**

A tiny Windows tool that automatically backs up your **Project Zomboid** saves — no mods, no configs, no shame.  
Pick your save from a simple menu, and it clones it into a timestamped backup folder.  
Because sometimes you just want to *un-die*.

---

## 🧠 What It Does

When you run **Zomboid Save Scum**, it:

1. Finds your Zomboid save directory (`C:\Users\<you>\Zomboid\Saves`).
2. Lists all your saves (e.g. `Apocalypse\Current`, `Builder\MyBase`).
3. Lets you choose one by number.
4. Copies that save into  
   `Zomboid\Saves\Backups\<gamemode>\<save>_<timestamp>`  

Example:  
Backing up `Apocalypse\Current` at 20:15 on Oct 20 2025 →  
`Zomboid\Saves\Backups\Apocalypse\Current_20-10-2025_20-15`

---

## 🚀 How to Use

After installation, open the **Start Menu** → type **“Zomboid Save Scum”** → hit Enter.

You’ll see something like:

```

[0] Apocalypse\Current
[1] Apocalypse\Old
[2] Builder\Current

Please select the save you want to backup:

```

Type a number, press **Enter**, and your backup is created.

---

## 🔁 Restoring a Backup

Backups are just normal folders — no magic.

1. Go to  
   `C:\Users\<you>\Zomboid\Saves\Backups\`
2. Open the folder of the backup you want (e.g. `Apocalypse\Current_24-10-2025_22-15`).
3. Copy its contents.
4. Paste them back into  
   `C:\Users\<you>\Zomboid\Saves\Apocalypse\Current`
5. Start the game — you’re back where you left off (or before you got eaten).

---

## ⚙️ Requirements

- Windows 10 or 11  
- PowerShell 5 or newer (already included)  
- A `Zomboid\Saves` folder — just start the game once

---

## 🧩 Installation

1. Download the installer:  
   👉 [**Get install_savescum.bat from the Release page**](https://github.com/morkohl/project_zomboid_savescum/releases)

2. Double-click `install_savescum.bat`.

It will:
- Check your Zomboid save folder exists.  
- Download the PowerShell script and icon.  
- Add a **Start Menu shortcut** called **“Zomboid Save Scum.”**

> ⚠️ If the save folder doesn’t exist, start the game once and rerun the installer.

---

## 🧹 Uninstall

Delete these files:

```
C:\Users\<you>\Zomboid\Saves\SaveScum.ps1
C:\Users\<you>\Zomboid\Saves\savescum.ico
%AppData%\Microsoft\Windows\Start Menu\Programs\Zomboid Save Scum.lnk
```

That’s it. You're done

---

## 🔒 Safety

SmartScreen might warn you the first time — that’s normal for unsigned scripts.  
You can safely click **“More info → Run anyway.”**

Everything runs locally; it just copies files.

---

## 🪪 License

MIT License — because your saves deserve the same freedom as your bad decisions.
