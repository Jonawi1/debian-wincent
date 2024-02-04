/*
 * safe_memory.h - Safe versions of some memory allocations functions, 
 * these fuctions chack that no errors occured when runnig the original function.
 * 
 * Author: Jonatan Wincent (c22jwt)
 *
 * Version information:
 *  v1.0 2023-09-13: First version.
 */
#ifndef SAFE_MEMORY_H
#define SAFE_MEMORY_H

#include <stdio.h>
#include <stdlib.h>

/*
 * safe_malloc() - Allocates size bytes memory and checks for errors.
 * @size: Size of memory to allocate in bytes.
 *
 * Returns: A pointer to the allocated memory.
 *
 * Note: Prints error message and exits on error.
 */
void *safe_malloc(size_t size);

/*
 * safe_calloc() - Allocates nmemb elements of size bytes each and checks for errors.
 * @nmemb: Number of elements to allocate.
 * @size: Size of each element in bytes.
 *
 * Returns: A pointer to the allocated memory.
 *
 * Note: Prints error message and exits on error.
 */
void *safe_calloc(size_t nmemb, size_t size);

/*
 * safe_realloc() - Changes the size of (and possibly moves) a memory block to fit size bytes.
 * Also checks that no errors ocurred.
 * @ptr: Pointer to the memory block to reallocate.
 * @size: Size in bytes.
 *
 * Returns: A pointer to the memory block, might be the same as ptr if the block was not moved or different if it was.
 *
 * Note: Prints error message and exits on error.
 */
void *safe_realloc(void *ptr, size_t size);

#endif
