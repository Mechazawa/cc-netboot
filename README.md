ComputerCraft Netboot
---------------------
Utillity for booting computercraft computers using a network source.

This script was quickly put together so I could more easilly develop my own applications. 

## Usage
The script downloads files from a HTTP server so you'll need to set one up and place a `listing.txt` in the same directory as your source files. The listing file contains all the relative file paths that need to be downloaded before the device boots.

After that a startup script needs to be made that points to the base url where the `listing.txt` file is located.

```lua
require("netboot")(
  "boot" -- Where the downloaded files should be placed
  "http://172.16.0.123:8000/", -- Base url where the files are located
  {}, -- Optional HTTP headers used during the requests, usefull for authentication etc
  true, -- If the download directory should be purged before downloading scripts, defaults to false
)
```
