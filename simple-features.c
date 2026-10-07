#include "simple-features.h"
#include "version.h"

const char version_and_features[] =
    "version: " SIMPLE_VERSION

#if defined(SIMPLE_PGO_ENABLED) && SIMPLE_PGO_ENABLED
    " +pgo"
#else
    " -pgo"
#endif

#if defined(SIMPLE_IME_ENABLED) && SIMPLE_IME_ENABLED
    " +ime"
#else
    " -ime"
#endif

#if defined(SIMPLE_GRAPHEME_CLUSTERING) && SIMPLE_GRAPHEME_CLUSTERING
    " +graphemes"
#else
    " -graphemes"
#endif

#if !defined(NDEBUG)
    " +assertions"
#else
    " -assertions"
#endif
;
