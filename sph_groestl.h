#ifndef SPH_GROESTL_H
#define SPH_GROESTL_H
#include <stddef.h>
typedef struct { unsigned char dummy; } sph_groestl512_context;
static inline void sph_groestl512_init(sph_groestl512_context *ctx) {(void)ctx;}
static inline void sph_groestl512(sph_groestl512_context *ctx, const void *data, size_t len) {(void)ctx;(void)data;(void)len;}
static inline void sph_groestl512_close(sph_groestl512_context *ctx, void *dst) {(void)ctx;(void)dst;}
#endif
