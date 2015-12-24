# RMaze
Ruby library and tool for 2D maze generation

[![Gem Version](https://img.shields.io/gem/v/rmaze.png)](https://rubygems.org/gems/rmaze)
[![Build Status](http://travis-ci.org/pedrohml/rmaze.png)](http://travis-ci.org/pedrohml/rmaze)
[![Coverage Status](https://img.shields.io/coveralls/pedrohml/rmaze.png)](https://coveralls.io/github/pedrohml/rmaze)
[![Security](http://hakiri.io/github/pedrohml/rmaze/master.svg)](https://hakiri.io/github/pedrohml/rmaze/master)
[![License](https://img.shields.io/github/license/pedrohml/rmaze.png)](https://github.com/pedrohml/rmaze/blob/master/LICENSE.txt)

#### Description
This simple library/tool generates 2D mazes with customizable dimensions.

#### Tool usage
The **rmaze** is in initial version and its simple to use

```
Usage: rmaze [options]

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
