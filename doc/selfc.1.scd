selfc(1)

# NAME
selfc - start new terminals in a self server

# SYNOPSIS
*selfc* [_OPTIONS_]++
*selfc* [_OPTIONS_] <_command_> [_COMMAND OPTIONS_]

All trailing (non-option) arguments are treated as a command, and its
arguments, to execute (instead of the default shell).

# DESCRIPTION

*selfc* is used together with *self*(1) in *--server*
mode.

Running it without arguments will open a new terminal window (hosted
in the self server), with your default shell. The exit code will be
that of the terminal. I.e *selfc* does not exit until the
terminal has terminated.

# OPTIONS

*-t*,*--term*=_TERM_
	Value to set the environment variable *TERM* to (see *TERMINFO*
	and *ENVIRONMENT*). Default: _@default_terminfo@_.

*-T*,*--title*=_TITLE_
	Initial window title. Default: _self_.

*-a*,*--app-id*=_ID_
	Value to set the *app-id* property on the Wayland window
	to. Default: _self_ (normal mode), or _selfc_ (server mode).

*-w*,*--window-size-pixels*=_WIDTHxHEIGHT_
	Set initial window width and height, in pixels. Default: _700x500_.

*-W*,*--window-size-chars*=_WIDTHxHEIGHT_
	Set initial window width and height, in characters. Default: _not set_.

*-m*,*--maximized*
	Start in maximized mode. If both *--maximized* and *--fullscreen*
	are specified, the _last_ one takes precedence.

*-F*,*--fullscreen*
	Start in fullscreen mode. If both *--maximized* and *--fullscreen*
	are specified, the _last_ one takes precedence.

*-L*,*--login-shell*
	Start a login shell, by prepending a '-' to argv[0].

*-D*,*--working-directory*=_DIR_
	Initial working directory for the client application. Default:
	_CWD of selfc_.

*-s*,*--server-socket*=_PATH_
	Connect to _PATH_ instead of
	*$XDG\_RUNTIME\_DIR/self-$WAYLAND\_DISPLAY.sock*.

*-H*,*--hold*
	Remain open after child process exits.

*-N*,*--no-wait*
	Detach the client process from the running terminal, exiting
	immediately.

*-o*,*--override*=[_SECTION_.]_KEY_=_VALUE_
	Override an option set in the configuration file. If _SECTION_ is not
	given, defaults to _main_.

*-E*,*--client-environment*
	The child process in the new terminal instance will use
	selfc's environment, instead of the server's.

	Environment variables listed in the *Variables set in the child
	process* section will be overwritten by the self server. For
	example, the new terminal will use *TERM* from the configuration,
	not selfc's environment.

*-d*,*--log-level*={*info*,*warning*,*error*,*none*}
	Log level, used both for log output on stderr as well as
	syslog. Default: _warning_.

*-l*,*--log-colorize*=[{*never*,*always*,*auto*}]
	Enables or disables colorization of log output on stderr.

*-v*,*--version*
	Show the version number and quit

*-e*
	Ignored; for compatibility with *xterm -e*. See *self*(1) for more
	details.

# EXIT STATUS

Selfc will exit with code 220 if there is a failure in selfc
itself (for example, the server socket does not exist).

If *-N*,*--no-wait* is used, selfc exits with code 0 as soon as
the self server has been instructed to open a new window.

If not, selfc may also exit with code 230. This indicates a
failure in the self server.

In all other cases the exit code is that of the client application
(i.e. the shell).

# TERMINFO

Client applications use the terminfo identifier specified by the
environment variable *TERM* (set by self) to determine terminal
capabilities.

Self has two terminfo definitions: *self* and *self-direct*, with
*self* being the default.

The difference between the two is in the number of colors they
describe; *self* describes 256 colors and *self-direct* 16.7 million
colors (24-bit truecolor).

Note that using the *self* terminfo does not limit the number of
usable colors to 256; applications can still use 24-bit RGB colors. In
fact, most applications work best with *self* (including 24-bit
colors)). Using *\*-direct* terminfo entries has been known to crash
some ncurses applications even.

There are however applications that need a *\*-direct* terminfo entry
for 24-bit support. Emacs is one such example.

While using either *self* or *self-direct* is strongly recommended, it
is possible to use e.g. *xterm-256color* as well. This can be useful
when remoting to a system where self's terminfo entries cannot easily
be installed.

Note that terminfo entries can be installed in the user's home
directory. I.e. if you do not have root access, or if there is no
distro package for self's terminfo entries, you can install self's
terminfo entries manually, by copying *self* and *self-direct* to
*~/.terminfo/s/*.

# ENVIRONMENT

## Variables used by selfc

*XDG\_RUNTIME\_DIR*
	Used to construct the default _PATH_ for the *--server-socket*
	option, when no explicit argument is given (see above).

*WAYLAND\_DISPLAY*
	Used to construct the default _PATH_ for the *--server-socket*
	option, when no explicit argument is given (see above).

If the socket at default _PATH_ does not exist, *selfc* will
fallback to the less specific path, with the following priority:
*$XDG\_RUNTIME\_DIR/self-$WAYLAND\_DISPLAY.sock*,
*$XDG\_RUNTIME\_DIR/self.sock*, */tmp/self.sock*.

## Variables set in the child process

*TERM*
	terminfo/termcap identifier. This is used by client applications
	to determine which capabilities a terminal supports. The value is
	set according to either the *--term* command-line option or the
	*term* config option in *self.ini*(5).

*COLORTERM*
	This variable is set to *truecolor*, to indicate to client
	applications that 24-bit RGB colors are supported.

*PWD*
	Current working directory (at the time of launching self)

*SHELL*
	Set to the launched shell, if the shell is valid (it is listed in
	*/etc/shells*).

In addition to the variables listed above, custom environment
variables may be defined in *self.ini*(5).

## Variables *unset* in the child process

*TERM_PROGRAM*
*TERM_PROGRAM_VERSION*
	These environment variables are set by certain other terminal
	emulators. We unset them, to prevent applications from
	misdetecting self.

In addition to the variables listed above, custom environment
variables to unset may be defined in *self.ini*(5).

# SEE ALSO

*self*(1)
