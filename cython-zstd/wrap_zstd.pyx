# -*- python -*-
"""
unsigned ZSTD_isError(size_t code);   /*!< tells if a `size_t` function result is an error code */

size_t ZSTD_compressBound(size_t srcSize); /*!< maximum compressed size in worst case single-pass scenario */

/*! ZSTD_compress() :
 *  Compresses `src` content as a single zstd compressed frame into already allocated `dst`.
 *  Hint : compression runs faster if `dstCapacity` >=  `ZSTD_compressBound(srcSize)`.
 *  @return : compressed size written into `dst` (<= `dstCapacity),
 *            or an error code if it fails (which can be tested using ZSTD_isError()). */
size_t ZSTD_compress( void* dst, size_t dstCapacity,
                const void* src, size_t srcSize,
                      int compressionLevel);

/*! ZSTD_decompress() :
 *  `compressedSize` : must be the _exact_ size of some number of compressed and/or skippable frames.
 *  `dstCapacity` is an upper bound of originalSize to regenerate.
 *  If user cannot imply a maximum upper bound, it's better to use streaming mode to decompress data.
 *  @return : the number of bytes decompressed into `dst` (<= `dstCapacity`),
 *            or an errorCode if it fails (which can be tested using ZSTD_isError()). */
size_t ZSTD_decompress( void* dst, size_t dstCapacity,
                  const void* src, size_t compressedSize);
"""

import numpy as np

cdef extern from "zstd.h":
    unsigned ZSTD_isError(size_t code)

    size_t ZSTD_compressBound(size_t srcSize)

    size_t ZSTD_compress(unsigned char *dst, size_t dstCapacity,
                         const unsigned char *src, size_t srcSize,
                         int compressionLevel)

    size_t ZSTD_decompress(unsigned char* dst, size_t dstCapacity,
                           const unsigned char* src, size_t compressedSize);

# Compose compress(), decompress() here!
