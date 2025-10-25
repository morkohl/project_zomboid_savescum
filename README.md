# 💾 Zomboid Save Scum

**Save responsibly. Scum efficiently.**

A simple **Powershell** helper for **Windows** to easily save and restore your Project Zomboid save games.

---

## 🧠 What It Does

When you run **Zomboid Save Scum** you can do some actions:

1. backup latest save - backup your latest save game
3. backup a save - backup one of your saves
4. restore a backup - restore a save by choosing one of your backups to restore

---

## 🚀 How to Use

> ⚠️ Make sure your pause your game before running the script. Otherwise, the backup might become inconsistent to actual game state or invalidate your save!

After installation, open the **Start Menu** → type **“Zomboid Save Scum”** → hit Enter.

You’ll see something the main menu:

<img width="709" height="518" alt="image" src="https://github.com/user-attachments/assets/fc41aea2-d35a-4e2f-82d6-b1dc8f1a3429" />

In this example, I want to backup my latest save. So I press `0` for the prompt and press `Enter`.

Next, I get asked if I want to proceed. I also get displayed some helpful information about the save itself.

<img width="703" height="374" alt="image" src="https://github.com/user-attachments/assets/700ca13b-42ac-4bfc-ba7b-6f4c02fcb03d" />

If I want to continue, I press `y`. If I don't, I press `n`. If I want to go back to the main menu I press `b`. If I want to quit, I press `q`.

This is the gist of the UI. The rest should be self explanatory. Go ahead and try it!

---

## 🔁 Restoring a Backup

In order to restore one of your backups, open the **Start Menu** → type **“Zomboid Save Scum”** → hit Enter.

In the main menu, press `2` (restore a backup), then hit `Enter`.

You will see a game mode selection. Select the game mode you want to restore a backup from (in this case `Apocalypse` -> `0`, then `Enter`).

<img width="702" height="421" alt="image" src="https://github.com/user-attachments/assets/fc4a32d1-e938-458f-aabd-24163f3f5bbd" />

Next, you will see all backups that exist for that game mode. 

The options displayed show the original file name and the time it was created at.

<img width="378" height="203" alt="image" src="https://github.com/user-attachments/assets/c35309fc-591c-4732-822e-885e523dd90a" />

Select the backup you want to restore (in this case `Current` -> `0`, then `Enter`).

Next, Save Scum will show you what it will do and will ask you to proceed.

If you want to continue, I press `y`. If I don't, I press `n`. If I want to go back to the main menu I press `b`. If I want to quit, I press `q`.

<img width="893" height="416" alt="image" src="https://github.com/user-attachments/assets/9f7e71ec-9fbb-40a8-8ab3-5d09a5670701" />

## ⚙️ Requirements

- Windows 10 or 11   
- A `Zomboid\Saves` folder — just start the game once

---

## Future Updates and Roadmap

- Will add a cleanup feature in the future to remove old backups by different cleanup modes

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
