# RMaze
Ruby library for multidimensional maze generation

[![Gem Version](https://img.shields.io/gem/v/rmaze.svg)](https://rubygems.org/gems/rmaze)
[![Build Status](https://img.shields.io/travis/pedrohml/rmaze/master.svg)](http://travis-ci.org/pedrohml/rmaze)
[![Coverage Status](https://img.shields.io/coveralls/pedrohml/rmaze.svg)](https://coveralls.io/github/pedrohml/rmaze)
[![Security](http://hakiri.io/github/pedrohml/rmaze/master.svg)](https://hakiri.io/github/pedrohml/rmaze/master)
[![License](https://img.shields.io/github/license/pedrohml/rmaze.svg)](https://github.com/pedrohml/rmaze/blob/master/LICENSE.txt)

#### Description
This library generates multidimensional mazes.

- What the purpose ? Mainly, games.
- What do I want Nth-d mazes for ? I do not know yet.

#### Tool usage
The tool **rmaze** is in initial version and only supports bidimensional mazes.

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
