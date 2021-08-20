#!/usr/bin/python

import wrap_zstd

print(wrap_zstd)

# Use the docstring as test data
data = wrap_zstd.__doc__
compressed = wrap_zstd.compress(data)

print(f'original data: {len(data.encode())} bytes, compressed data: {len(compressed)} bytes')

decompressed = wrap_zstd.decompress(compressed)

print(f'compressed data: {len(compressed)} bytes, decompressed data: {len(decompressed)} bytes')

if isinstance(decompressed, bytes):
    decompressed = decompressed.decode()

# print(data)
# print(decompressed)

assert len(data) == len(decompressed)
assert data == decompressed
