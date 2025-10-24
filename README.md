# 💾 Zomboid Save Scum

**Save responsibly. Scum efficiently.**

This is a tiny PowerShell utility that automates **Project Zomboid save-backups** — a polite way of saying it helps you *save scum* without shame or tedious file copying.  
You get a neat numbered menu of your save worlds, pick one, and it clones the selected save into a timestamped backup folder.  

It’s simple, local, and designed for people who’d rather survive the apocalypse *their way*.

---

## 🧠 What It Does

When you run **Zomboid Save Scum**, it:

1. Finds your Project Zomboid save directory (usually `C:\Users\<you>\Zomboid\Saves`).
2. Lists all saves by mode and name (e.g. `Apocalypse\MySave`, `Builder\MySave`, etc.).
3. Lets you pick one by number.
4. Creates a backup inside `Zomboid\Saves\Backups` of your save directory, automatically timestamped.
   - This means if you want to backup the save `MySave` in the game mode `Apocalypse`
   - The backup will be located at `Zomboid\Saves\Backups\Apocalypse\MySave_20-10-2025_20-15` (given you backup on the 20.10.2025 at 20:15)
6. Copies the selected save there using PowerShell’s native file copy.

## 

---

## 🧩 Example Usage

Go to the **Windows Start Menu** (Windows Button) and type `Zomboid Save Backup`. 

If the installation was successfull, the app should have been found.

Run it.

Running it will prompt you to select a save:

```
[0] Apocalypse\Current
[1] Apocalypse\Old
[2] Builder\Current

Please select the save you want to backup: 
```

You type:

```
0
```

The util will now backup the save `Current` which you played in the game mode `Apocalypse`

---

Excellent finishing touch — a proper README should show both **how to save** *and* **how to unsave your mistakes.**

Here’s a small, self-contained section you can append to the bottom of your existing README:

---

## 🔁 Restoring a Backup

Need to undo an unfortunate zombie encounter? No problem — backups are just normal folders.

Each time you run Save Scum, a timestamped copy of your selected save is created in:

`C:\Users<you>\Zomboid\Saves\Backups\`

### 🪄 To restore:

1. Open the **Backups** folder.
2. Find the backup you want to restore (e.g. `Apocalypse\Current_24-10-2025_22-15`).
3. Copy that folder’s contents.
4. Paste them back into your active save directory, replacing the existing files:
5. Start Project Zomboid — your restored world will load as it was at that moment in time.

## ⚙️ Requirements

* Windows 10 or 11
* PowerShell (built-in, version 5 or newer)
* An existing `Zomboid\Saves` directory (just run the game once)

No admin rights required.
The installer and script only modify files inside your own user profile.

---

## 🚀 Installation (2 minutes)

1. Download the installer:  
   👉 [**Download install_savescum.bat from the Release page**](https://github.com/morkohl/project_zomboid_savescum/releases)

2. Double-click the file `install_savescum.bat` after download.

3. It will:
   - Check that your Zomboid save folder exists.  
   - Download `SaveScum.ps1` and `savescum.ico`.  
   - Create a **Start Menu shortcut** called **“Zomboid Save Scum”**.

4. When finished, open your **Start Menu**, type “Zomboid Save Scum”, and run it like any app.

> ⚠️ If you’ve never run Project Zomboid before, open it once first — the save directory must exist before installation.

---

## 🧹 Uninstalling

Want to repent your scumming ways?

1. Delete:

   ```
   C:\Users\<you>\Zomboid\Saves\SaveScum.ps1
   C:\Users\<you>\Zomboid\Saves\savescum.ico
   ```
2. Delete the shortcut:

   ```
   %AppData%\Microsoft\Windows\Start Menu\Programs\Zomboid Save Scum.lnk
   ```

You're done.

---

## 🔒 Safety & Transparency

This project is **fully open source**.
You can read every line of both the PowerShell and installer scripts.
They don’t collect data, change settings, or do anything beyond copying files.

SmartScreen may warn you when you run the `.bat` — this is normal for unsigned scripts.
Click **“More info → Run anyway.”**

---

## 🧙 Author’s Note

This isn’t a cheat — it’s *temporal insurance*.
If you’ve ever tripped over a zombie and lost 40 hours of progress, you understand.
SaveScum doesn’t judge you. It just quietly keeps a record of your better decisions.

---

## 🪪 License

MIT License — because you should be as free to back up your saves as the undead are to eat your face.
