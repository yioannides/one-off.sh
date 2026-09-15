<b>one-off.sh</b> is a small collection of mildly useful one-off bash scripts

-----

## directory:

#### ableton-live-dl.sh:

a command-line tool for downloading Ableton Live binaries
(supports Intro, Lite, Standard, Suite)

flags (required):

- `--intro`: downloads the latest Intro version
- `--lite`: downloads the latest Lite version
- `--standard`: downloads the latest Suite version
- `--suite`: downloads the latest Suite version

Example: `./ableton-live-dl.sh --suite`

Optionally, you can also download older versions of Live, like:

```sh
~ ⟶ ./ableton-live-dl.sh --suite 11.3.2
Searching for: 11.3.2
Downloading Ableton Live 11.3.2...
...
```

#### adwcolors.sh:

a simple terminal script for displaying the Adwaita color palette for GNOME

![showcase](https://github.com/user-attachments/assets/cec02629-ec81-48c6-863e-4986ea9187e2)

