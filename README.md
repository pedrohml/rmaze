# RMaze
Ruby library and tool for 2D maze generation

[![Build Status](http://travis-ci.org/pedrohml/rmaze.svg?branch=master)](http://travis-ci.org/pedrohml/rmaze)
[![Security](http://hakiri.io/github/pedrohml/rmaze/master.svg)](https://hakiri.io/github/pedrohml/rmaze/master)

#### Description
This simple library/tool generates 2D mazes with customizable dimensions.

#### Tool usage
The **rmaze** is in initial version and its simple to use

```
Usage: rmaze.rb [options]

Basic options:
    -w, --width width                Specify the maze width (default: 10)
	-h, --height height              Specify the maze height (default: 10)

Algorithms:
	-b, --backtrace                  Choose backtrace algorithm (default)
```

#### Tool usage examples

Default usage (*width=10, height=10*)
```
> rmaze

# # # # # # # # # # # # # # # # # # # # #
#           #                           #
# # #   #   # # # # # # #   # # # # # # #
#       #           #       #           #
#   # # # # # # #   #   # # #   # # #   #
#   #       #           #       #       #
#   #   #   #   # # # # #   # # #   #   #
#       #   #   #       #   #       #   #
#   # # #   # # #   #   #   #   # # #   #
#   #   #           #       #       #   #
#   #   # # # # # # # # # # # # #   #   #
#       #                           #   #
#   # # #   # # # # # # # # # # # # #   #
#   #       #           #           #   #
#   #   #   #   # # #   #   # # #   # # #
#   #   #   #   #   #   #   #   #       #
#   #   #   #   #   #   #   #   # # # # #
#   #   #   #       #       #           #
#   #   # # # # #   # # # # #   # # #   #
#   #                           #       #
# # # # # # # # # # # # # # # # # # # # #
```

Generate mazes with customized dimensions (*width=5, height=2*)
```
> rmaze -w 5 -h 2

# # # # # # # # # # #
#                   #
#   # # #   # # # # #
#       #           #
# # # # # # # # # # #
```

Enjoy !
