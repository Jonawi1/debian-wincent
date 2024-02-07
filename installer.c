/* See LICENSE file for copyright and license details. */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>
#include <pthread.h>

#include "config.h"
#include "safe_memory.h"
#include "safe_functions.h"

/* function declarations */
static void *buildsuckless(void*);
static void *installpackages(void *pkgs);
static void jointhreads(pthread_t *threads, int nthreads);

/* variables */
pthread_mutex_t aptlock;

/* function implementations */
void
*buildsuckless(void* v)
{
    const char *dependencies[] = {
        "build-essential",
        "libx11-dev",
        "libxft-dev",
        "libxinerama-dev",
        "xorg",
        NULL
    };
    char *programs[] = {
        "dwm", "st", "dmenu", "slstatus", "wmname", NULL};

    installpackages(dependencies);

    int i = 0;
    while (programs[i] != NULL) {
        pid_t p = fork();
        if (p == 0) {
            if (chdir(programs[i]) != 0) {
                perror("chdir");
                exit(EXIT_FAILURE);
            }
            if (execlp("sudo", "sudo", "make", "clean", "install",
                        (char *) NULL) == -1) {
                perror("execlp");
                exit(EXIT_FAILURE);
            }
        }
        waitpid(p, NULL, 0);
        i++;
    }

    return EXIT_SUCCESS;
}
