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

def _compress(const unsigned char[::1] data not None, size_t data_len, compression_level=0):
    cdef size_t dest_size = ZSTD_compressBound(data_len)

    dest = np.empty(dest_size, dtype=np.uint8)
    cdef unsigned char[::1] dest_view = dest

    cdef size_t ret
    ret = ZSTD_compress(&dest_view[0], dest_size, &data[0], data_len, compression_level)
    del dest_view

    if ZSTD_isError(ret):
        raise ValueError('failed to compress')

    dest.resize(ret)
    return dest

def compress(data, compression_level=0):
    if isinstance(data, str):
        data = data.encode()
    c = _compress(data, len(data), compression_level=compression_level)
    return bytes(c)

def decompress(data, max_length=1024*1024):
    dest = np.empty(max_length, dtype=np.uint8)
    cdef unsigned char[::1] dest_view = dest

    cdef const unsigned char[::1] data_view = data
    cdef size_t data_len = len(data)

    cdef size_t ret
    ret = ZSTD_decompress(&dest_view[0], max_length, &data_view[0], data_len)
    del data_view, dest_view

    if ZSTD_isError(ret):
        raise ValueError('failed to decompress')

    dest.resize(ret)
    return bytes(dest)
