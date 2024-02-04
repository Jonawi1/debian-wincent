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

/*
 * @param packages null terminated list of packages
 */
void
*installpackages(void *packages)
{
    int cmdlen = 20, i;
    char **pkgs = (char**)packages;
    char **cmd = safe_calloc(cmdlen, sizeof(char*));

    cmd[0] = "sudo";
    cmd[1] = "apt-get";
    cmd[2] = "install";
    cmd[3] = "-y";

    i = 0;
    while (pkgs[i] != NULL) {
        if (i >= cmdlen - 5) {
            cmdlen += 20;
            cmd = safe_realloc(cmd, cmdlen * sizeof(char*));
        }

        int size = strlen(pkgs[i]) * sizeof(char) + 1;
        cmd[i + 4] = (char*)safe_malloc(size);
        strcpy(cmd[i + 4], pkgs[i]);
        i++;
    }
    cmd[i + 4] = (char*)NULL;

    pthread_mutex_lock(&aptlock);
    pid_t p = fork();
    if (p == 0) {
        if (execvp(cmd[0], cmd) == -1) {
            perror("execvp");
            exit(EXIT_FAILURE);
        }
    }

    for (i = 4; cmd[i] != NULL; i++) {
        free(cmd[i]);
    }
    free(cmd);

    waitpid(p, NULL, 0);
    pthread_mutex_unlock(&aptlock);

    return EXIT_SUCCESS;
}

void
jointhreads(pthread_t *threads, int nthreads)
{
    for (int i = 0; i < nthreads; i++) {
        safe_pthread_join(threads[i], NULL);
    }
}


int 
main(void)
{
    int nthreads = 0;
    pthread_t *threads = calloc(1, sizeof(pthread_t));

    nthreads++;
    threads = safe_realloc(threads, nthreads * sizeof(pthread_t));
    safe_pthread_create(&threads[nthreads-1], NULL, &installpackages, packages);

    nthreads++;
    threads = safe_realloc(threads, nthreads * sizeof(pthread_t));
    safe_pthread_create(&threads[nthreads-1], NULL, &buildsuckless, NULL);

    jointhreads(threads, nthreads);
    free(threads);

    printf("\nReboot to complete the installation\n");

    return EXIT_SUCCESS;
}
