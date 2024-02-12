/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static const unsigned int alpha = 0xe6;     /* Amount of opacity. 0xff if opaque.           */
static int centered = 1;                    /* -c option; centers dmenu on screen */
static int min_width = 500;                    /* minimum width when centered */
static int fuzzy = 1;                      /* -F  option; if 0, dmenu doesn't use fuzzy matching     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static char font[] = "monospace:size=10";
static const char *fonts[] = {
    font,
	"monospace:size=10",
};
static char *prompt      = NULL;      /* -p  option; prompt to the left of input field */

static char normfgcolor[] = "#bbbbbb";
static char normbgcolor[] = "#222222";
static char selfgcolor[]  = "#eeeeee";
static char selbgcolor[]  = "#005577";
static char bordercolor[] = "#388697";
static char *colors[SchemeLast][2] = {
	/*                  fg              bg          */
    [SchemeNorm]    = { normfgcolor,    normbgcolor },
    [SchemeSel]     = { selfgcolor,     selbgcolor  },
    [SchemeOut]     = { "#000000",      "#00ffff"   },
    [SchemeBorder]  = { bordercolor,    NULL        },
};

static const unsigned int alphas[SchemeLast][2] = {
	[SchemeNorm] = { OPAQUE, alpha },
	[SchemeSel] = { OPAQUE, alpha },
	[SchemeOut] = { OPAQUE, alpha },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 6;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static unsigned int border_width = 2;

/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
	{ "font",           STRING, &font },
	{ "foreground",     STRING, &normfgcolor },
	{ "background",     STRING, &normbgcolor },
	{ "foreground",     STRING, &selfgcolor },
	{ "color1",         STRING, &selbgcolor },
	{ "color1",         STRING, &bordercolor },
/*	{ "prompt",         STRING, &prompt }, */
/*  { "alpha",          FLOAT,  &alpha }, */
};

