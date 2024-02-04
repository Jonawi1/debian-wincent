/*
 * Safe versions of a number of functions, these fuctions
 * check if any error occured when runnig the original function.
 * 
 * @file safe_functions.c
 * @author Jonatan Wincent (c22jwt)
 * @date 2023-10-17
 */
#include "safe_functions.h"

/**
 * Start a new thread and handle errors.
 *
 * @param thread        A pointer to a buffer where the id of the new thread 
 *                      will be stored.
 * @param attr          Attributes to use when creating the new thread or NULL 
 *                      to use default attributes.
 * @param start_routine A pointer to the function to start execution of the new
 *                      thread in.
 * @param arg           The argument passed to start_routine.
 */
void safe_pthread_create(pthread_t *thread, const pthread_attr_t *attr,
                         void *(*start_routine)(void *), void *arg) {
    errno = 0;
    errno = pthread_create(thread, attr, start_routine, arg);
    if (errno != 0) {
        perror("pthread_create");
        exit(EXIT_FAILURE);
    }
}

/**
 * Wait for and then join a thread, with error handling.
 *
 * @param thread    The thread to join with.
 * @param retval    Returns a copy of the treads exit status.
 */
void safe_pthread_join(pthread_t thread, void **retval) {
    errno = 0;
    errno = pthread_join(thread, retval);
    if (errno != 0) {
        perror("pthread_join");
        exit(EXIT_FAILURE);
    }
}
