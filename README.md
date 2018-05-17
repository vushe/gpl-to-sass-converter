# GPL-TO-SASS CONVERTER

This script is used for conversion of `gpl` palette into [`sass`](https://sass-lang.com/) file. It can be useful for front-end developers.

Colors in output `sass` file are named (if name is present in original `gpl`) and are hexadecimal (e.g. `$WHITE: #ffffff;`). 

Script can be primarily utilized with [GPick](http://www.gpick.org/) tool, which allows generating `gpl` files. Script can be also utilized for conversion of GIMP or Inkscape `gpl`-palette files into `sass`, however, variable names can be missing if they are not specified in original `gpl` files.

Script is tested under Ubuntu 16.04.


Usage:

```

    ./gpl-to-sass /path/to/file.gpl

```

Generated `file.sass` is placed in source folder.
