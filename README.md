# GPL-TO-SASS CONVERTER

This script is used for conversion of `gpl` palette to `sass` file. Colors in `sass` file will be stored in `hex` (e.g. `#ffffff`). 

Script can be primarily utilized with [GPick](http://www.gpick.org/) tool, which allows generating `gpl` files. Script can be also utilized with GIMP and Inkscape, however, variable names can be missing if they are not specified in original `gpl` files.


Script is tested under Ubuntu 16.04.


Usage:

```

    ./gpl-to-sass /path/to/file.gpl

```

Generated `file.sass` is placed in source folder.
