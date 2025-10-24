# 💾 Zomboid Save Scum

**Save responsibly. Scum efficiently.**

A Windows App that automatically back up your **Project Zomboid** saves.
Pick your save from a simple menu, and it clones it into a timestamped backup folder.  
Because sometimes you just want to make sure you can *un-die*.

---

## 🧠 What It Does

When you run **Zomboid Save Scum**, it:

1. Finds your Zomboid save folder (`C:\Users\<you>\Zomboid\Saves`).
2. Lists all your saves.
3. Lets you choose one by number.
4. Copies that save into  
   `C:\Users\<you>\Zomboid\Saves\Backups\<gamemode>\<save>_<timestamp>`  

---

## 🚀 How to Use

> ⚠️ Make sure your pause your game before running the script. Otherwise, the backup might become inconsistent to actual game state or invalidate your save!

After installation, open the **Start Menu** → type **“Zomboid Save Scum”** → hit Enter.

You’ll see something like:

```

[0] Apocalypse\Current
[1] Apocalypse\Old
[2] Builder\Current

Please select the save you want to backup:

```

The output shows the menu number, game mode and save name of the save.

`[0] Apocalypse\Current`
> Save -> `Current` in Game mode -> `Apocalypse`

Type a number, press **Enter**, and your backup is created.

### Example

Putting in the number `0` and pressing enter will backup your save `Apocalypse\Current`to the following folder:

`Zomboid\Saves\Backups\Apocalypse\Current_20-10-2025_20-15`

Assuming it was started af 20:15 on Oct 20 2025 (20-10-2025_20-15).

---

## 🔁 Restoring a Backup

In Project Zomboid, a save is contained inside a folder. That means we can just copy the backup folder into our game mode saves.

1. Go to  
   `C:\Users\<you>\Zomboid\Saves\Backups\`
2.  Selext the folder of the backup you want (e.g. `Apocalypse\Current_20-10-2025_20-15`).
3. Copy the folder
4. Paste the folder into  
   `C:\Users\<you>\Zomboid\Saves\Apocalypse`

You're done and you can keep on playing!

> Make sure you copy it into the correct game mode save folder.

---

## ⚙️ Requirements

- Windows 10 or 11   
- A `Zomboid\Saves` folder — just start the game once

---

## 🧩 Installation

1. Download the installer:  
   👉 [**Get install_savescum.bat from the Release page**](https://github.com/morkohl/project_zomboid_savescum/releases)

2. Double-click `install_savescum.bat`.

It will:
- Check your Zomboid save folder exists.
- Add a **Start Menu shortcut** called **“Zomboid Save Scum.”**

> ⚠️ If the save folder doesn’t exist, start the game once, then rerun the installer.

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
