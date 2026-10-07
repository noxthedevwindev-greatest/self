#include "self-features.h"
#include "version.h"

const char version_and_features[] =
    "version: " SELF_VERSION

#if defined(SELF_PGO_ENABLED) && SELF_PGO_ENABLED
    " +pgo"
#else
    " -pgo"
#endif

#if defined(SELF_IME_ENABLED) && SELF_IME_ENABLED
    " +ime"
#else
    " -ime"
#endif

#if defined(SELF_GRAPHEME_CLUSTERING) && SELF_GRAPHEME_CLUSTERING
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
