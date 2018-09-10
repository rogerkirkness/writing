---
layout: post
title: Bloatware
date: September 2018
---
I don't like that phones come with useless apps. The manufacturer and the OS providers know they are useless, so why do they include them? I found a way to safely remove unused apps from an Android phone, even the annoying ones that they don't let you delete, that won't destroy your phone (if you do it right) and does work. It only works if you delete stuff that isn't important, so Google the name of the app before you do it and keep a backup.

1. Go to Settings > About Phone > Tap 'Build Number' 7 times.

2. Go to (new) Developer Options, and turn on 'USB Debugging'

3. Plug your phone into your computer with a USB cable.

4. Open a Terminal (or Command Prompt on Windows).

5. Download and install Android Debug Bridge from Android.

6. Type `$ adb version` to confirm the install worked.

7. Type `$ adb shell` to open a shell to your phone.

8. Type `$ pm list packages` to sell all the stuff on your phone.

9. Look for unwanted apps. When you find one, type `$ pm uninstall -k --user 0 (app_name)`

10. Example: `$ pm uninstall -k --user 0 com.google.android.gm` (Gmail)

To do it, you need an Android phone. It needs to have USB debugging active and be plugged into your computer. And you need to download the ADB tool from the Android website. If you do the above, it will remove any app. It doesn't permanently delete them, but it hides it from the main user, which is close enough. If you somehow mess it up (like I did the first time getting overzealous), hold the on button + volume up and recover it.