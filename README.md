MESAgrids
=========

development interface for grid layout with the MESA stellar evolution code

Features
--------

*   The character size is specified independently of the viewing area size. Thus, if you resize the plot (going from desktop to laptop, e.g.) the text will remain at the same size.

*   Padding around the plots is specified in units of the character size ("em"). This takes some of the guesswork out of how much space to leave around plots.

*   The legend line length is also given in terms of character size.  There are options to control the spacing between lines, as well as the top and left margin (given in units of em).

*   The grid allows for offsets between columns and rows.  These are fixed (given in units of px for now), and therefore do not change with the size of the viewing area.

Installation
------------

1.  Install the mesasdk and MESA, and set the MESA_DIR environment variable
2.  Run `./build_and_test`; the output is in `test/test_grid.png`.
3.  Look at doc/about_grid.html for a description of the controls.
4.  To generate the images in the documentation, `cd test; ./rn`

TODO
---

1.  Primitive routines take xleft, xright, ytop, ybottom (norm. coord.) and a text size (px).  Locate viewport by applying margins (in fractional size of plotting area) and then applying padding (in em).

2.  Legend specified by left-side and top-side.  Lines, text located relative to this with topskip, left_margin (in em).
